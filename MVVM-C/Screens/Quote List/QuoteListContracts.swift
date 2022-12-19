//
//  QuoteListContracts.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 18.12.2022.
//

import Foundation

protocol QuoteListVMProtocol {
    var delegate: QuoteListViewDelegate? { get set }
    func load()
    func selectItem(at index: Int)
}

enum QuoteListOutput {
    case startLoading
    case endLoading
    case updateWith(quotes: [QuoteListPresentation])
    case failWithError(title: String, message: String)
}

enum QuoteListRoute {
    case detail(quote: Quote)
}

protocol QuoteListViewDelegate: AnyObject {
    func handleOutput(_ output: QuoteListOutput)
}
