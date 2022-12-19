//
//  QuoteListPresentation.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 18.12.2022.
//

import Foundation

struct QuoteListPresentation {
    let quote: String
    
    init(quote: String) {
        self.quote = quote
    }
    
    init(quote: Quote) {
        self.quote = quote.quote
    }
}
