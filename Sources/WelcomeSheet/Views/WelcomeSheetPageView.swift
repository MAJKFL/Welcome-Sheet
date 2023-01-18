//
//  WelcomeSheetPageView.swift
//
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetPageView: View {
    let page: WelcomeSheetPage
    let restPages: [WelcomeSheetPage]
    let onDismiss: () -> Void
    
    let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    @State private var optionalView: AnyView?
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: iPhoneDimensions.spacing) {
                    HStack {
                        Spacer()
                        
                        if #available(iOS 15.0, *) {
                            Text(page.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .lineSpacing(8)
                                .multilineTextAlignment(.center)
                                .padding(.top, iPhoneDimensions.topPadding - (isiPad ? 15 : 0))
                                .fixedSize(horizontal: false, vertical: true)
                                .accessibilityHeading(.h1)
                        } else {
                            Text(page.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .lineSpacing(8)
                                .multilineTextAlignment(.center)
                                .padding(.top, iPhoneDimensions.topPadding - (isiPad ? 15 : 0))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Spacer()
                    }
                    
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
                                    .accessibility(hidden: true)
                                
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
                                
                                Spacer()
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
                            if let view = page.optionalButtonView {
                                optionalView = view
                            } else if let action = page.optionalButtonAction {
                                action()
                            } else if let url = page.optionalButtonURL {
                                UIApplication.shared.open(url)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .font(Font.headline.weight(.medium))
                        .foregroundColor(page.accentColor ?? Color.accentColor)
                        .padding(.top)
                    }
                }
                
                if let nextPage = restPages.first {
                    NavigationLink {
                        WelcomeSheetPageView(page: nextPage, restPages: restPages.filter({ $0.id != nextPage.id }), onDismiss: onDismiss)
                    } label: {
                        ZStack {
                            page.accentColor ?? Color.accentColor
                            
                            Text(page.mainButtonTitle)
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
                        onDismiss()
                    } label: {
                        ZStack {
                            page.accentColor ?? Color.accentColor
                            
                            Text(page.mainButtonTitle)
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
            .sheet(item: $optionalView) { view in
                view.edgesIgnoringSafeArea(.all)
            }
        }
        .background(
            page.backgroundColor.edgesIgnoringSafeArea(.all)
        )
        .edgesIgnoringSafeArea(.top)
    }
}
