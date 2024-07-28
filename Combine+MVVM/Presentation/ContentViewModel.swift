//
//  ContentViewModel.swift
//  Combine+MVVM
//
//  Created by Venkatesham Boddula on 27/07/24.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var todos: [ToDo] = []
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var showLoader: Bool = false
    
    
    var cancelSet: Set<AnyCancellable> = []
    func getData() {
        showLoader = true
        let publisher: AnyPublisher<[ToDo], APIError> = NetworkManager.shared.getData()
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] apiError in
                guard let self else { return }
                guard let message = apiError.error?.errorDescription else {
                    return
                }
                showLoader = false
                showAlert = true
                alertMessage = message
            } receiveValue: { [weak self] data in
                guard let self else { return }
                showLoader = false
                todos = data
            }
            .store(in: &cancelSet)

    }
}
