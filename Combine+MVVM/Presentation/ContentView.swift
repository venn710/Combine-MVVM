//
//  ContentView.swift
//  Combine+MVVM
//
//  Created by Venkatesham Boddula on 27/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                if !viewModel.alertMessage.isEmpty {
                    VStack {
                        Image(.error)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFit()
                        
                        Button {
                            viewModel.getData()
                        } label: {
                            Text("Retry again")
                                .font(.headline)
                        }
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(viewModel.todos, id: \.id) { data in
                                TodoCard(data: data)
                            }
                        }
                    }
                }
                
                if viewModel.showLoader {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .padding(.horizontal, 12)
            .background(Color(uiColor: .secondarySystemBackground))
            .refreshable {
                viewModel.getData()
            }
            .task {
                viewModel.getData()
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert, actions: {})
            .navigationTitle("ToDos")
        }
    }
}
