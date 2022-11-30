//
//  FilterListViewController.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/30/22.
//

import Foundation
import UIKit

class FilterListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
    }
    
    private func addViews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
}
