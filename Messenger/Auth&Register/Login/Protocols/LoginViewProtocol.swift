//
//  LoginViewProtocol.swift
//  Messenger
//
//  Created by Alexander on 04.12.2021.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    
    func success()
    func failure(error: Error)
}
