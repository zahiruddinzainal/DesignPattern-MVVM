//
//  ItemListView.swift
//  DesignPattern-MVVM
//
//  Created by Luminous Latte on 29/10/2024.
//

import SwiftUI

struct ItemListView: View {
    @StateObject private var viewModel = ItemListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List(viewModel.items) { item in
                        Text(item.name)
                    }
                }
            }
            .navigationTitle("Items")
        }
    }
}
