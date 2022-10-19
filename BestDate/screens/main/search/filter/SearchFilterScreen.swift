//
//  SearchFilterView.swift
//  BestDate
//
//  Created by Евгений on 11.10.2022.
//

import SwiftUI

struct SearchFilterScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = CitySearchMediator.shared
    @State var distance: Int = SearchMediator.shared.searchFilter?.location.range ?? 150
    @State private var offsetValue: CGFloat = 0.0

    @State var selectedItem: CityListItem? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                BackButton(style: .white)

                Spacer()

                TextButton(text: "save", textColor: ColorList.white.color) {
                    SearchMediator.shared.setSearchFilter(address: selectedItem ?? getDefaultItem(), range: distance)
                    store.dispatch(action: .navigationBack)
                }
            }.frame(width: UIScreen.main.bounds.width - 64)
                .padding(.init(top: 32, leading: 32, bottom: 25, trailing: 32))

            Title(textColor: ColorList.white.color, text: "search_location", textSize: 32, paddingV: 0, paddingH: 32)

            SearchInputView(hint: "specify_the_search_location", light: false, input: $mediator.searchText)
                .padding(.init(top: 18, leading: 0, bottom: 13, trailing: 0))

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(mediator.cityList, id: \.id) { item in
                        Text(item.getCityLine())
                            .foregroundColor(ColorList.white_90.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .frame(width: UIScreen.main.bounds.width - 64, height: 48, alignment: .leading)
                            .onTapGesture {
                                selectedItem = item
                                mediator.searchText = item.getCityLine()
                            }
                    }
                }
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

            Title(textColor: ColorList.white.color, text: "search_distance", textSize: 32, paddingV: 0, paddingH: 32)

            Text(NSLocalizedString("possibility_from_to_km", comment: "Distance"))
                .foregroundColor(ColorList.white_30.color)
                .font(MyFont.getFont(.BOLD, 18))
                .frame(width: UIScreen.main.bounds.width - 64, alignment: .leading)
                .padding(.init(top: 8, leading: 32, bottom: 0, trailing: 32))

            DistanceBarView(number: $distance)

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
        .padding(.init(top: offsetValue / 2, leading: 0, bottom: 0, trailing: 0))
        .keyboardTopOffset($offsetValue)
        .background(ColorList.main.color)
        .onAppear {
            mediator.initSearch()
            setData()
            mediator.searchText = selectedItem?.getCityLine() ?? ""
        }
    }

    private func setData() {
        if SearchMediator.shared.searchFilter != nil {
            selectedItem = CityListItem(id: 0,
                         country: SearchMediator.shared.searchCity?.country,
                         city: SearchMediator.shared.searchCity?.city ?? "")
        } else {
            selectedItem = getDefaultItem()
        }
        mediator.searchText = selectedItem?.getCityLine() ?? ""
    }

    private func getDefaultItem() -> CityListItem {
        CityListItem(id: 0,
                     country: MainMediator.shared.user.location?.country,
                     city: MainMediator.shared.user.location?.city ?? "")
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterScreen()
    }
}
