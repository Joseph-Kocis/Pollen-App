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
        Text("\(networkManager.pollenModel.first?.grassPollenData.amount.description ?? "nil")")
    }
}

struct PollenPageView_Previews: PreviewProvider {
    static var previews: some View {
        PollenPageView(networkManager: NetworkManager(shouldUseNetwork: false))
    }
}
