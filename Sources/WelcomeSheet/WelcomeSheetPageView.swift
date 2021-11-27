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
        VStack {
            Spacer()
            
            Text(page.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            VStack(alignment: .midIcons, spacing: 25) {
                ForEach(page.rows) { row in
                    HStack {
                        row.image
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(row.accentColor ?? Color.accentColor)
                            .frame(width: 40, height: 40)
                            .padding()
                            .alignmentGuide(.midIcons) { d in d[HorizontalAlignment.center] }
                        
                        VStack(alignment: .leading) {
                            Text(row.title)
                                .font(.headline)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text(row.content)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            
            Spacer()
            
            if let optionalButtonTitle = page.optionalButtonTitle {
                Button(optionalButtonTitle) {
                    if let optionalButtonAction = page.optionalButtonAction { optionalButtonAction() }
                }
            }
            
            Button {
                
            } label: {
                Text("Continue")
            }
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
