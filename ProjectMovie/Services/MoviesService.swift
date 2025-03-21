//
//  MoviesService.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

import Foundation

struct APIConstants {
    static let apiKey = "855W62W-47944Z4-JR8B7Y8-825Y7VK"
}

protocol MovieServiceProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String] { get }
}

enum MoviesService: MovieServiceProtocol {
    case bestMovies(page: Int)
    case searchMovies(page: Int, name: String)
    case detailMovie(id: Int)

    var baseURL: String {
        return "https://api.kinopoisk.dev/v1.4"
    }
    
    var path: String {
        switch self {
        case .bestMovies:
            "/movie"
        case .detailMovie(let id):
            "/movie/\(id)"
        case .searchMovies:
            "/movie/search"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .bestMovies(let page):
            return [
                "field": "typeNumber",
                 "search": "1",
                 "sortField": "votes.kp",
                 "sortType": "-1",
                "limit": "20",
                "page": "\(page)"
            ]
            
        case .searchMovies(let page, let name):
            return [
                "page": "\(page)",
                "limit": "20",
                "query": "\(name)",
            ]
            
        case .detailMovie(_):
            return nil
        }
    }
    
    var headers: [String: String] {
        return [
            "X-API-KEY": APIConstants.apiKey,
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
