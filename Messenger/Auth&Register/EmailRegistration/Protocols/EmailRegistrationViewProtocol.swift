//
//  EmailRegistrationViewProtocol.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import Foundation

protocol EmailRegistrationViewProtocol: AnyObject {
    
    func success()
    func failure(error: Error)
}
