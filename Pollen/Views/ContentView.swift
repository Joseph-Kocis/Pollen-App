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
        Text("\(networkManager.pollenModel.first?.grassPollenData.amount.description ?? "nil")")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
