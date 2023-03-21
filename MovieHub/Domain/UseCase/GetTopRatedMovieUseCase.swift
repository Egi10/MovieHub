//
//  GetTopRatedMovieUseCase.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation
import Combine

protocol GetTopRatedMovieUseCase {
    func execute() -> AnyPublisher<[TopRatedMovie], Error>
}

class DefaulGetTopRatedMovieUseCase: GetTopRatedMovieUseCase {
    
    private var repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[TopRatedMovie], Error> {
        return self.repository.getTopRated()
    }
}
