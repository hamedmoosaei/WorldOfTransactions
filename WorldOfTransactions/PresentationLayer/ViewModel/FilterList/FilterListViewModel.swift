//
//  FilterListViewModel.swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 11/30/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol FilterListViewModelProtocol {
    var filterList: Observable<[FilterItem]> { get }
    var title: String { get }
    var filteredListObservable: Observable<FilterListModel> { get }
    
    func changeItemIsSelected(indexPath: IndexPath, isSelected: Bool)
    func emitFilteredList()
}

class FilterListViewModel: FilterListViewModelProtocol {
    public var filterList: Observable<[FilterItem]>
    public var title: String
    public var filteredListObservable: Observable<FilterListModel>
    
    private var filteredList: PublishSubject<FilterListModel> = PublishSubject()
    private var filterModel: FilterListModel
    
    init(model: FilterListModel) {
        self.filterModel = model
        self.title = filterModel.title
        self.filterList = Observable.just(filterModel.items)
        self.filteredListObservable = filteredList.asObservable()
    }
    
    func changeItemIsSelected(indexPath: IndexPath, isSelected: Bool) {
        self.filterModel.items[indexPath.row].isSelected = isSelected
    }
    
    func emitFilteredList() {
        filteredList.onNext(filterModel)
    }
}
