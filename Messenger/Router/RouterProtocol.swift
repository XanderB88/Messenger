//
//  RouterProtocol.swift
//  Messenger
//
//  Created by Alexander on 04.12.2021.
//

import UIKit

protocol RouterProtocol: AnyObject {
    
    var window: UIWindow? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    init(window: UIWindow?, assemblyBuilder: AssemblyBuilderProtocol)
}
