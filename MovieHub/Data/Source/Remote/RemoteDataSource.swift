//
//  RemoteDataSource.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol {
    func getTopRated() -> AnyPublisher<MovieResponse, Error>
    func getPopular() -> AnyPublisher<MovieResponse, Error>
    func getDetail(idMovie: Int) -> AnyPublisher<DetailMovieResponse, Error>
}

class RemoteDataSource: RemoteDataSourceProtocol {
    
    init() {}
    
    func getTopRated() -> AnyPublisher<MovieResponse, Error> {
        return Future<MovieResponse, Error> { completion in
            if let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=86d0e4ed0cc15d8f65e2ccdf5250f4bd&language=en-US&page=1") {
                AF.request(url, method: .get)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getPopular() -> AnyPublisher<MovieResponse, Error> {
        return Future<MovieResponse, Error> { completion in
            if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=86d0e4ed0cc15d8f65e2ccdf5250f4bd&language=en-US&page=1") {
                AF.request(url, method: .get)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetail(idMovie: Int) -> AnyPublisher<DetailMovieResponse, Error> {
        return Future<DetailMovieResponse, Error> { completion in
            if let url = URL(string: "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=86d0e4ed0cc15d8f65e2ccdf5250f4bd&language=en-US") {
                AF.request(url, method: .get)
                    .validate()
                    .responseDecodable(of: DetailMovieResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
