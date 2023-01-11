//
//  FilterListViewController.swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 11/30/22.
//

import Foundation
import UIKit
import RxSwift

class FilterListViewController: UIViewController {
    
    private var viewModel: FilterListViewModel
    private var disposeBag = DisposeBag()
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.register(FilterListViewCell.self, forCellReuseIdentifier: "FilterListViewCell")
        return tableView
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Apply", for: .normal)
        return button
    }()
    
    init(viewModel: FilterListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        setupBindings()
        bindTableViewDataSource()
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(applyButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor),
            
            applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            applyButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupBindings() {
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        applyButton.rx
            .tap
            .subscribe(onNext: applyButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func applyButtonTapped() {
        viewModel.emitFilteredList()
        self.dismiss(animated: true)
    }
}

extension FilterListViewController: UITableViewDelegate {
    
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.filterModel.title
    }
    
    private func bindTableViewDataSource() {
        viewModel.tableViewModel.bind(to: tableView.rx.items(cellIdentifier: "FilterListViewCell", cellType: FilterListViewCell.self)) { (row, model, cell) in
            cell.nameLabel.text = model.title
            cell.accessoryType = model.isSelected ? .checkmark : .none
        }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let isSelected = cell.accessoryType == .none
        cell.accessoryType = isSelected ? .checkmark : .none
        viewModel.changeItemIsSelected(indexPath: indexPath, isSelected: isSelected)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
