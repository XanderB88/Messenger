//
//  ChatsViewController.swift
//  Messenger
//
//  Created by Alexander on 20.11.2021.
//

import UIKit

class ChatsViewController: UIViewController {

    // MARK: - Constants
    let waitingChats = Bundle.main.decode([ChatModel].self, from: "waitingChats.json")
    let activeChats = Bundle.main.decode([ChatModel].self, from: "activeChats.json")
    
    enum Section: Int, CaseIterable {
        case waitingChats, activeChats
    }
   
    // MARK: - Variables
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, ChatModel>?
    var chatCellSize: CGFloat = 88
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainDark
        setupSearchBar()
        setupCollectionView()
        setupDataSource()
        reloadData()
    }
}


extension ChatsViewController {
   
    // MARK: - Setup search bar
    private func setupSearchBar() {
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.searchTextField.font = .searchFont
        searchController.searchBar.searchTextField.textColor = .mainWhite
        
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Setup collection view
    
    private func setupCollectionView() {
       
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainDark
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "WaitingChatsCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ActiveChatsCell")
        
    }
    
    private func setupCompositionalLayout() -> UICollectionViewLayout {
      
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
           
            guard let section = Section(rawValue: sectionIndex) else {
                
                 fatalError("Unknown section")
            }
            
            switch section {
                    
                case .waitingChats:
                    return self.setupWaitingChats()
                case .activeChats:
                    return self.setupActiveChats()
            }
            
        }
        
        return layout
    }
    
    private func setupWaitingChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(chatCellSize), heightDimension: .absolute(chatCellSize))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
       
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func setupActiveChats() -> NSCollectionLayoutSection {
       
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(chatCellSize))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
     
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
       
        return section
    }
    
    private func setupDataSource() {
      
        dataSource = UICollectionViewDiffableDataSource<Section, ChatModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
               
                fatalError("Unknown section")
            }
           
            switch section {
                
                case .waitingChats:

                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaitingChatsCell", for: indexPath)
                    cell.layer.cornerRadius = self.chatCellSize / 2
                    cell.backgroundColor = .yellow

                    return cell

                case .activeChats:
                    
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActiveChatsCell", for: indexPath)
                    
                    cell.backgroundColor = .blue
                   
                    return cell
            }
        })
    }
    
    private func reloadData() {
       
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatModel>()
        
        snapshot.appendSections([.waitingChats, .activeChats])
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(activeChats, toSection: .activeChats)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Search bar delegate
extension ChatsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct ChatsViewControllerProvider: PreviewProvider {
    
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