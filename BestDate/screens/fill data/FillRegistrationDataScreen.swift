//
//  FillRegistrationDataScreen.swift
//  BestDate
//
//  Created by Евгений on 25.09.2022.
//

import SwiftUI

struct FillRegistrationDataScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = FillRegistrationDataMediator.shared
    @State private var offsetValue: CGFloat = 0.0

    @State var nameInputError: Bool = false
    @State var genderInputError: Bool = false
    @State var process: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: "fill_the_required_data", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 18))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: false) {

                StandardInputView(hint: "name", imageName: "ic_user", inputText: $mediator.name, errorState: $nameInputError)
                    .padding(.top, 16)

                InfoView(hint: "gender", imageName: "ic_gender", infoText: $mediator.gender, errorState: $genderInputError) { store.dispatch(action: .showBottomSheet(view: .GENDER)) }

                DateSelectView(hint: "birth_date", imageName: "ic_calendar", date: $mediator.birthday)

                StandardButton(style: .white, title: "next", loadingProcess: $process) {
                    validate()
                }.padding(.init(top: 16, leading: 0, bottom: 25, trailing: 0))

            }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }.padding(.init(top: offsetValue / 2, leading: 0, bottom: 0, trailing: 0))
        .keyboardTopOffset($offsetValue)
        .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }

    private func validate() {
        if mediator.name.isEmpty { nameInputError = true }
        else if mediator.gender.isEmpty { genderInputError = true }
        else {
            process = true
            mediator.saveData {
                DispatchQueue.main.async {
                    process = false
                    UserDataHolder.setStartScreen(screen: .GEO_LOCATION)
                    withAnimation { store.dispatch(action: .navigate(screen: .GEO_LOCATION)) }
                }
            }
        }
    }
}

struct FillRegistrationDataScreen_Previews: PreviewProvider {
    static var previews: some View {
        FillRegistrationDataScreen()
    }
}
