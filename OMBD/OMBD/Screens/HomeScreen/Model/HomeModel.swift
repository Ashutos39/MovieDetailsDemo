//
//  HomeModel.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import Foundation

struct HomeModel: Codable {
    var search: [Search]?
    var totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct Search: Codable {
    let title, year, imdbID, type, poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
