//
//  File.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetPageView: View {
    var page: WelcomeSheetPage
    var restPages: [WelcomeSheetPage]
    
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 60) {
                    Text(page.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineSpacing(8)
                        .multilineTextAlignment(.center)
                        .padding(.top, 80)
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
                            .padding(.horizontal, screenHeight == 568 ? 10 : 20)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
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
                
                if let nextPage = restPages.first {
                    NavigationLink {
                        WelcomeSheetPageView(page: nextPage, restPages: restPages.filter({ $0.id != nextPage.id }))
                    } label: {
                        ZStack {
                            page.accentColor ?? Color.accentColor
                            
                            Text("Continue")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                } else {
                    Button {
                        
                    } label: {
                        ZStack {
                            page.accentColor ?? Color.accentColor
                            
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                }
            }
            .padding(.horizontal, screenHeight == 568 ? 10 : 15)
            .padding(.bottom, 60)
        }
        .ignoresSafeArea(.all, edges: .top)
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
