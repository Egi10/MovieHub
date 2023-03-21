//
//  GetDetailMovieUseCase.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import Foundation
import Combine

protocol GetDetailMovieUseCase {
    func execute(idMovie: Int) -> AnyPublisher<DetailMovie, Error>
}

class DefaultGetDetailMovieUseCase: GetDetailMovieUseCase {
    
    private var repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(idMovie: Int) -> AnyPublisher<DetailMovie, Error> {
        return self.repository.getDetail(idMovie: idMovie)
    }
}
