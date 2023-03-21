//
//  MovieResponseMapper.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation

final class MovieResponseMapper {
    static func mapMovieResponseToPopularModel(input: MovieResponse) -> [PopularMovie] {
        return input.results.map { result in
            return PopularMovie(
                id: result.id, image: "https://image.tmdb.org/t/p/original/\(result.posterPath)", title: result.title, voteAverange: result.voteAverage, genre: [""]
            )
        }
    }
    
    static func mapMovieResponseToTopRatedModel(input: MovieResponse) -> [TopRatedMovie] {
        return input.results.map { result in
            return TopRatedMovie(
                id: result.id, image: "https://image.tmdb.org/t/p/original/\(result.posterPath)", title: result.title, voteAverange: result.voteAverage
            )
        }
    }
    
    static func mapDetailMovieResponseToDetailModel(input: DetailMovieResponse) -> DetailMovie {
        return DetailMovie(
            id: input.id,
            image: "https://image.tmdb.org/t/p/original/\(input.posterPath)",
            title: input.title,
            voteAverange: input.voteAverage,
            overview: input.overview,
            popularity: input.popularity,
            release: input.releaseDate
        )
    }
}
