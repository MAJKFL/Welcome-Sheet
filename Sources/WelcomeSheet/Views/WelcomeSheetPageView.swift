//
//  WelcomeSheetPageView.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetPageView: View {
    @Environment(\.showingSheet) var showingSheet
    
    let page: WelcomeSheetPage
    let restPages: [WelcomeSheetPage]
    
    let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        if #available(iOS 14.0, *) {
            content
                .ignoresSafeArea(.all, edges: .top)
        } else {
            content
                .edgesIgnoringSafeArea(.top)
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: iPhoneDimensions.spacing) {
                    Text(page.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineSpacing(8)
                        .multilineTextAlignment(.center)
                        .padding(.top, iPhoneDimensions.topPadding - (isiPad ? 15 : 0))
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityHeading(.h1)
                    
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
                                    .accessibilityHidden(true)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(row.title)
                                        .font(.headline)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    Text(row.content)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                            .padding(.horizontal, 20 + iPhoneDimensions.horizontalPaddingAddend)
                            .accessibilityElement(children: .combine)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.horizontal, isiPad ? 45 : 0)
            }
            .scrollOnlyOnOverflow()
            
            VStack(spacing: 5) {
                if page.isShowingOptionalButton {
                    if let optionalButtonTitle = page.optionalButtonTitle {
                        Button(optionalButtonTitle) {
                            if let optionalButtonAction = page.optionalButtonAction { optionalButtonAction() }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .font(Font.headline.weight(.medium))
                        .foregroundColor(page.accentColor ?? Color.accentColor)
                        .padding(.top)
                    }
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
                        .frame(width: isiPad ? iPadSheetDimensions.width / 1.7 : nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                    .padding(.top)
                } else {
                    Button {
                        showingSheet?.wrappedValue = false
                    } label: {
                        ZStack {
                            page.accentColor ?? Color.accentColor
                            
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(width: isiPad ? iPadSheetDimensions.width / 1.7 : nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                    .padding(.top)
                }
            }
            .padding(.horizontal, 15 + iPhoneDimensions.horizontalPaddingAddend)
            .padding(.bottom, 60)
        }
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
