//
//  ChatsViewController.swift
//  Messenger
//
//  Created by Alexander on 20.11.2021.
//

import UIKit
import FirebaseFirestore

class ChatsViewController: UIViewController {

    // MARK: - Constants
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
    
    var waitingChats = [ChatModel]()
    var activeChats = [ChatModel]()
    var waitingChatListener: ListenerRegistration?
    var activeChatListener: ListenerRegistration?
    
    // MARK: - Presenter
    var presenter: ChatsViewPresenterProtocol!
    
    deinit {
        
        waitingChatListener?.remove()
        activeChatListener?.remove()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainDark

        searchBar.setupSearchBar(navigationItem: navigationItem, delegate: self)
        setupCollectionView()
        setupDataSource()
        reloadData(with: nil)
        
        waitingChatListener = presenter.waitingChatListener
        activeChatListener = presenter.activeChatListener
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getUsername()
    }
}

// MARK: - Chats view protocol
extension ChatsViewController: ChatsViewProtocol {
   
    func updateView(username: String) {
        
        self.navigationItem.title = username
        
        navigationItem.setAppearance(font: UIFont.secondaryFont!, color: UIColor.mainWhite)
    }
   
    func updateWaitingChats(waitingChats: [ChatModel]) {
        
        self.waitingChats = waitingChats
        reloadData(with: nil)
       
        if self.waitingChats != [], self.waitingChats.count <= waitingChats.count {
            
            presenter.toRequestChat(chat: waitingChats.last!)
        }
        
    }
    
    func updateActiveChats(activeChats: [ChatModel]) {
        
        self.activeChats = activeChats
        reloadData(with: nil)
    }
}

// MARK: - Collection view delegate
extension ChatsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let chat = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
            case .waitingChats:
                presenter.toRequestChat(chat: chat)
            case .activeChats:
                presenter.toConversationScreen(chat: chat, user: UserModel(username: "Text", email: "Text", description: "Text", gender: "Male", userImageUrl: "String", id: "kdjalhdhfahdfjdhfkjahkdkafhjkdf"))
        }
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
        
        collectionView.delegate = self
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
