//
//  PopularMovie.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation

struct PopularMovie: Hashable, Codable, Identifiable {
    let id: Int
    let image: String
    let title: String
    let voteAverange: Double
    let genre: [String]
}
