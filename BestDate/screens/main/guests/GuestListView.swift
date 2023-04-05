//
//  GuestListView.swift
//  BestDate
//
//  Created by Евгений on 20.07.2022.
//

import SwiftUI

struct GuestListView: View {
    var items: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    var title: String
    @Binding var list: [Guest]
    @Binding var meta: Meta
    @Binding var lastItemId: Int
    var clickAction: (Guest) -> Void
    var loadNextPage: () -> Void

    @State var showLoadingBlock: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title.localized())
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 20))
                .padding(.init(top: 20, leading: 18, bottom: 10, trailing: 18))

            LazyVGrid(columns: items, alignment: .center, spacing: 10, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(list, id: \.id) { guest in
                    GuestListItemView(guest: guest)
                        .onTapGesture {
                            withAnimation {
                                clickAction(guest)
                            }
                        }
                        .onAppear {
                            if (guest.id ?? 0) == lastItemId && !list.isEmpty {
                                showLoadingBlock = true
                                loadNextPage()
                            }
                        }
                }
            }

            if (meta.current_page ?? 0) < (meta.last_page ?? 0) && showLoadingBlock {
                LoadingNextPageView()
                    .padding(.top, 5)
            }
        }
    }
}

