//
//  QuoteDetailVM.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import Foundation

final class QuoteDetailVM: QuoteDetailVMProtocol {
    
    weak var delegate: QuoteDetailViewDelegate?
    
    //MARK: - Injections
    private var quote: Quote
    private weak var coordinator: MainCoordinator?
    
    init(quote: Quote, coordinator: MainCoordinator) {
        self.quote = quote
        self.coordinator = coordinator
    }
    
    func load() {
        notify(.updateWith(quote: quote.quote, author: quote.author))
    }
    
    func authorTapped() {
        navigate(to: .authorDetail(authorName: quote.author))
    }
    
    private func navigate(to root: QuoteDetailRoute) {
        switch root {
        case .authorDetail(let authorName):
            coordinator?.goToAuthorDetail(authorName: authorName)
        }
    }
    
    private func notify(_ output: QuoteDetailOutput) {
        delegate?.handleOutput(output)
    }
}
