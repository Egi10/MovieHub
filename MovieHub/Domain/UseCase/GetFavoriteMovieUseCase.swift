//
//  GetFavoriteMovieUseCase.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation
import Combine

protocol GetFavoriteMovieUseCase {
    func execute() -> AnyPublisher<[FavoriteMovie], Error>
}

class DefaultGetFavoriteMovieUseCase: GetFavoriteMovieUseCase {
    
    private var repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[FavoriteMovie], Error> {
        return self.repository.getFavoriteMovie()
    }
}
