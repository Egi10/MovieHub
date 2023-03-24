//
//  DetailMovieViewModel.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import Foundation
import Combine

class DetailMovieViewModel: ObservableObject {
    @Published var detail: ViewState<DetailMovie> = .initiate
    @Published var isFavorite: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private let getDetailMovieUseCase: GetDetailMovieUseCase
    private let getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase
    private let addFavoriteMovieUseCase: AddFavoriteMovieUseCase
    private let deleteFavoriteMovieByIdUseCase: DeleteFavoriteMovieByIdUseCase
    
    init(
        getDetailMovieUseCase: GetDetailMovieUseCase,
        getFavoriteMovieByIdUseCase: GetFavoriteMovieByIdUseCase,
        addFavoriteMovieUseCase: AddFavoriteMovieUseCase,
        deleteFavoriteMovieByIdUseCase: DeleteFavoriteMovieByIdUseCase
    ) {
        self.getDetailMovieUseCase = getDetailMovieUseCase
        self.getFavoriteMovieByIdUseCase = getFavoriteMovieByIdUseCase
        self.addFavoriteMovieUseCase = addFavoriteMovieUseCase
        self.deleteFavoriteMovieByIdUseCase = deleteFavoriteMovieByIdUseCase
    }
    
    func getDetailMovie(idMovie: Int) {
        self.detail = .loading
        getDetailMovieUseCase.execute(idMovie: idMovie)
            .zip(getFavoriteMovieByIdUseCase.exevute(id: idMovie))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    self.detail = .error(error: error)
                }
            } receiveValue: { value in
                self.detail = .success(data: value.0)
                self.isFavorite = value.1.id != 0 ? true : false
            }.store(in: &cancellables)
    }
    
    func addFavoriteMovie(favoriteMovie: FavoriteMovie) {
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
    
    func deleteFavoriteMovieById(idMovie: Int) {
        deleteFavoriteMovieByIdUseCase.execute(id: idMovie)
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
}
