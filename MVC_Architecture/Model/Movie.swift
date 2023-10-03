//
//  Movie.swift
//  MVC_Architecture
//
//  Created by mac on 17/09/2023.
//

import UIKit

struct Movie: Codable {
    let id: String
    let name: String
    let director: String
    let thumbnail: String
    let desc: String
    let year: String
}
