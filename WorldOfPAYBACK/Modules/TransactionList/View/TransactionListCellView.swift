//
//  TransactionListCellView.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import UIKit

class TransactionListCellView: UITableViewCell {
    
    var model: TransactionListItemModel? {
        didSet {
            injectDataToView()
        }
    }
    
    private lazy var partnerNamelabel: UILabel = createLabel(font: .boldSystemFont(ofSize: 16))
    private lazy var descriptionlabel: UILabel = createLabel(font: .systemFont(ofSize: 14), textColor: .darkGray)
    private lazy var valuelabel: UILabel = createLabel(font: .systemFont(ofSize: 16))
    private lazy var datelabel: UILabel = createLabel(font: .systemFont(ofSize: 12), textColor: .darkGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        constraintViews()
        injectDataToView()
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
    
    private func constraintViews() {
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
    
    private func injectDataToView() {
        partnerNamelabel.text = model?.partnerDisplayName
        descriptionlabel.text = model?.transactionDetailDescription
        valuelabel.text = String(describing: model?.valueAmount ?? 0) + " " + (model?.valueCurrency ?? "")
        datelabel.text = model?.bookingDate.description
    }
    
    private func createLabel(font: UIFont = .systemFont(ofSize: 17), textColor: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = textColor
        return label
    }
}
