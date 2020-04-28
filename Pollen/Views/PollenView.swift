//
//  PollenView.swift
//  Pollen
//
//  Created by Jody Kocis on 4/28/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct PollenView: View {
    var pollenModel: PollenModel
    var informationViews: [PollenInformationView]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pollenModel.date.formattedDate())
                .font(.largeTitle)
                .bold()
                .padding(.leading, 15)
                .padding(.top, 15)
                .padding(.bottom, 30)
            
            ForEach(informationViews.startIndex..<informationViews.endIndex) { index in
                Group<AnyView> {
                    if index == self.informationViews.endIndex - 1 {
                        return AnyView(Group {
                            self.informationViews[index]
                                .padding(.bottom, 15)
                        })
                    } else {
                        return AnyView(Group {
                            self.informationViews[index]
                            Spacer()
                        })
                    }
                }
            }
            
            
        }
    }
}
