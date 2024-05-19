//
//  ContentView.swift
//  MovieScotiabank
//
//  Created by user on 17/05/24.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @StateObject private var viewModel = MoviesViewModel()
    @State private var selectedCategory = 0
    @State private var showFilters = false
    

    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar películas...", text: $viewModel.searchQuery)
                    .onChange(of: viewModel.searchQuery) { newValue in
                        viewModel.searchSubject.send(newValue)
                    }
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Categories", selection: $selectedCategory) {
                    Text("Popular").tag(0)
                    Text("Top Rated").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedCategory == 0 {
                    MovieListView(movies: viewModel.filteredPopularMovies)
                } else {
                    MovieListView(movies: viewModel.filteredTopMovies)
                }
                
                Spacer()
            }
            .navigationTitle("Movies")
            .navigationBarItems(trailing: Button(action: {
                showFilters.toggle()
            }) {
                Image(systemName: "slider.horizontal.3")
            })
            .sheet(isPresented: $showFilters) {
                FiltersView(viewModel: viewModel,  isPresented: $showFilters)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Alert"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
}

