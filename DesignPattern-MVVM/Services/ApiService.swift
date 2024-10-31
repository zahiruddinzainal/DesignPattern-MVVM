//
//  ApiService.swift
//  DesignPattern-MVVM
//
//  Created by Luminous Latte on 29/10/2024.
//

import Foundation
import Combine

class APIService {
    private let useFakeData: Bool

    init(useFakeData: Bool = true) { // You can toggle this in the initializer
        self.useFakeData = useFakeData
    }

    func fetchItems() -> AnyPublisher<[Item], Error> {
        if useFakeData {
            return fetchFakeItems()
        } else {
            return fetchRealItems()
        }
    }

    private func fetchFakeItems() -> AnyPublisher<[Item], Error> {
        // Create a sample array of items
        let sampleItems = [
            Item(id: 1, name: "Item 1"),
            Item(id: 2, name: "Item 2"),
            Item(id: 3, name: "Item 3")
        ]

        // Return a publisher that simulates a network call with a delay
        return Just(sampleItems)
            .delay(for: .seconds(2), scheduler: RunLoop.main) // Simulate a delay
            .setFailureType(to: Error.self) // Set failure type
            .eraseToAnyPublisher() // Erase to AnyPublisher
    }

    private func fetchRealItems() -> AnyPublisher<[Item], Error> {
        guard let url = URL(string: "https://api.example.com/items") else {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Item].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
