//
//  TransactionListViewController.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TransactionListViewController: UIViewController {
    private var viewModel: TransactionListViewModel
    private var disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(TransactionListCellView.self, forCellReuseIdentifier: "TransactionListCellView")
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var totalView = TotalAmountView()
    
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
        setupBinding()
        bindTableViewDataSource()
        viewModel.fetchTransactions()
    }
    
    private func setupBinding() {
        viewModel.totalText
            .asDriver(onErrorJustReturn: "")
            .drive(self.totalView.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .asDriver(onErrorJustReturn: false)
            .drive(self.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    private func configViewController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Transactions"
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(totalView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            totalView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension TransactionListViewController: UITableViewDelegate {
    
    func bindTableViewDataSource() {
        viewModel.model
            .bind(to: tableView.rx.items(cellIdentifier: "TransactionListCellView", cellType: TransactionListCellView.self)) { (row, model, cell) in
                model.partnerDisplayName
                    .asDriver(onErrorJustReturn: "")
                    .drive(cell.partnerNamelabel.rx.text)
                    .disposed(by: self.disposeBag)
                
                model.description
                    .asDriver(onErrorJustReturn: "")
                    .drive(cell.descriptionlabel.rx.text)
                    .disposed(by: self.disposeBag)
                
                model.valueAndCurrency
                    .asDriver(onErrorJustReturn: "")
                    .drive(cell.valuelabel.rx.text)
                    .disposed(by: self.disposeBag)
                
                model.bookingDate
                    .asDriver(onErrorJustReturn: "")
                    .drive(cell.datelabel.rx.text)
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
    }
}
