//
//  DetailMoviePageView.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailMoviePageView: View {
    @ObservedObject var viewModel = DetailMovieViewModel()
    
    @State private var showNavigationBar = true
    
    var idMovie: Int
    var name: String
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .center) {
                    if case .loading = viewModel.detail {
                        ProgressView()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    } else if case .success(let data) = viewModel.detail {
                        WebImage(url: URL(string: data.image))
                            .resizable()
                            .indicator(.activity)
                            .frame(width: 250, height: 300)
                            .cornerRadius(8)
                        
                        Spacer(minLength: 16)
                        
                        RatingView(rating: data.voteAverange)
                        
                        HStack {
                            TwoLineTextView(
                                title: "Release Date",
                                subtitle: data.release
                            )
                            
                            Spacer(minLength: 8)
                            
                            TwoLineTextView(
                                title: "Popularity",
                                subtitle: "\(data.popularity)"
                            )
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                        .padding(.top, 8)
                        .padding(.horizontal, 50)

                        Text("Overview")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .padding(.top, 8)
                        
                        Text(data.overview)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.top, 1)
                        
                    } else if case .error(let error) = viewModel.detail {
                        Text("Error \(error.localizedDescription.description)")
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.getDetailMovie(idMovie: idMovie)
        }
        .toolbar(showNavigationBar ? .visible : .hidden)
        .toolbar {
            if !viewModel.isFavorite {
                favoriteButton
            } else {
                unfavoriteButton
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 10.0)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .navigationBarTitle(name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var favoriteButton: some View {
        Button(action: {
            let detail = viewModel.detail.value
            viewModel.addFavoriteMovie(
                favoriteMovie: FavoriteMovie(
                    id: detail?.id ?? 0,
                    image: detail?.image ?? "",
                    title: detail?.title ?? "",
                    voteAverange: detail?.voteAverange ?? 0.0,
                    overview: detail?.overview ?? "",
                    popularity: detail?.popularity ?? 0.0,
                    release: detail?.release ?? ""
                )
            )
        }, label: {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray)
                .padding(.trailing)
        })
    }
    
    var unfavoriteButton: some View {
        Button(action: {
            viewModel.deleteFavoriteMovieById(idMovie: idMovie)
        }, label: {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
                .padding(.trailing)
        })
    }
}

struct DetailMoviePageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMoviePageView(idMovie: 238, name: "The Godfather")
    }
}
