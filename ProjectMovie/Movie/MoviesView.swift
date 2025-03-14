//
//  MoviesView.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

import SwiftUI
import Kingfisher

struct MoviesView: View {
    @StateObject private var viewModel: MoviesViewModel
    @EnvironmentObject var router: Router
    @EnvironmentObject var alertManager: AlertManager
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        _viewModel = StateObject(wrappedValue: MoviesViewModel(context: PersistenceController.shared.container.viewContext, networkService: networkService))
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            List {
                ForEach(viewModel.movies, id: \.id) { movie in
                    MovieRow(movie: movie)
                        .onTapGesture {
                            router.path.append(.movieDetail(movie: movie))
                        }
                        .onAppear {
                            Task {
                                await viewModel.loadNextPageIfNeeded(currentItem: movie)
                            }
                        }
                }
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Каталог фильмов")
            .navigationDestination(for: MovieRoute.self) { route in
                switch route {
                case .movieDetail(let movie):
                    MovieDetailView(movie: movie, networkService: networkService)
                }
            }
            .refreshable {
                await viewModel.loadMovies(refresh: true)
            }
            .alert(isPresented: $alertManager.showAlert) {
                Alert(
                    title: Text(alertManager.alertTitle),
                    message: Text(alertManager.alertMessage),
                    dismissButton: .default(Text("OK")) {
                        alertManager.showAlert = false
                    }
                )
            }
        }
    }
}
