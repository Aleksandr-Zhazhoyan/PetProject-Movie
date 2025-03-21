//
//  SearchViewModel.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var movies: [Doc] = []
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var canLoadMorePages = true
    
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        Task {
            await monitorSearchTextChanges()
        }
    }

    private func monitorSearchTextChanges() async {
        for await newText in $searchText.values {
            if !newText.isEmpty {
                resetPagination()
                await searchMovies(query: newText)
            }
        }
    }

    func searchMovies(query: String) async {
        guard !query.isEmpty, canLoadMorePages, !isLoading else { return }
        
        isLoading = true
        
        do {
            let response = try await networkService.getSearchMovies(page: currentPage, name: query)
            movies.append(contentsOf: response.docs)
            if response.docs.isEmpty {
                canLoadMorePages = false
            }
            currentPage += 1
        } catch {
            canLoadMorePages = false
        }
        
        isLoading = false
    }

    private func resetPagination() {
        currentPage = 1
        canLoadMorePages = true
        movies = []
    }
}

