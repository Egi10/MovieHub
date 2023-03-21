//
//  MovieRepository.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation
import Combine
import Alamofire

class MovieRepository: MovieRepositoryProtocol {
    var remoteDataSource: RemoteDataSourceProtocol
    var localDataSource: LocalDataSourceProtocol
    
    init(
        remoteDataSource: RemoteDataSourceProtocol,
        localDataSource: LocalDataSourceProtocol
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getFavoriteMovie() -> AnyPublisher<[FavoriteMovie], Error> {
        return self.localDataSource.getFavoriteMovie()
            .map { entity in
                MovieEntityMapper.mapMovieEntityToMovieFavoriteModel(input: entity)
            }.eraseToAnyPublisher()
    }
    
    func getFavoriteMovieById(id: Int) -> AnyPublisher<FavoriteMovie, Error> {
        return self.localDataSource.getFavoriteMovieById(id: id)
            .map { entity in
                MovieEntityMapper.mapMovieEntityToMovieFavoriteModel(input: entity)
            }.eraseToAnyPublisher()
    }
    
    func addMovieFavorite(movie: FavoriteMovie) -> AnyPublisher<Bool, Error> {
        return self.localDataSource.addMovieFavorite(
            movie: MovieEntityMapper.mapFavoriteMovieToMovieEntity(input: movie)
        ).eraseToAnyPublisher()
    }
    
    func removeGameFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.localDataSource.removeGameFavorite(id: id)
            .eraseToAnyPublisher()
    }
    
    func getPopular() -> AnyPublisher<[PopularMovie], Error> {
        return self.remoteDataSource.getPopular()
            .map { response in
                MovieResponseMapper.mapMovieResponseToPopularModel(input: response)
            }
            .eraseToAnyPublisher()
    }
    
    func getTopRated() -> AnyPublisher<[TopRatedMovie], Error> {
        return self.remoteDataSource.getTopRated()
            .map { response in
                MovieResponseMapper.mapMovieResponseToTopRatedModel(input: response)
            }
            .eraseToAnyPublisher()
    }
    
    func getDetail(idMovie: Int) -> AnyPublisher<DetailMovie, Error> {
        return self.remoteDataSource.getDetail(idMovie: idMovie)
            .map { response in
                MovieResponseMapper.mapDetailMovieResponseToDetailModel(input: response)
            }
            .eraseToAnyPublisher()
    }
}
