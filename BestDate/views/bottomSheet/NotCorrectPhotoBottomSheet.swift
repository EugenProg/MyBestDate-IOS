//
//  NotCorrectPhotoBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 23.06.2022.
//

import SwiftUI

struct NotCorrectPhotoBottomSheet: View {

    @State var process: Bool = false
    var clickAction: () -> Void

    fileprivate func reasonsItem(text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(NSLocalizedString(text, comment: "text"))
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 20))

                Spacer()

                Image("ic_close")
            }.padding(.init(top: 0, leading: 14, bottom: 0, trailing: 14))
            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(height: 1)

        }.frame(width: UIScreen.main.bounds.width - 36, height: 61)
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "photo_is_not_correct", textSize: 32, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 2, trailing: 0))

            HeaderText(textColor: ColorList.white_70.color, text: "we_cannot_accept_this_photo_for_one_of_the_following_reasons")
                .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 0))

            reasonsItem(text: "i_can_t_see_your_face")
            reasonsItem(text: "you_are_too_far_away")
            reasonsItem(text: "not_a_person_s_face")

            Text(NSLocalizedString("recommendation", comment: "recommenadation"))
                .foregroundColor(ColorList.white_70.color)
                .font(MyFont.getFont(.NORMAL, 14))
                .padding(.init(top: 50, leading: 24, bottom: 16, trailing: 24))

            Text(NSLocalizedString("upload_photos_where_only_you_are_alone_and_at_a_close_distance_so_that_your_face_is_clearly_visible", comment: "recommenadation"))
                .foregroundColor(ColorList.white_70.color)
                .font(MyFont.getFont(.NORMAL, 14))
                .lineSpacing(8)
                .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 24))

            StandardButton(style: .white, title: "ok", loadingProcess: $process) {
                clickAction()
            }.padding(.init(top: 50, leading: 0, bottom: 22, trailing: 0))
        }
    }
}

struct NotCorrectPhotoBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        NotCorrectPhotoBottomSheet { }
    }
}
