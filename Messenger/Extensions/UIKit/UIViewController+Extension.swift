//
//  UIViewController+Extension.swift
//  Messenger
//
//  Created by Alexander on 27.11.2021.
//

import UIKit

extension UIViewController {
    
    func cellConfiguration<T: CellConfigurationProtocol, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with model: U, at indexPath: IndexPath) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reusableId, for: indexPath) as? T else {
           
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.cellConfiguration(with: model)
        
        return cell
    }
}
