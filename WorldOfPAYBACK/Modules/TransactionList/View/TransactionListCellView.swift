//
//  TransactionListCellView.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import UIKit

class TransactionListCellView: UITableViewCell {
    
    lazy var partnerNamelabel: UILabel = createLabel(font: .boldSystemFont(ofSize: 16))
    lazy var descriptionlabel: UILabel = createLabel(font: .systemFont(ofSize: 14), textColor: .darkGray)
    lazy var valuelabel: UILabel = createLabel(font: .systemFont(ofSize: 16))
    lazy var datelabel: UILabel = createLabel(font: .systemFont(ofSize: 12), textColor: .darkGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(partnerNamelabel)
        contentView.addSubview(descriptionlabel)
        contentView.addSubview(valuelabel)
        contentView.addSubview(datelabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            partnerNamelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            partnerNamelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            descriptionlabel.topAnchor.constraint(equalTo: partnerNamelabel.bottomAnchor, constant: 8),
            descriptionlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            descriptionlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            valuelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            valuelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            datelabel.topAnchor.constraint(equalTo: valuelabel.bottomAnchor, constant: 8),
            datelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            datelabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private func createLabel(font: UIFont = .systemFont(ofSize: 17), textColor: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = textColor
        return label
    }
}
