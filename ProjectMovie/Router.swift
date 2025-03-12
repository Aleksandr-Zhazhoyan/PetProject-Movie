//
//  Router.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

import Foundation

class Router: ObservableObject {
    @Published var path = [MovieRoute]()
}

enum MovieRoute: Hashable {
    case movieDetail(movie: Doc)
}
