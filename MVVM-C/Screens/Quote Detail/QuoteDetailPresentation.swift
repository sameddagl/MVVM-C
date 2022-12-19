//
//  QuoteDetailPresentation.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import Foundation

struct QuoteDetailPresentation {
    let quote: String
    let author: String
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }
    
    init(quote: Quote) {
        self.quote = quote.quote
        self.author = quote.author
    }
}
