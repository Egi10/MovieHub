//
//  DeleteFavoriteMovieByIdUseCase.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation
import Combine

protocol DeleteFavoriteMovieByIdUseCase {
    func execute(id: Int) -> AnyPublisher<Bool, Error>
}

class DefaultDeleteFavoriteMovieByIdUseCase: DeleteFavoriteMovieByIdUseCase {
    private var repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) -> AnyPublisher<Bool, Error> {
        return self.repository.removeGameFavorite(id: id)
    }
}
