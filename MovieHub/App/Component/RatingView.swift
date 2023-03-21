//
//  RatingView.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import SwiftUI

struct RatingView: View {
    var rating: Double
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            
            Text("\(rating, specifier: "%.2f")")
                .font(.caption)
                .fontWeight(.light)
                .lineLimit(1)
                .foregroundColor(.gray)
        }.padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
    }
}
