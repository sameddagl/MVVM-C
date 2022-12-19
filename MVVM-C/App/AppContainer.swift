//
//  AppContainer.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 18.12.2022.
//

import Foundation

struct AppContainer {
    static let shared = AppContainer()
    
    let service = NetworkService()
}
