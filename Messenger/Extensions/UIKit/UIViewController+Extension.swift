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
    
    func showAlert(withTitle title: String, withMessage message: String, completion: @escaping () -> Void = { }) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in 
            
            completion()
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
