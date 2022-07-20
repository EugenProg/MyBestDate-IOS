//
//  GuestListView.swift
//  BestDate
//
//  Created by Евгений on 20.07.2022.
//

import SwiftUI

struct GuestListView: View {
    var items: [GridItem] = [
            GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    var title: String
    @Binding var list: [Guest]
    var clickAction: (Guest) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(NSLocalizedString(title, comment: "Title"))
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
                }
            }
        }
    }
}

