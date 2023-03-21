//
//  MovieRepositoryProtocol.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation
import Combine
import Alamofire

protocol MovieRepositoryProtocol {
    func getPopular() -> AnyPublisher<[PopularMovie], Error>
    func getTopRated() -> AnyPublisher<[TopRatedMovie], Error>
    func getDetail(idMovie: Int) -> AnyPublisher<DetailMovie, Error>
    func getFavoriteMovie() -> AnyPublisher<[FavoriteMovie], Error>
    func getFavoriteMovieById(id: Int) -> AnyPublisher<FavoriteMovie, Error>
    func addMovieFavorite(movie: FavoriteMovie) -> AnyPublisher<Bool, Error>
    func removeGameFavorite(id: Int) -> AnyPublisher<Bool, Error>
}
