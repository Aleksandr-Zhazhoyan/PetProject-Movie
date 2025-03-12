//
//  MainTabView.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 24.02.2025.
//


import SwiftUI

struct MainTabView: View {
    
    let networkService: NetworkService
    
    
    var body: some View {
        TabView {
            
        
                MoviesView(networkService: networkService)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(Texts.movies)
                }
            
            
            SearchView(networkService: networkService)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text(Texts.search)
                }
        }
    }
    
    enum Texts {
        static let movies = "Главная"
        static let search = "Поиск"
    }
}
