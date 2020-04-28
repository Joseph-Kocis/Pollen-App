//
//  ContentView.swift
//  Pollen
//
//  Created by Jody Kocis on 4/27/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack {
                // Date Selection
                PollenPageView(networkManager: networkManager)
                // Footer
            }.onAppear() {
                // TODO: -- Refresh the pollenData if necessary
                // Verify that onAppear is called at the appropriate times
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
