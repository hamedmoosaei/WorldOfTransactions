//
//  FilterListCellView.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/30/22.
//

import Foundation
import UIKit

class FilterListViewCell: UITableViewCell {
    
    var name: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
