//
//  TransactionListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import RxSwift
import RxCocoa

class TransactionListViewModel {
    
    var transactionModel: BehaviorRelay<[TransactionListItemModel]> = BehaviorRelay(value: [])
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var totalText: PublishSubject<String> = PublishSubject()
    
    private var modelBackUp: [TransactionListItemModel] = []
    private var filterModel: FilterListModel = FilterListModel(title: "", items: [])
    private var disposeBag = DisposeBag()
    
    func fetchTransactions() {
        let request: MockRequest<TransactionDecodableModel> = MockRequest(endPoint: .transactionList)
        isLoading.onNext(true)
        request.perform().subscribe(onNext: saveNewTransactionModel).disposed(by: disposeBag)
    }
    
    func createFilterViewModel() -> FilterListViewModel {
        let viewModel = FilterListViewModel(model: filterModel)
        viewModel.filteredList.subscribe(onNext: filterTransactionList).disposed(by: disposeBag)
        return viewModel
    }
    
    func createDetailViewModel(indexPath: IndexPath) -> TransactionDetailViewModel {
        let selectedModel = transactionModel.value[indexPath.row]
        let detailModel = TransactionDetailModel(partnerDisplayName: selectedModel.partnerDisplayName,
                                                 transactionDetailDescription: selectedModel.transactionDetailDescription)
        let detailViewModel = TransactionDetailViewModel(transactionDetailModel: detailModel)
        return detailViewModel
    }
    
    func calculateTotalText(items: [TransactionListItemModel]) -> String {
        let currency = !items.isEmpty ? items[0].valueCurrency ?? "" : ""
        let text = String(describing: calculateTotalValue(items: items)) + " " + currency
        return text
    }
    
    private func saveNewTransactionModel(decodableModel: TransactionDecodableModel) {
        let model = decodableModel.items.map(TransactionListItemModel.init).sorted(by: >)
        transactionModel.accept(model)
        modelBackUp = model
        generateFilterModel(model: model)
        isLoading.onNext(false)
    }
    
    private func filterTransactionList(newFilterModel: FilterListModel) {
        filterModel = newFilterModel
        let selectedItems = filterModel.items.filter({$0.isSelected}).compactMap({Int($0.title)})
        let newModelToShow = modelBackUp.filter({selectedItems.contains($0.category)})
        transactionModel.accept(newModelToShow)
    }
    
    private func generateFilterModel(model: [TransactionListItemModel]) {
        let mapedModel = Array(Set(model.map({$0.category}))).sorted(by: <)
        filterModel = FilterListModel(title: "Category", items: mapedModel.map({FilterItem(title: String(describing: $0), isSelected: true)}))
    }
    
    private func calculateTotalValue(items: [TransactionListItemModel]) -> Int {
        return items.reduce(0) { partialResult, transactionListItemModel in
            return partialResult + transactionListItemModel.valueAmount
        }
    }
}
