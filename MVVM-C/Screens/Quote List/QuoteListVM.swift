//
//  QuoteListVM.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 18.12.2022.
//

import Foundation

final class QuoteListVM: QuoteListVMProtocol {
    weak var delegate: QuoteListViewDelegate?
    
    //MARK: - Injections
    private var service: NetworkServiceProtocol
    private weak var coordinator: MainCoordinator?

    init(service: NetworkServiceProtocol, coordinator: MainCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    //MARK: - Properties
    private var quotes = [Quote]()
    
    func load() {
        notify(.startLoading)
        service.fetchData { [weak self] result in
            guard let self = self else { return }
            self.notify(.endLoading)
            switch result {
            case .success(let quotes):
                self.quotes = quotes
                
                let presentation = quotes.map{ QuoteListPresentation(quote: $0) }
                self.notify(.updateWith(quotes: presentation))
            case .failure(let error):
                self.notify(.failWithError(title: "An error occured", message: error.rawValue))
            }
        }
    }
    
    func selectItem(at index: Int) {
        let selectedQuote = quotes[index]
        navigate(to: .detail(quote: selectedQuote))
    }
    
    private func navigate(to root: QuoteListRoute) {
        switch root {
        case .detail(let quote):
            coordinator?.goToDetail(quote: quote)
        }
    }
    
    private func notify(_ output: QuoteListOutput) {
        delegate?.handleOutput(output)
    }
}
