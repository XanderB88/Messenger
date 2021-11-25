//
//  PeopleViewController.swift
//  Messenger
//
//  Created by Alexander on 20.11.2021.
//

import UIKit

class PeopleViewController: UIViewController {

    var searchBar = SearchBar()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainDark
        searchBar.setupSearchBar(navigationItem: navigationItem, delegate: self)
    }
}

// MARK: - Search bar delegate
extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct PeopleViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
