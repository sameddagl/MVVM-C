//
//  QuoteDetailContracts.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import Foundation

protocol QuoteDetailVMProtocol {
    var delegate: QuoteDetailViewDelegate? { get set }
    func load()
    func authorTapped()
}

enum QuoteDetailOutput {
    case updateWith(quote: String, author: String)
}

enum QuoteDetailRoute {
    case authorDetail(authorName: String)
}

protocol QuoteDetailViewDelegate: AnyObject {
    func handleOutput(_ output: QuoteDetailOutput)
}
