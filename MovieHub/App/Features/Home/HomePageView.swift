//
//  HomePageView.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 19/03/23.
//

import SwiftUI

struct HomePageView: View {
    let dependencies = AppDependencies.shared
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Welcome,")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                Text("See a list of movies you might like")
                    .fontWeight(.light)
                    .padding(EdgeInsets(top: -10, leading: 16, bottom: 0, trailing: 16))
                
                if case .loading = viewModel.home {
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                } else if case .success(let data) = viewModel.home {
                    ScrollView(.vertical) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(data.topRatedMovie, id: \.id) { topRated in
                                    NavigationLink {
                                        DetailMoviePageView(idMovie: topRated.id, name: topRated.title)
                                            .environmentObject(dependencies.detailMovieViewModel)
                                            .toolbar(.hidden, for: .tabBar)
                                    } label: {
                                        TopRatedItemView(
                                            image: topRated.image,
                                            name: topRated.title,
                                            rating: topRated.voteAverange
                                        )
                                    }
                                }
                            }.padding(16)
                        }
                        
                        HStack {
                            Text("Popular")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("See All")
                                .font(.caption)
                                .fontWeight(.light)
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                        
                        Spacer(minLength: 16)
                        
                        LazyVStack(spacing: 16) {
                            ForEach(data.popularMovie, id: \.id) { popular in
                                NavigationLink {
                                    DetailMoviePageView(idMovie: popular.id, name: popular.title)
                                        .environmentObject(dependencies.detailMovieViewModel)
                                        .toolbar(.hidden, for: .tabBar)
                                } label: {
                                    PopularItemView(
                                        image: popular.image,
                                        name: popular.title,
                                        rating: popular.voteAverange
                                    )
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                } else if case .error(let error) = viewModel.home {
                    Text("Error \(error.localizedDescription)")
                }
            }
        }
        .onAppear {
            viewModel.getPopularMovie()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(AppDependencies.shared.homeViewModel)
    }
}
