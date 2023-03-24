//
//  DetailFavoriteViewModel.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation
import Combine

class DetailFavoriteViewModel: ObservableObject {
    @Published var favorite: ViewState<FavoriteMovie> = .initiate
    @Published var isFavorite: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private let getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase
    private let deleteFavoriteMovieByIdUseCase: DeleteFavoriteMovieByIdUseCase
    private let addFavoriteMovieUseCase: AddFavoriteMovieUseCase
    
    init(
        getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase,
        deleteFavoriteMovieByIdUseCase: DeleteFavoriteMovieByIdUseCase,
        addFavoriteMovieUseCase: AddFavoriteMovieUseCase
    ) {
        self.getFavoriteMovieByIdUseCase = getFavoriteMovieByIdUseCase
        self.deleteFavoriteMovieByIdUseCase = deleteFavoriteMovieByIdUseCase
        self.addFavoriteMovieUseCase = addFavoriteMovieUseCase
    }
    
    func getFavoriteById(from idMovie: Int) {
        self.favorite = .loading
        
        getFavoriteMovieByIdUseCase.exevute(id: idMovie)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    self.isFavorite = false
                    self.favorite = .error(error: error)
                }
            } receiveValue: { value in
                self.isFavorite = true
                self.favorite = .success(data: value)
            }.store(in: &cancellables)
        }
    
    func removeGameFavorite(from id: Int) {
        deleteFavoriteMovieByIdUseCase.execute(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure:
                    self.isFavorite = true
                }
            } receiveValue: { value in
                self.isFavorite = false
            }.store(in: &cancellables)
    }
    
    func addGameFavorite(favoriteMovie: FavoriteMovie) {
        addFavoriteMovieUseCase.execute(favoriteMovie: favoriteMovie)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure:
                    self.isFavorite = false
                }
            } receiveValue: { value in
                self.isFavorite = true
            }.store(in: &cancellables)
    }
}
