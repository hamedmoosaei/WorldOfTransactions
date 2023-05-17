//
//  TransactionListViewModel.swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol TransactionListViewModelProtocol {
    func fetchTransactions()
    func createFilterViewModel() -> FilterListViewModelProtocol
    func createDetailViewModel(indexPath: IndexPath) -> TransactionDetailViewModel
    
    var transactionModelObservable: Observable<[TransactionListItemModel]> { get }
    var isLoadingDriver: Driver<Bool> { get }
    var totalTextDriver: Driver<String> { get }
}

class TransactionListViewModel: TransactionListViewModelProtocol {
    
    public var transactionModelObservable: Observable<[TransactionListItemModel]>
    public var isLoadingDriver: Driver<Bool>
    public var totalTextDriver: Driver<String>
    
    private var transactionModel: BehaviorRelay<[TransactionListItemModel]> = BehaviorRelay(value: [])
    private var isLoading: PublishSubject<Bool> = PublishSubject()
    private var totalText: PublishSubject<String> = PublishSubject()
    
    private let transactionRepository: TransactionListRepository
    
    private var filterListModel: FilterListModel = FilterListModel(title: "Category", items: [])
    private var disposeBag = DisposeBag()

    init(transactionRepository: TransactionListRepository) {
        self.transactionRepository = transactionRepository
        self.transactionModelObservable = transactionModel.asObservable()
        self.isLoadingDriver = isLoading.asDriver(onErrorJustReturn: false)
        self.totalTextDriver = totalText.asDriver(onErrorJustReturn: "")
    }
    
    public func fetchTransactions() {
        isLoading.onNext(true)
        transactionRepository.getTransactionList().subscribe(onNext: saveNewTransactionList).disposed(by: disposeBag)
    }
    
    public func createFilterViewModel() -> FilterListViewModelProtocol {
        let viewModel = FilterListViewModel(model: filterListModel)
        viewModel.filteredListObservable.subscribe(onNext: filterTransactionList).disposed(by: disposeBag)
        return viewModel
    }
    
    public func createDetailViewModel(indexPath: IndexPath) -> TransactionDetailViewModel {
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
