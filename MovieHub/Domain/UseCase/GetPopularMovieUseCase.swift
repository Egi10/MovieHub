//
//  GetPopularMovieUseCase.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation
import Combine

protocol GetPopularMovieUseCase {
    func execute() -> AnyPublisher<[PopularMovie], Error>
}

class DefaultGetPopularMovieUseCase: GetPopularMovieUseCase {
    
    private var repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[PopularMovie], Error> {
        return self.repository.getPopular()
    }
}
