//
//  TransactionListViewModel.swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import RxSwift
import RxCocoa

class TransactionListViewModel {
    
    public private(set) var transactionModel: BehaviorRelay<[TransactionListItemModel]> = BehaviorRelay(value: [])
    public private(set) var isLoading: PublishSubject<Bool> = PublishSubject()
    public private(set) var totalText: PublishSubject<String> = PublishSubject()
    
    private let transactionRepository: TransactionListRepository
    
    private var filterListModel: FilterListModel = FilterListModel(title: "Category", items: [])
    private var disposeBag = DisposeBag()

    init(transactionRepository: TransactionListRepository) {
        self.transactionRepository = transactionRepository
    }
    
    func fetchTransactions() {
        isLoading.onNext(true)
        transactionRepository.getTransactionList().subscribe(onNext: saveNewTransactionList).disposed(by: disposeBag)
    }
    
    func createFilterViewModel() -> FilterListViewModel {
        let viewModel = FilterListViewModel(model: filterListModel)
        viewModel.filteredList.subscribe(onNext: filterTransactionList).disposed(by: disposeBag)
        return viewModel
    }
    
    func createDetailViewModel(indexPath: IndexPath) -> TransactionDetailViewModel {
        let selectedModel = transactionModel.value[indexPath.row]
        let detailModel = TransactionDetailModel(partnerDisplayName: selectedModel.displayName, transactionDetailDescription: selectedModel.description)
        let detailViewModel = TransactionDetailViewModel(transactionDetailModel: detailModel)
        return detailViewModel
    }
    
    private func saveNewTransactionList(model: [TransactionBusinessModel]) {
        filterListModel.items = transactionRepository.getCategories().map(FilterItem.init(value: ))
        showNewTransactionList(model: model)
    }
    
    private func showNewTransactionList(model: [TransactionBusinessModel]) {
        calculateTotalText(items: model)
        transactionModel.accept(model.map(TransactionListItemModel.init(model:)))
        isLoading.onNext(false)
    }
    
    private func filterTransactionList(newFilterModel: FilterListModel) {
        self.filterListModel = newFilterModel
        let filterModel = newFilterModel.items.filter({ $0.isSelected }).map({ Int($0.title) ?? 0 })
        transactionRepository.getFilteredTransactionByCategory(selectedCategories: filterModel).subscribe(onNext: showNewTransactionList).disposed(by: disposeBag)
    }

    private func calculateTotalText(items: [TransactionBusinessModel]) {
        let currency = !items.isEmpty ? items[0].valueCurrency ?? "" : ""
        let text = String(describing: calculateTotalValue(items: items)) + " " + currency
        totalText.onNext(text)
    }
    
    private func calculateTotalValue(items: [TransactionBusinessModel]) -> Int {
        return items.reduce(0) { partialResult, transactionListItemModel in
            return partialResult + transactionListItemModel.valueAmount
        }
    }
}
