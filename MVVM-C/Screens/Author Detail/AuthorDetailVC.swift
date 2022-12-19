//
//  AuthorDetailVC.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import UIKit

final class AuthorDetailVC: UIViewController {
    //MARK: - UI Properties
    private var tableView: UITableView!
    
    //MARK: - Injections
    var viewModel: AuthorDetailVMProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    //MARK: - Properties
    private var quotes = [QuoteListPresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        layout()
    }
    
    //MARK: - Button Actions
    @objc private func backToRootTapped() {
        viewModel.backToRootTapped()
    }
}

//MARK: - View Model Outputs
extension AuthorDetailVC: AuthorDetailViewDelegate {
    func handleOutput(_ output: AuthorDetailOutput) {
        switch output {
        case .startLoading:
            print("start")
        case .endLoading:
            print("end")
        case .updateTitle(let title):
            self.title = title
        case .updateWith(let quotes):
            self.quotes = quotes
            self.tableView.reloadOnMainThread()
        case .failWithError(let title, let message):
            print(title, message)
        }
    }
}

//MARK: - Table View Delegates
extension AuthorDetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = quotes[indexPath.row].quote
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

//MARK: - UI Related
extension AuthorDetailVC {
    private func layout() {
        configureView()
        createTableView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        let backToRootButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backToRootTapped))
        navigationItem.rightBarButtonItem = backToRootButton
    }
    
    private func createTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

