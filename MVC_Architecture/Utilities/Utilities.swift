//
//  Utilities.swift
//  MVC_Architecture
//
//  Created by mac on 03/10/2023.
//

import Foundation

class Utilities: NSObject {
    static let shared = Utilities()
    static let GetMoviesSuccessNotification = "GetMoviesSuccessNotification"
    
    private override init() {
        super.init()
    }
    
    func importMovieList(movies: [Movie]) -> [Movie] {
        var list = [Movie]()
        for movie in movies {
            list.append(Movie(id: movie.id,
                              name: movie.name,
                              director: movie.director,
                              thumbnail: movie.thumbnail,
                              desc: movie.desc,
                              year: movie.year))
        }
        return list
    }
}
