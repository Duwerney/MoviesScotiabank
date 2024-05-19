//
//  SearchBarRepresentable.swift
//  MovieScotiabank
//
//  Created by user on 18/05/24.
//

import SwiftUI
import UIKit

struct SearchBarRepresentable: UIViewControllerRepresentable {
    @Binding var text: String
    var onSearchButtonClicked: (() -> Void)? = nil

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        var onSearchButtonClicked: (() -> Void)?

        init(text: Binding<String>, onSearchButtonClicked: (() -> Void)?) {
            _text = text
            self.onSearchButtonClicked = onSearchButtonClicked
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            onSearchButtonClicked?()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, onSearchButtonClicked: onSearchButtonClicked)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search movies..."
        viewController.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: viewController.view.topAnchor)
        ])
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No update needed
    }
}
