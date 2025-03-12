//
//  MovieDetails.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

struct MovieDetails: Codable {
    let videos: Videos
    let genres: [Genres]
    let persons: [Persons]
}

struct Videos: Codable {
    let trailers: [Trailer]
}

struct Trailer: Codable {
    let url: String
}

struct Genres: Codable {
    let name: String
}

struct Persons: Codable {
    let name: String?
    let description: String?
    let enProfession: String?
    let photo: String?
}
