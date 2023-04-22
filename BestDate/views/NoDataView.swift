//
//  NoDataView.swift
//  BestDate
//
//  Created by Евгений on 20.07.2022.
//

import SwiftUI

struct NoDataView: View {
    @Binding var loadingMode: Bool

    var body: some View {
        if loadingMode {
            LoadingDotsView()
        }
    }
}

