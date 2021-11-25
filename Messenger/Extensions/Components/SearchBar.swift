//
//  SearchBar.swift
//  Messenger
//
//  Created by Alexander on 25.11.2021.
//

import UIKit

class SearchBar {
    
    func setupSearchBar(navigationItem: UINavigationItem, delegate: UISearchBarDelegate) {
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.navigationItem.hidesSearchBarWhenScrolling = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.searchTextField.font = .searchAndMessageFont
        searchController.searchBar.searchTextField.textColor = .mainWhite
        searchController.searchBar.searchTextField.leftView?.tintColor = .secondaryWhite
        searchController.searchBar.tintColor = .mainBlue
        searchController.searchBar.delegate = delegate
    }
}

