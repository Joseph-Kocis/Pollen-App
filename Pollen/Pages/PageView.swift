//
//  PageView.swift
//  Pollen
//
//  Created by Jody Kocis on 4/28/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import SwiftUI
import UIKit

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @Binding var currentPage: Int
    
    init(_ views: [UIHostingController<Page>], currentPage: Binding<Int>) {
        self._currentPage = currentPage
        self.viewControllers = views
    }
    
    init(_ views: [Page], currentPage: Binding<Int>) {
        self._currentPage = currentPage
        self.viewControllers = views.map {
            return UIHostingController(rootView: $0)
        }
    }

    var body: some View {
        if (self.viewControllers.count > 0) {
            return AnyView(VStack {
                PageViewController(
                    controllers: self.viewControllers,
                    currentPage: self.$currentPage
                )
            })
        }
        return AnyView(VStack {
            Spacer()
            Text("Error: Results Not Fetched")
            Spacer()
        })
    }
}

struct PageView_Previews: PreviewProvider {
    @State static var page = 0
    static var previews: some View {
        PageView([Text("Testing")], currentPage: $page)
    }
}

