//
//  File.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetPageView: View {
    @Environment(\.showingSheet) var showingSheet
    
    let page: WelcomeSheetPage
    let restPages: [WelcomeSheetPage]
    
    let screenHeight = UIScreen.main.bounds.height
    
    var spacing: CGFloat {
        if screenHeight == 812 || screenHeight < 736 { // iPhone mini, Smaller than iPhone plus
            return 30
        } else { // The rest
            return 60
        }
    }
    
    var topPadding: CGFloat {
        if screenHeight == 568 { // iPhone SE 1st gen
            return 50
        } else if screenHeight <= 736 { // Smaller than iPhone plus
            return 60
        } else { // The rest
            return 80
        }
    }
    
    var horizontalPaddingAddend: CGFloat {
        if screenHeight >= 896 || screenHeight == 736 { // iPhone pro max, iPhone plus
            return 20
        } else if screenHeight == 568 { // iPhone SE 1st gen
            return -10
        } else { // The rest
            return 0
        }
    }
    
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
                            .padding(.horizontal, 20 + horizontalPaddingAddend)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .scrollOnlyOnOverflow()
            
            VStack(spacing: 5) {
                if let optionalButtonTitle = page.optionalButtonTitle {
                    Button(optionalButtonTitle) {
                        if let optionalButtonAction = page.optionalButtonAction { optionalButtonAction() }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(Font.headline.weight(.medium))
                    .foregroundColor(page.accentColor ?? Color.accentColor)
                    .padding(.top)
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
                    .padding(.top)
                } else {
                    Button {
                        showingSheet?.wrappedValue.toggle()
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
                    .padding(.top)
                }
            }
            .padding(.horizontal, 15 + horizontalPaddingAddend)
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
