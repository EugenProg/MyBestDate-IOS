//
//  NoDataView.swift
//  BestDate
//
//  Created by Евгений on 20.07.2022.
//

import SwiftUI

struct NoDataView: View {
    var body: some View {
        LottieView(name: "no_data")
            .frame(width: 150, height: 150)
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView()
    }
}
