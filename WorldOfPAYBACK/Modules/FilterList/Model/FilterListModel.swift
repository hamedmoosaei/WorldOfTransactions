//
//  FilterListModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/30/22.
//

import Foundation

struct FilterListModel {
    let title: String
    var items: [FilterItem]
}

struct FilterItem {
    let title: String
    var isSelected: Bool
}
