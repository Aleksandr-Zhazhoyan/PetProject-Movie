//
//  Movies.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

struct Movies: Codable {
    let docs: [Doc]
    let total: Int
    let limit: Int
    let page: Int
    let pages: Int
}

struct Doc: Codable, Equatable, Hashable {
    let id: Int
    let name: String?
    let alternativeName: String?
    let type: String?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let rating: Rating
    let votes: Votes
    let movieLength: Int?
    let poster: Poster?
    let genres: [Genre]?
    
    static func == (lhs: Doc, rhs: Doc) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Poster: Codable {
    let url: String?
    let previewUrl: String?
}

struct Rating: Codable {
    let kp: Double?
    let imdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}

struct Votes: Codable {
    let kp: Int
    let imdb: Int?
    let filmCritics: Int?
    let russianFilmCritics: Int?
    let await: Int?
}

struct Genre: Codable {
    let name: String
}

struct Country: Codable {
    let name: String
}

struct ReleaseYear: Codable {
    let start: Int?
    let end: Int?
}

extension Doc {
    static func fromCoreData(_ entity: MovieEntity) -> Doc {
        return Doc(
            id: Int(entity.id),
            name: entity.name,
            alternativeName: nil,
            type: "movie",
            year: Int(entity.year),
            description: entity.descriptionText,
            shortDescription: nil,
            rating: Rating(kp: entity.rating, imdb: nil, filmCritics: nil, russianFilmCritics: nil, await: nil),
            votes: Votes(kp: 0, imdb: nil, filmCritics: nil, russianFilmCritics: nil, await: nil),
            movieLength: Int(entity.movieLength),
            poster: entity.posterUrl != nil ? Poster(url: entity.posterUrl ?? "", previewUrl: nil) : nil,
            genres: nil
        )
    }
}
