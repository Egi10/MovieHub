//
//  AppDependencies.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import Foundation
import Swinject
import RealmSwift

class AppDependencies {
    static let shared = AppDependencies()
    
    // ViewModel
    let detailMovieViewModel: DetailMovieViewModel
    let detailFavoriteViewModel: DetailFavoriteViewModel
    let favoriteViewModel: FavoriteViewModel
    let homeViewModel: HomeViewModel
    
    private init() {
        let container = Container()
        
        // Realm
        container.register(Realm.self) { _ in
            return try! Realm()
        }
        
        // Data Source
        container.register(RemoteDataSourceProtocol.self) { _ in
            return RemoteDataSource()
        }
        
        container.register(LocalDataSourceProtocol.self) { r in
            return LocalDataSource(realm: r.resolve(Realm.self))
        }
        
        // Repository
        container.register(MovieRepositoryProtocol.self) { r in
            return MovieRepository(
                remoteDataSource: r.resolve(RemoteDataSourceProtocol.self)!,
                localDataSource: r.resolve(LocalDataSourceProtocol.self)!
            )
        }
        
        // Use Case
        container.register(GetPopularMovieUseCase.self) { r in
            return DefaultGetPopularMovieUseCase(repository: r.resolve(MovieRepositoryProtocol.self)!)
        }
        
        container.register(GetTopRatedMovieUseCase.self) { r in
            return DefaulGetTopRatedMovieUseCase(repository: r.resolve(MovieRepositoryProtocol.self)!)
        }
        
        container.register(GetDetailMovieUseCase.self) { r in
            return DefaultGetDetailMovieUseCase(repository: r.resolve(MovieRepositoryProtocol.self)!)
        }
        
        container.register(GetFavoriteMovieUseCase.self) { r in
            return DefaultGetFavoriteMovieUseCase(repository: r.resolve(MovieRepositoryProtocol.self)!)
        }
        
        container.register(GetFavoriteMovieByIdUseCase.self) { r in
            return DefaultGetFavoriteMovieByIdUseCase(repository: r.resolve(MovieRepositoryProtocol.self)!)
        }
        
        container.register(AddFavoriteMovieUseCase.self) { r in
            return DefaulAddFavoriteMovieUseCase(repository: r.resolve(MovieRepositoryProtocol.self)!)
        }
        
        container.register(DeleteFavoriteMovieByIdUseCase.self) { r in
            return DefaultDeleteFavoriteMovieByIdUseCase(repository: r.resolve(MovieRepositoryProtocol.self)!)
        }
        
        // ViewModel
        container.register(DetailMovieViewModel.self) { r in
            DetailMovieViewModel(
                getDetailMovieUseCase: r.resolve(GetDetailMovieUseCase.self)!,
                getFavoriteMovieByIdUseCase: r.resolve(GetFavoriteMovieByIdUseCase.self)!,
                addFavoriteMovieUseCase: r.resolve(AddFavoriteMovieUseCase.self)!,
                deleteFavoriteMovieByIdUseCase: r.resolve(DeleteFavoriteMovieByIdUseCase.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(DetailFavoriteViewModel.self) { r in
            DetailFavoriteViewModel(
                getFavoriteMovieByIdUseCase: r.resolve(GetFavoriteMovieByIdUseCase.self)!,
                deleteFavoriteMovieByIdUseCase: r.resolve(DeleteFavoriteMovieByIdUseCase.self)!,
                addFavoriteMovieUseCase: r.resolve(AddFavoriteMovieUseCase.self)!
            )
        }
        
        container.register(FavoriteViewModel.self) { r in
            FavoriteViewModel(
                getFavoriteMovieUseCase: r.resolve(GetFavoriteMovieUseCase.self)!
            )
        }
        
        container.register(HomeViewModel.self) { r in
            HomeViewModel(
                getPopularMovieUseCase: r.resolve(GetPopularMovieUseCase.self)!,
                getTopRatedMovieUseCase: r.resolve(GetTopRatedMovieUseCase.self)!
            )
        }
        
        // View Model
        self.detailMovieViewModel = container.resolve(DetailMovieViewModel.self)!
        self.detailFavoriteViewModel = container.resolve(DetailFavoriteViewModel.self)!
        self.favoriteViewModel = container.resolve(FavoriteViewModel.self)!
        self.homeViewModel = container.resolve(HomeViewModel.self)!
    }
}
