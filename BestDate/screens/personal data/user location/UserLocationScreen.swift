//
//  UserLocationScreen.swift
//  BestDate
//
//  Created by Евгений on 13.10.2022.
//

import SwiftUI

struct UserLocationScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var searchMediator = CitySearchMediator.shared
    @ObservedObject var mediator = UserLocationMediator.shared

    @State var selectedItem: CityListItem? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                BackButton(style: .white)

                Spacer()

                TextButton(text: "save", textColor: ColorList.white.color) {
                    mediator.saveUserLocation(location: selectedItem ?? getDefaultItem()) { success in
                        DispatchQueue.main.async {
                            let message = success ? "save_successfully" : "failed_save_data"
                            store.dispatch(action: .show(message: NSLocalizedString(message, comment: "Message")))
                            withAnimation { store.dispatch(action: .navigationBack) }
                        }
                    }
                }
            }.frame(width: UIScreen.main.bounds.width - 64)
                .padding(.init(top: 32, leading: 32, bottom: 25, trailing: 32))

            Title(textColor: ColorList.white.color, text: "search_location", textSize: 32, paddingV: 0, paddingH: 32)

            SearchInputView(hint: "specify_the_search_location", light: false, input: $searchMediator.searchText)
                .padding(.init(top: 18, leading: 0, bottom: 13, trailing: 0))

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(searchMediator.cityList, id: \.id) { item in
                        Text(item.getCityLine())
                            .foregroundColor(ColorList.white_90.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .frame(width: UIScreen.main.bounds.width - 64, height: 48, alignment: .leading)
                            .onTapGesture {
                                selectedItem = item
                                searchMediator.searchText = item.getCityLine()
                            }
                    }
                }
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

            HStack(spacing: 4) {
                Text("powered by")
                    .foregroundColor(ColorList.white_60.color)
                    .font(MyFont.getFont(.NORMAL, 16))
                Text("Google")
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 18))
            }.frame(width: UIScreen.main.bounds.width)
                .padding(.init(top: 8, leading: 0, bottom: 16 + store.state.statusBarHeight, trailing: 0))
        }
        .background(ColorList.main.color)
        .onAppear {
            searchMediator.initSearch()
            selectedItem = getDefaultItem()
            searchMediator.searchText = selectedItem?.getCityLine() ?? ""
        }
    }

    private func getDefaultItem() -> CityListItem {
        CityListItem(id: 0,
                     country: MainMediator.shared.user.location?.country,
                     city: MainMediator.shared.user.location?.city ?? "")
    }
}

struct UserLocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationScreen()
    }
}
