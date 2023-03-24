//
//  FavoritePageView.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import SwiftUI

struct FavoritePageView: View {
    @EnvironmentObject var viewModel: FavoriteViewModel
    
    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Favorite List")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                
                if case .loading = viewModel.favorite {
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                } else if case .success(let data) = viewModel.favorite {
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout) {
                            ForEach(data, id: \.self) { movie in
                                NavigationLink {
                                    let dependencies = AppDependencies.shared
                                    
                                    DetailFavoritePageView(
                                        idMovie: movie.id,
                                        name: movie.title
                                    )
                                    .environmentObject(dependencies.detailFavoriteViewModel)
                                    .toolbar(.hidden, for: .tabBar)
                                } label: {
                                    MovieFavoriteItemView(
                                        image: movie.image,
                                        name: movie.title,
                                        releaseDate: movie.release,
                                        rating: movie.voteAverange
                                    )
                                }
                            }
                            .padding(.horizontal, 4)
                        }.padding(.horizontal, 16)
                    }
                } else if case .empty = viewModel.favorite {
                    Text("Empty")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                } else if case .error = viewModel.favorite {
                    Text("Ops, There is an error")
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .onAppear {
                self.viewModel.getFavoriteMovie()
            }
        }
    }
}

struct FavoritePageView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePageView()
            .environmentObject(AppDependencies.shared.favoriteViewModel)
    }
}
