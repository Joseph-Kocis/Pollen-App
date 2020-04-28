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
    
    var body: some View {
        let views: [UIHostingController<PollenView>] = self.networkManager.pollenModel.map { pollenModel in
            let informationViews: [PollenInformationView] = [
                PollenInformationView(data: pollenModel.grassPollenData),
                PollenInformationView(data: pollenModel.moldPollenData),
                PollenInformationView(data: pollenModel.treePollenData),
                PollenInformationView(data: pollenModel.ragweedPollenData)
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
