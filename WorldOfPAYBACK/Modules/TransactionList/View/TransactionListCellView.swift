//
//  TransactionListCellView.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import UIKit
import RxSwift

class TransactionListCellView: UITableViewCell {
    
    let transactionModel: PublishSubject<TransactionListItemModel> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    
    private lazy var partnerNamelabel: UILabel = createLabel(font: .boldSystemFont(ofSize: 16))
    private lazy var descriptionlabel: UILabel = createLabel(font: .systemFont(ofSize: 14), textColor: .darkGray)
    private lazy var valuelabel: UILabel = createLabel(font: .systemFont(ofSize: 16))
    private lazy var datelabel: UILabel = createLabel(font: .systemFont(ofSize: 12), textColor: .darkGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBinding() {
        transactionModel.subscribe(onNext: { model in
            model.displayName
                .asDriver(onErrorJustReturn: "")
                .drive(self.partnerNamelabel.rx.text)
                .disposed(by: self.disposeBag)
            
            model.description
                .asDriver(onErrorJustReturn: "")
                .drive(self.descriptionlabel.rx.text)
                .disposed(by: self.disposeBag)
            
            model.valueAndCurrency
                .asDriver(onErrorJustReturn: "")
                .drive(self.valuelabel.rx.text)
                .disposed(by: self.disposeBag)
            
            model.date
                .asDriver(onErrorJustReturn: "")
                .drive(self.datelabel.rx.text)
                .disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
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
