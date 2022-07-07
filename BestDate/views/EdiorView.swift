//
//  EdiorScreenView.swift
//  BestDate
//
//  Created by Евгений on 19.06.2022.
//

import SwiftUI

struct EdiorView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = PhotoEditorMediator.shared
    var backgroundColor: Color
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    fileprivate func angles(size: CGFloat) -> some View {
        ZStack {
            Path { p in
                p.move(to: CGPoint(x: 0, y: 0))
                p.addLine(to: CGPoint(x: 14, y: 0))
                p.addLine(to: CGPoint(x: 0, y: 14))
                p.addLine(to: CGPoint(x: 0, y: 0))
            }.fill(backgroundColor)
            
            Path { p in
                p.move(to: CGPoint(x: 0, y: size))
                p.addLine(to: CGPoint(x: 14, y: size))
                p.addLine(to: CGPoint(x: 0, y: size - 14))
                p.addLine(to: CGPoint(x: 0, y: size))
            }.fill(backgroundColor)
            
            Path { p in
                p.move(to: CGPoint(x: size, y: 0))
                p.addLine(to: CGPoint(x: size - 14, y: 0))
                p.addLine(to: CGPoint(x: size, y: 14))
                p.addLine(to: CGPoint(x: size, y: 0))
            }.fill(backgroundColor)
            
            Path { p in
                p.move(to: CGPoint(x: size, y: size))
                p.addLine(to: CGPoint(x: size - 14, y: size))
                p.addLine(to: CGPoint(x: size, y: size - 14))
                p.addLine(to: CGPoint(x: size, y: size))
            }.fill(backgroundColor)
        }
    }
    
    var body: some View {
        ZStack {
            /*
             Image layout
             */
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(ColorList.white.color)

                PhotoViewer(image: mediator.newPhoto, currentZoom: $mediator.zoom, currentOffset: $mediator.offset, frameSize: mediator.frame)
                    .frame(width: width - 14, height: width - 14)
                    .padding(.init(top: 0, leading: 7, bottom: 0, trailing: 7))
            }

                /*
                 Frame layout
                 */
            VStack(spacing: 0) {
                let offset = (height - (width - 14)) / 2
                Rectangle()
                    .fill(backgroundColor)
                    .frame(width: width, height: offset)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 33)
                        .stroke(backgroundColor, lineWidth: 14)
                    
                    angles(size: width)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(backgroundColor, lineWidth: 5)
                        .frame(width: width - 32, height: width - 32)
        
                }.frame(width: width, height: width)
                
                Rectangle()
                    .fill(backgroundColor)
                    .frame(width: width, height: offset)
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        VStack {
            Rectangle()
                .fill(backgroundColor)
                .frame(height: 50)
            Spacer()
        }.edgesIgnoringSafeArea(.top)
    }
}
