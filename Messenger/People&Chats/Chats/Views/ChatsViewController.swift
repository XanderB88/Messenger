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
    let chatCellSize: CGFloat = 88
    
    enum Section: Int, CaseIterable {
       
        case waitingChats, activeChats
        
        func description() -> String {
            
            switch self {
                case .waitingChats:
                    return "Waiting chats"
                case .activeChats:
                    return "Active chats"
            }
        }
    }
   
    // MARK: - Variables
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, ChatModel>?
    var searchBar = SearchBar()
    
    // MARK: - Presenter
    
    var presenter: ChatsViewPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainDark
        
        searchBar.setupSearchBar(navigationItem: navigationItem, delegate: self)
        setupCollectionView()
        setupDataSource()
        reloadData(with: nil)
        
        presenter.getUsername()
    }
}

// MARK: - Chats view protocol
extension ChatsViewController: ChatsViewProtocol {
    
    func updateView(user: UserModel) {
        
        self.title = user.username
    }
}

extension ChatsViewController {
    
    // MARK: - Setup collection view
    private func setupCollectionView() {
       
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainDark
        view.addSubview(collectionView)
        
        collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.reusableId)
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reusableId)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reusableId)
    
    }
    
    // MARK: - Setup compositional layout
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
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 30
        layout.configuration = configuration
        
        return layout
    }
    
    // MARK: - Setup layout configuration for chats
    private func setupWaitingChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(chatCellSize), heightDimension: .absolute(chatCellSize))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
       
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
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
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
       
        return section
    }
   
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
    
    // MARK: - Collection View Diffable Data Source
   
    private func setupDataSource() {
      
        dataSource = UICollectionViewDiffableDataSource<Section, ChatModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
               
                fatalError("Unknown section")
            }
           
            switch section {
                case .waitingChats:
                    return self.cellConfiguration(collectionView: collectionView, cellType: WaitingChatCell.self, with: chat, at: indexPath)
                case .activeChats:
                    return self.cellConfiguration(collectionView: collectionView, cellType: ActiveChatCell.self, with: chat, at: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider  = { collectionView, kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reusableId, for: indexPath) as? SectionHeader else {
                
                fatalError("Can't create a new section header")
            }
            
            guard let section = Section(rawValue: indexPath.section) else {
                
                fatalError("Unknown section kind")
            }
                    
            sectionHeader.configTitle(text: section.description(), font: .secondaryFont, textColor: .mainWhite)
            
            return sectionHeader
        }
    }
    
    // MARK: - Reload data
    private func reloadData(with searchText: String?) {
        
        let filteredActiveChats = activeChats.filter { (activeChat) -> Bool in
            activeChat.containsChatWithUser(filter: searchText)
        }
       
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatModel>()
        
        snapshot.appendSections([.waitingChats, .activeChats])
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(filteredActiveChats, toSection: .activeChats)
       
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Search bar delegate
extension ChatsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(with: searchText)
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
        
        let viewController = PeopleAndChatsTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
