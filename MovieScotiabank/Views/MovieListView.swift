//
//  MovieListView.swift
//  MovieScotiabank
//
//  Created by user on 18/05/24.
//

import SwiftUI

struct MovieListView: View {
    let movies: [Movie]

    var body: some View {
        List(movies, id: \.id) { movie in
            HStack(alignment: .top) {
                if let posterPath = movie.posterPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 75)
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 75)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(movie.title)
                            .font(.headline)
                        Spacer()
                        IconLabelView(iconName: "star.fill", text: String(format: "%.1f", movie.voteAverage))
                            .foregroundColor(.yellow)
                    }
                    
                    Text(movie.overview)
                        .font(.subheadline)
                        .lineLimit(3)
                        .truncationMode(.tail)
                    
                    HStack {
                        Text("Language:")
                            .font(.subheadline)
                        Text(movie.originalLanguage)
                            .font(.subheadline)
                    }
                    HStack {
                        Spacer()
                        IconLabelView(iconName: "hand.thumbsup.fill", text: "\(movie.voteCount)")
                    }
                    if movie.adult {
                        Text("Adult")
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .bold()
                    }
                }
                .padding(.leading, 8)
            }
            .padding(.vertical, 8)
        }
    }
}


struct IconLabelView: View {
    let iconName: String
    let text: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 15, height: 15)
            Text(text)
                .font(.subheadline)
        }
    }
}
