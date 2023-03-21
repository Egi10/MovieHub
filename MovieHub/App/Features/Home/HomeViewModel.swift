//
//  HomeViewModel.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var home: ViewState<Home> = .initiate
    private var cancellables = Set<AnyCancellable>()
    
    private let getPopularMovieUseCase: GetPopularMovieUseCase
    private let getTopRatedMovieUseCase: GetTopRatedMovieUseCase
    
    init() {
        let dependencies = AppDependencies.shared
        self.getPopularMovieUseCase = dependencies.getPopularMovieUseCase
        self.getTopRatedMovieUseCase = dependencies.getTopRatedMovieUseCase
    }
    
    func getPopularMovie() {
        self.home = .loading
        getPopularMovieUseCase.execute()
            .receive(on: DispatchQueue.main)
            .zip(getTopRatedMovieUseCase.execute())
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    self.home = .error(error: error)
                }
            } receiveValue: { value in
                self.home = .success(data: Home(popularMovie: value.0, topRatedMovie: value.1))
            }.store(in: &cancellables)
    }
}
