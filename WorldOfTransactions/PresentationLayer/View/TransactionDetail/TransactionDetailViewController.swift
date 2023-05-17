//
//  TransactionDetailViewController.swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 12/4/22.
//

import Foundation
import UIKit

class transactionDetailViewController: UIViewController {
    private let viewModel: TransactionDetailViewModelProtocol
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(viewModel: TransactionDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        injectDataToView()
    }
    
    private func injectDataToView() {
        nameLabel.text = viewModel.transactionDetailModel.partnerDisplayName
        descriptionLabel.text = viewModel.transactionDetailModel.transactionDetailDescription
    }
    
    private func addViews() {
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
