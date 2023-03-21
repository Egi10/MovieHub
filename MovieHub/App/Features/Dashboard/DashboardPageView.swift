//
//  DashboardPageView.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import SwiftUI

struct DashboardPageView: View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoritePageView()
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
            
            ProfilePageView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct DashboardPageView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardPageView()
    }
}
