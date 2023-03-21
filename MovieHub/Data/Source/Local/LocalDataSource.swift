//
//  LocalDataSource.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation
import Combine
import RealmSwift

protocol LocalDataSourceProtocol {
    func getFavoriteMovie() -> AnyPublisher<[MovieEntity], Error>
    func getFavoriteMovieById(id: Int) -> AnyPublisher<MovieEntity?, Error>
    func addMovieFavorite(movie: MovieEntity) -> AnyPublisher<Bool, Error>
    func removeGameFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

class LocalDataSource: LocalDataSourceProtocol {
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    func getFavoriteMovie() -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { completion in
            if let realm = self.realm {
                let movie: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                }()
                completion(
                    .success(
                        movie.toArray(ofType: MovieEntity.self)
                    )
                )
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error Message"])))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteMovieById(id: Int) -> AnyPublisher<MovieEntity?, Error> {
        return Future<MovieEntity?, Error> { completion in
            if let realm = self.realm {
                let movie = realm.object(ofType: MovieEntity.self, forPrimaryKey: id)
                completion(.success(movie ?? nil))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error Message"])))
            }
        }.eraseToAnyPublisher()
    }
    
    func addMovieFavorite(movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(movie, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error Message"])))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeGameFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let movie = realm.object(ofType: MovieEntity.self, forPrimaryKey: id)!
                    try realm.write {
                        realm.delete(movie)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error Message"])))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
