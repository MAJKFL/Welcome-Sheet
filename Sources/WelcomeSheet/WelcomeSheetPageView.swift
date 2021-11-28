//
//  File.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetPageView: View {
    var page: WelcomeSheetPage
    
    var body: some View {
        VStack(spacing: 45) {
            Text(page.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineSpacing(8)
                .multilineTextAlignment(.center)
                .padding(25)
                .fixedSize(horizontal: false, vertical: true)
            
            VStack(alignment: .midIcons, spacing: 30) {
                ForEach(page.rows) { row in
                    HStack(spacing: 17.5) {
                        row.image
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(row.accentColor ?? Color.accentColor)
                            .frame(width: 37, height: 37)
                            .alignmentGuide(.midIcons) { d in d[HorizontalAlignment.center] }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(row.title)
                                .font(.headline)
                                .lineSpacing(5)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text(row.content)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineSpacing(5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            Spacer()
            
            VStack(spacing: 5) {
                if let optionalButtonTitle = page.optionalButtonTitle {
                    Button(optionalButtonTitle) {
                        if let optionalButtonAction = page.optionalButtonAction { optionalButtonAction() }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(Font.headline.weight(.medium))
                    .foregroundColor(page.accentColor ?? Color.accentColor)
                    .padding()
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        page.accentColor ?? Color.accentColor
                        
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 10)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

extension HorizontalAlignment {
    enum MidIcons: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.leading]
        }
    }

    static let midIcons = HorizontalAlignment(MidIcons.self)
}
