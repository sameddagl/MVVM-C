//
//  QuoteListVC.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 18.12.2022.
//

import UIKit

final class QuoteListVC: UIViewController {
    
    private var tableView: UITableView!
    
    //MARK: - Injections
    var viewModel: QuoteListVMProtocol!
    
    //MARK: - Properties
    private var quotes = [QuoteListPresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
        viewModel.load()
    }
}

//MARK: - View Model Outputs
extension QuoteListVC: QuoteListViewDelegate {
    func handleOutput(_ output: QuoteListOutput) {
        switch output {
        case .startLoading:
            print("start")
        case .endLoading:
            print("end")
        case .updateWith(let quotes):
            self.quotes = quotes
            self.tableView.reloadOnMainThread()
        case .failWithError(let title, let message):
            print(title, message)
        }
    }
}

//MARK: - Table View Delegates
extension QuoteListVC: UITableViewDataSource {
    
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

extension QuoteListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath.row)
    }
}

//MARK: - UI Related
extension QuoteListVC {
    private func layoutView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
