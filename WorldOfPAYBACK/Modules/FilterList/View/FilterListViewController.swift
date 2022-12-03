//
//  FilterListViewController.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/30/22.
//

import Foundation
import UIKit

class FilterListViewController: UIViewController {
    
    private var viewModel: FilterListViewModel
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.delegate = self
        tableView.dataSource = self
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
        subscribeClicks()
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
    
    private func subscribeClicks() {
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
    
    @objc private func applyButtonTapped() {
        viewModel.emitFilteredList()
        self.dismiss(animated: true)
    }
}

extension FilterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.filterModel.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterListViewCell") as? FilterListViewCell else {
            return UITableViewCell()
        }
        let item = viewModel.filterModel.items[indexPath.row]
        cell.nameLabel.text = item.title
        cell.accessoryType = item.isSelected ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let isSelected = cell.accessoryType == .none
        cell.accessoryType = isSelected ? .checkmark : .none
        viewModel.changeItemIsSelected(indexPath: indexPath, isSelected: isSelected)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
