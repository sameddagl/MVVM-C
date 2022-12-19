//
//  QuoteDetailVC.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import UIKit

final class QuoteDetailVC: UIViewController {
    //MARK: - UI Properties
    private let quoteLabel = UILabel()
    private let authorButton = UIButton()
    
    //MARK: - Injections
    var viewModel: QuoteDetailVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    //MARK: - Properties
    
    override func viewDidLoad() {
        viewModel.load()
        layout()
    }
    
    //MARK: - Button Actions
    @objc private func authorTapped() {
        viewModel.authorTapped()
    }
}

//MARK: - View Model Outputs
extension QuoteDetailVC: QuoteDetailViewDelegate {
    func handleOutput(_ output: QuoteDetailOutput) {
        switch output {
        case .updateWith(let quote, let author):
            quoteLabel.text = quote
            authorButton.setTitle(author, for: .normal)
        }
    }
}

//MARK: - UI Related
extension QuoteDetailVC {
    private func layout() {
        configureView()
        configureLabels()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLabels() {
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        authorButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(quoteLabel)
        view.addSubview(authorButton)
        
        quoteLabel.numberOfLines = 0
        authorButton.titleLabel?.numberOfLines = 0
    
        quoteLabel.textAlignment = .center
        authorButton.titleLabel?.textAlignment = .center
        authorButton.setTitleColor(.link, for: .normal)
        
        authorButton.addTarget(self, action: #selector(authorTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            quoteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quoteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            quoteLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            authorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorButton.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 20),
            authorButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)

        ])
    }
}
