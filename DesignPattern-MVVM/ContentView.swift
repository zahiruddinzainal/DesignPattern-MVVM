//
//  ContentView.swift
//  DesignPattern-MVVM
//
//  Created by Luminous Latte on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ItemListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Items")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}
