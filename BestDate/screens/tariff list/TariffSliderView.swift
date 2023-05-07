//
//  TariffSliderView.swift
//  BestDate
//
//  Created by Евгений on 05.03.2023.
//

import SwiftUI

struct TariffSliderView: View {
    private var tariffList: [TariffType] = [.montly, .three_months, .six_months]
    private let itemWidth = UIScreen.main.bounds.width - 105 < CGFloat(323) ? CGFloat(323) : UIScreen.main.bounds.width - 105

    @State var currentPosition: CGFloat = 1

    var items: [GridItem] = [
        GridItem(.flexible(), spacing: 3)]

    var body: some View {
        SaveAndSetPositionHorizontalScrollView(startPosition: currentPosition, offsetChanged: { offset in
            self.currentPosition = -(offset / itemWidth)
        }) {
            LazyHStack(alignment: .center, spacing: 12, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(tariffList, id: \.id) { tariff in
                    TariffItemView(tariff: tariff, width: self.itemWidth)
                        .rotation3DEffect(getRotationAngle(id: tariff.id), axis: (x: 0, y: 1, z: 0))
                        .scaleEffect(getScale(id: tariff.id))
                }
            }.padding(.init(top: 0, leading: 50, bottom: 0, trailing: 50))
        }
    }

    private func getRotationAngle(id: Int) -> Angle {
        return Angle(degrees: -(20 * (currentPosition - CGFloat(id))))
    }

    private func getScale(id: Int) -> CGFloat {
        var offset = currentPosition - CGFloat(id)
        if offset < 0 { offset = -(offset) }

        return (10 - offset) * 0.1
    }
}

struct TariffSliderView_Previews: PreviewProvider {
    static var previews: some View {
        TariffSliderView()
    }
}
