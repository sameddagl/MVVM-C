//
//  AuthorDetailVM.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import Foundation

final class AuthorDetailVM: AuthorDetailVMProtocol {
    weak var delegate: AuthorDetailViewDelegate?
    
    //MARK: - Injections
    private let authorName: String
    private var service: NetworkServiceProtocol
    private weak var coordinator: MainCoordinator?
    
    init(authorName: String, service: NetworkServiceProtocol, coordinator: MainCoordinator) {
        self.authorName = authorName
        self.service = service
        self.coordinator = coordinator
    }
    
    //MARK: - Properties
    private var quotes = [Quote]()
    
    func load() {
        notify(.updateTitle(title: authorName))
        notify(.startLoading)
        service.fetchData { [weak self] result in
            guard let self = self else { return }
            self.notify(.endLoading)
            switch result {
            case .success(let quotes):
                self.quotes = quotes
                let filteredQuotes = self.quotes.filter { $0.author == self.authorName }
                let presentation = filteredQuotes.map { QuoteListPresentation(quote: $0) }
                self.notify(.updateWith(quotes: presentation))
            case .failure(let error):
                self.notify(.failWithError(title: "An error occured", message: error.rawValue))
            }
        }
    }
    
    func backToRootTapped() {
        navigate(to: .root)
    }
    
    private func navigate(to root: AuthorDetailRoute) {
        switch root {
        case .root:
            coordinator?.popToRoot()
        }
    }
    
    private func notify(_ output: AuthorDetailOutput) {
        delegate?.handleOutput(output)
    }
}
