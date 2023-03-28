//
//  TariffSliderView.swift
//  BestDate
//
//  Created by Евгений on 05.03.2023.
//

import SwiftUI

struct TariffSliderView: View {
    private var tariffList: [TariffType] = [.montly, .three_months, .six_months]

    var items: [GridItem] = [
        GridItem(.flexible(), spacing: 3)]

    var body: some View {
//        ScrollViewReader { proxy in
//            ScrollView(.horizontal, showsIndicators: false) {
//                LazyHStack(alignment: .center, spacing: 12, pinnedViews: [.sectionHeaders, .sectionFooters]) {
//                    ForEach(tariffList, id: \.id) { tariff in
//                        TariffItemView(tariff: tariff)
//                            .opacity(tariff.id != 1 ? 0.5 : 1)
//                    }
//                }.padding(.init(top: 0, leading: 50, bottom: 0, trailing: 50))
//            }
//            .onAppear {
//                proxy.scrollTo(1, anchor: .center)
//            }
//        }

        TabView {
            TariffItemView(tariff: .montly)
            TariffItemView(tariff: .three_months)
            TariffItemView(tariff: .six_months)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct TariffSliderView_Previews: PreviewProvider {
    static var previews: some View {
        TariffSliderView()
    }
}
