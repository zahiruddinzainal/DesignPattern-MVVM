//
//  ItemListView.swift
//  DesignPattern-MVVM
//
//  Created by Luminous Latte on 29/10/2024.
//

import Foundation
import Combine

class ItemListViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIService

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        fetchItems()
    }

    func fetchItems() {
        isLoading = true
        apiService.fetchItems()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
                self?.isLoading = false
            })
            .catch { error -> Just<[Item]> in
                self.errorMessage = error.localizedDescription
                return Just([]) // Return an empty array in case of error
            }
            .assign(to: &$items) // This now works correctly
    }
}

