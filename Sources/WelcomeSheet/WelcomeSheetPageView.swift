//
//  File.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetPageView: View {
    let page: WelcomeSheetPage
    let restPages: [WelcomeSheetPage]
    
    let screenHeight = UIScreen.main.bounds.height
    
    var spacing: CGFloat {
        if screenHeight == 812 || screenHeight < 736 {
            return 30
        } else {
            return 60
        }
    }
    
    var topPadding: CGFloat {
        if screenHeight == 568 {
            return 50
        } else if screenHeight <= 736 {
            return 60
        } else {
            return 80
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: spacing) {
                    Text(page.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineSpacing(8)
                        .multilineTextAlignment(.center)
                        .padding(.top, topPadding)
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
            .padding(.horizontal, 15)
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
