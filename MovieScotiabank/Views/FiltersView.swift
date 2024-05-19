//
//  FiltersView.swift
//  MovieScotiabank
//
//  Created by user on 18/05/24.
//

import SwiftUI

struct FiltersView: View {
    @ObservedObject var viewModel: MoviesViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var isPresented: Bool
    


    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $viewModel.adultFilter) {
                    Text("Exclude Adult Content")
                }
                
                TextField("Original language (en, es, English, Español)", text: $viewModel.languageFilter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Minimum Vote Average", text: $viewModel.voteAverage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
            }
            .navigationTitle("Filters")
            .navigationBarItems(trailing: Button("Apply") {
                isPresented = false
                viewModel.filterMovies()
            })
        }
    }
}

