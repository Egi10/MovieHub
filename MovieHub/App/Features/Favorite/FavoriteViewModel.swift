//
//  FavoriteViewModel.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation
import Combine

class FavoriteViewModel: ObservableObject {
    @Published var favorite: ViewState<[FavoriteMovie]> = .initiate
    private var cancellables = Set<AnyCancellable>()
    
    private let getFavoriteMovieUseCase: GetFavoriteMovieUseCase
    
    init() {
        let dependencies = AppDependencies.shared
        self.getFavoriteMovieUseCase = dependencies.getFavoriteMovieUseCase
    }
    
    func getFavoriteMovie() {
        self.favorite = .loading
        getFavoriteMovieUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    self.favorite = .error(error: error)
                }
            } receiveValue: { value in
                self.favorite = .success(data: value)
            }.store(in: &cancellables)
    }
}
