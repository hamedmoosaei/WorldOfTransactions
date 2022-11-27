//
//  TransactionListViewController.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import UIKit

class TransactionListViewController: UIViewController {
    private var viewModel: TransactionListViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionListCellView.self, forCellReuseIdentifier: "TransactionListCellView")
        return tableView
    }()
    
    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        addViews()
        setupConstraints()
        viewModel.fetchTransactions()
        
    }
    
    private func configViewController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Transactions"
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
extension TransactionListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.itemsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TransactionListCellView") as? TransactionListCellView else {
            return UITableViewCell()
        }
        guard let models = viewModel.model else {
            return UITableViewCell()
        }
        cell.model = models[indexPath.row]
        return cell
    }
}
