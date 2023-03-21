//
//  FavoriteMovie.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation

struct FavoriteMovie: Hashable, Codable, Identifiable {
    let id: Int
    let image: String
    let title: String
    let voteAverange: Double
    let overview: String
    let popularity: Double
    let release: String
}
