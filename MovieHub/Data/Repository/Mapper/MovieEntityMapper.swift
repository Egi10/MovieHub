//
//  MovieEntityMapper.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation

final class MovieEntityMapper {
    static func mapMovieEntityToMovieFavoriteModel(input: [MovieEntity]) -> [FavoriteMovie] {
        return input.map { result in
            return FavoriteMovie(
                id: result.id,
                image: result.image,
                title: result.title,
                voteAverange: result.voteAverange,
                overview: result.overview,
                popularity: result.popularity,
                release: result.release
            )
        }
    }
    
    static func mapMovieEntityToMovieFavoriteModel(input: MovieEntity?) -> FavoriteMovie {
        return FavoriteMovie(
            id: input?.id ?? 0,
            image: input?.image ?? "",
            title: input?.title ?? "",
            voteAverange: input?.voteAverange ?? 0.0,
            overview: input?.overview ?? "",
            popularity: input?.popularity ?? 0.0,
            release: input?.release ?? ""
        )
    }
    
    static func mapFavoriteMovieToMovieEntity(input: FavoriteMovie) -> MovieEntity {
        let entity = MovieEntity()
        entity.id = input.id
        entity.image = input.image
        entity.title = input.title
        entity.voteAverange = input.voteAverange
        entity.overview = input.overview
        entity.popularity = input.popularity
        entity.release = input.release
        return entity
    }
}
