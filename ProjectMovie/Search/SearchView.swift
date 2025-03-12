//
//  SearchView.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    @EnvironmentObject var router: Router
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        _viewModel = StateObject(wrappedValue: SearchViewModel(networkService: networkService))
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                TextField("Поиск...", text: $viewModel.searchText, onCommit: {
                    UIApplication.shared.endEditing()
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if viewModel.isLoading && viewModel.movies.isEmpty {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                List {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        MovieRow(movie: movie)
                            .onTapGesture {
                                router.path.append(.movieDetail(movie: movie))
                            }
                            .onAppear {
                                if movie == viewModel.movies.last {
                                    Task {
                                        await viewModel.searchMovies(query: viewModel.searchText)
                                    }
                                }
                            }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Поиск")
            .navigationDestination(for: MovieRoute.self) { route in
                switch route {
                case .movieDetail(let movie):
                    MovieDetailView(movie: movie, networkService: networkService)
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}
