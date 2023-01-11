//
//  TransactionListViewController.swift
//  WorldOfTransactions
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
        tableView.register(TransactionListCellView.self, forCellReuseIdentifier: "TransactionListCellView")
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var filterButton: UIBarButtonItem = {
        let image = UIImage(named: "FilterIcon")?.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(image: image)
        return button
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refreshControl
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
    
    private func configViewController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Transactions"
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(totalView)
        view.addSubview(activityIndicator)
        tableView.addSubview(refreshControl)
        navigationItem.rightBarButtonItem = filterButton
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
    
    private func setupBinding() {
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.totalText
            .asDriver(onErrorJustReturn: "")
            .drive(totalView.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .asDriver(onErrorJustReturn: false)
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        filterButton.rx
            .tap
            .subscribe(onNext: filterButtonTapped)
            .disposed(by: disposeBag)
        
        refreshControl.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: refresh)
            .disposed(by: disposeBag)
    }
    
    private func filterButtonTapped() {
        let filterViewModel = viewModel.createFilterViewModel()
        let filterViewController = FilterListViewController(viewModel: filterViewModel)
        present(filterViewController, animated: true)
    }
    
    private func refresh() {
        viewModel.fetchTransactions()
        refreshControl.endRefreshing()
    }
}

extension TransactionListViewController: UITableViewDelegate {
    
    private func bindTableViewDataSource() {
        viewModel.transactionModel
            .bind(to: tableView.rx.items(cellIdentifier: "TransactionListCellView", cellType: TransactionListCellView.self)) { (row, model, cell) in
                cell.transactionModel.onNext(model)
            }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDetailViewModel = viewModel.createDetailViewModel(indexPath: indexPath)
        let selectedDetailViewController = transactionDetailViewController(viewModel: selectedDetailViewModel)
        navigationController?.pushViewController(selectedDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
