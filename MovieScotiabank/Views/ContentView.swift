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
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Buscar películas...", text: Binding(
                    get: { viewModel.searchQuery },
                    set: { newValue in
                        viewModel.searchQuery = newValue
                        viewModel.searchSubject.send(newValue)
                    }
                ))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Categories", selection: $selectedCategory) {
                    Text("Popular").tag(0)
                    Text("Top Rated").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedCategory == 0 {
                    MovieListView(movies: viewModel.filteredPopularMovies, selectedMovie: $selectedMovie)
                } else {
                    MovieListView(movies: viewModel.filteredTopMovies, selectedMovie: $selectedMovie)
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
                FiltersView(viewModel: viewModel, isPresented: $showFilters)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Alert"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                viewModel.fetchMovies()
            }
            .background(
                NavigationLink(destination: selectedMovie.map { MovieDetailView(movie: $0).onDisappear {
                    // Reset selectedMovie to nil when the detail view disappears
                    selectedMovie = nil
                } }, isActive: .constant(selectedMovie != nil)) {
                    EmptyView()
                }
            )
        }
    }
}

