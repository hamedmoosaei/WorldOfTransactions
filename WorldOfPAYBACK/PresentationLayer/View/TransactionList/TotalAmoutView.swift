//
//  TotalAmoutView.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/27/22.
//

import Foundation
import UIKit

class TotalAmountView: UIView {
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total Value: "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configView()
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray4
    }
    
    func addViews() {
        addSubview(totalLabel)
        addSubview(valueLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            totalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
