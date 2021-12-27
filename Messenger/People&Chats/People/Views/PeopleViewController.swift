//
//  PeopleViewController.swift
//  Messenger
//
//  Created by Alexander on 20.11.2021.
//

import UIKit
import FirebaseFirestore

class PeopleViewController: UIViewController {

    // MARK: - Constants
    enum Section: Int, CaseIterable {
       
        case users
    }
   
    // MARK: - Variables
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, UserModel>?
    var searchBar = SearchBar()
    
    var users = [UserModel]()
    var currentUser: UserModel?
    var userListener: ListenerRegistration?
    
    // MARK: - Presenter
    var presenter: PeopleViewPresenterProtocol!
    
    deinit {
        
        userListener?.remove()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainDark
        
        searchBar.setupSearchBar(navigationItem: navigationItem, delegate: self)
        setupCollectionView()
        setupDataSource()
        reloadData(with: nil)
        
        userListener = presenter.userListener
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getUserInfo()
        
    }
}

// MARK: - People View Protocol
extension PeopleViewController: PeopleViewProtocol {
    
    func updateUsers(users: [UserModel]) {
        
        self.users = users
        reloadData(with: nil)
    }
    
    func updateView(currentUser: UserModel) {
        
        self.currentUser = currentUser
        
        self.navigationItem.title = currentUser.username
        
        navigationItem.setAppearance(font: UIFont.secondaryFont!, color: UIColor.mainWhite)
        
    }
}

extension PeopleViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let user = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        
        presenter.toProfileScreen(user: user, currentUser: self.currentUser!)
    }
}

extension PeopleViewController {
    
    // MARK: - Setup collection view
    private func setupCollectionView() {
       
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainDark
        view.addSubview(collectionView)
        
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reusableId)
        
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
                case .users:
                    return self.setupUsers()
            }
            
        }
        
        return layout
    }
    
    // MARK: - Setup layout configuration for chats
    private func setupUsers() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
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
      
        dataSource = UICollectionViewDiffableDataSource<Section, UserModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
               
                fatalError("Unknown section")
            }
           
            switch section {
                case .users:
                    return self.cellConfiguration(collectionView: collectionView, cellType: UserCell.self, with: user, at: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider  = { collectionView, kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reusableId, for: indexPath) as? SectionHeader else {
                
                fatalError("Can't create a new section header")
            }
                              
            sectionHeader.configTitle(text: "People", font: .secondaryFont, textColor: .mainWhite)
            
            return sectionHeader
        }
    }
    
    // MARK: - Reload data
    private func reloadData(with searchText: String?) {
        
        let filteredUsers = users.filter { (user) -> Bool in
            
            user.containsUser(filter: searchText)
        }
       
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserModel>()
        
        snapshot.appendSections([.users])
        snapshot.appendItems(filteredUsers, toSection: .users)
       
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Search bar delegate
extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        reloadData(with: searchText)
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
        
        let viewController = PeopleAndChatsTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
