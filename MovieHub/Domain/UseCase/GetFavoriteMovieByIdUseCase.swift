//
//  GetFavoriteMovieByIdUseCase.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation
import Combine

protocol GetFavoriteMovieByIdUseCase {
    func exevute(id: Int) -> AnyPublisher<FavoriteMovie, Error>
}

class DefaultGetFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase {
    
    private var repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func exevute(id: Int) -> AnyPublisher<FavoriteMovie, Error> {
        return self.repository.getFavoriteMovieById(id: id)
    }
}
