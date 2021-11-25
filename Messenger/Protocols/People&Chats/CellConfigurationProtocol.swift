//
//  CellConfigurationProtocol.swift
//  Messenger
//
//  Created by Alexander on 23.11.2021.
//

import Foundation

protocol CellConfigurationProtocol {
    
    static var reusableId: String { get }
    func cellConfiguration(with model: ChatModel)
}
