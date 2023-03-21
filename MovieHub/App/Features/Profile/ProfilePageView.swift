//
//  ProfilePageView.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 20/03/23.
//

import SwiftUI

struct ProfilePageView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: "https://media.licdn.com/dms/image/C5103AQHDlOW-Aes34w/profile-displayphoto-shrink_800_800/0/1541402590633?e=2147483647&v=beta&t=5WPvAq4XWPB8FsgNnUww0Huy81Ync1kjJMccZF8BapM")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 150)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100, maxHeight: 100)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text("Julsapargi Nursam")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("egifcb@gmail.com")
                    .font(.body)
                    .fontWeight(.light)
            }
            .padding(.top, 40.0)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
