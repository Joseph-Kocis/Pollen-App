//
//  PollenPageView.swift
//  Pollen
//
//  Created by Jody Kocis on 4/28/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct PollenPageView: View {
    @ObservedObject var networkManager: NetworkManager
    @State var dateIndex = 0
    
    @State var hasAnimated = false
    @State var informationViewsAnimated: [PollenType: Bool] = [.grass: false, .mold: false, .tree: false, .ragweed: false]
    // TODO: -- reset the animation when the view disappears
    
    var body: some View {
        let views: [UIHostingController<PollenView>] = self.networkManager.pollenModel.map { pollenModel in
            let informationViews: [PollenInformationView] = [
                PollenInformationView(
                    data: pollenModel.grassPollenData,
                    hasAnimated: $hasAnimated,
                    informationViewsAnimated: $informationViewsAnimated
                ),
                PollenInformationView(
                    data: pollenModel.moldPollenData,
                    hasAnimated: $hasAnimated,
                    informationViewsAnimated: $informationViewsAnimated
                ),
                PollenInformationView(
                    data: pollenModel.treePollenData,
                    hasAnimated: $hasAnimated,
                    informationViewsAnimated: $informationViewsAnimated
                ),
                PollenInformationView(
                    data: pollenModel.ragweedPollenData,
                    hasAnimated: $hasAnimated,
                    informationViewsAnimated: $informationViewsAnimated
                )
            ]
            let pollenView = PollenView(pollenModel: pollenModel, informationViews: informationViews)
            
            return UIHostingController(rootView: pollenView)
        }
        
        return PageView(views, currentPage: $dateIndex)
    }
}

struct PollenPageView_Previews: PreviewProvider {
    static var previews: some View {
        PollenPageView(networkManager: NetworkManager(shouldUseNetwork: false))
    }
}
