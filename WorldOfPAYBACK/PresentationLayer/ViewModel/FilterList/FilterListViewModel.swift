//
//  FilterListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/30/22.
//

import Foundation
import RxSwift

class FilterListViewModel {
    var filterModel: FilterListModel
    
    var tableViewModel: Observable<[FilterItem]> {
        return Observable.just(filterModel.items)
    }
    
    var filteredList: PublishSubject<FilterListModel> = PublishSubject()
    
    init(model: FilterListModel) {
        self.filterModel = model
    }
    
    func changeItemIsSelected(indexPath: IndexPath, isSelected: Bool) {
        self.filterModel.items[indexPath.row].isSelected = isSelected
    }
    
    func emitFilteredList() {
        filteredList.onNext(filterModel)
    }
}
