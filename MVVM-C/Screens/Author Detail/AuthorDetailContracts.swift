//
//  AuthorDetailContracts.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import Foundation

protocol AuthorDetailVMProtocol {
    var delegate: AuthorDetailViewDelegate? { get set }
    func load()
    func backToRootTapped()
}

enum AuthorDetailOutput {
    case startLoading
    case endLoading
    case updateTitle(title: String)
    case updateWith(quotes: [QuoteListPresentation])
    case failWithError(title: String, message: String)
}

enum AuthorDetailRoute {
    case root
}

protocol AuthorDetailViewDelegate: AnyObject {
    func handleOutput(_ output: AuthorDetailOutput)
}
