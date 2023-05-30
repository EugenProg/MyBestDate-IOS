//
//  SubscriptionManager.swift
//  BestDate
//
//  Created by Евгений on 27.05.2023.
//

import Foundation
import StoreKit

class SubscriptionManager: ObservableObject {
    static var shared = SubscriptionManager()

    private var productIds: [String] = ["monthly_plan", "three_months_plan", "six_months_plan"]

    private var products: [Product] = []
    @Published private(set) var purchasedProducts = Set<TransactionInfo>()

    private var updates: Task<Void, Never>? = nil
    private var productsLoaded = false

    init() {
        updates = observeTransactionUpdates()
    }

    deinit {
        updates?.cancel()
    }

    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
    }

    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()

        switch result {
        case let .success(.verified(transaction)):
            // Successful purhcase
            await transaction.finish()
            await self.updateSubscriptionsProducts()
        case .success(.unverified(_, _)):
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
            break
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            break
        case .userCancelled:
            // ^^^
            break
        @unknown default:
            break
        }
    }

    func updateSubscriptionsProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }

            let transactionInfo = TransactionInfo(startDate: transaction.purchaseDate, endDate: transaction.expirationDate)
            if transaction.revocationDate == nil {
                self.purchasedProducts.insert(transactionInfo)
            } else {
                self.purchasedProducts.remove(transactionInfo)
            }
        }

        UserDataHolder.shared.setActiveSubscription(active: !self.purchasedProducts.isEmpty)
        updateServerInfo()
    }

    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await _ in Transaction.updates {
                await self.updateSubscriptionsProducts()
            }
        }
    }

    private func updateServerInfo() {
        if !self.purchasedProducts.isEmpty {
            let activeTransaction = self.purchasedProducts[self.purchasedProducts.endIndex]
            let startDate = activeTransaction.startDate.toLongServerDate()
            let endDate = activeTransaction.endDate?.toLongServerDate() ?? Date().toLongServerDate()
            SubscriptionApiService.shared.updateSubscriptionInfo(startDate: startDate, endDate: endDate)
        }
    }

    func getProductById(id: String) -> Product? {
        products.first { product in
            product.id == id
        }
    }
}

struct TransactionInfo: Hashable {
    var startDate: Date
    var endDate: Date?
}
