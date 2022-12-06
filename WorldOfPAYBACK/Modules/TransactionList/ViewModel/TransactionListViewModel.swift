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
    
    var transactionModel: BehaviorRelay<[TransactionItemViewModel]> = BehaviorRelay(value: [])
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var totalText: PublishSubject<String> = PublishSubject()
    
    private var modelBackUp: [TransactionItemViewModel] = []
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
        let detailModel = TransactionDetailModel(partnerDisplayName: selectedModel.transaction.partnerDisplayName,
                                                 transactionDetailDescription: selectedModel.transaction.transactionDetailDescription)
        let detailViewModel = TransactionDetailViewModel(transactionDetailModel: detailModel)
        return detailViewModel
    }
    
    func calculateTotalText(items: [TransactionItemViewModel]) -> String {
        let currency = !items.isEmpty ? items[0].transaction.valueCurrency ?? "" : ""
        let text = String(describing: calculateTotalValue(items: items)) + " " + currency
        return text
    }
    
    private func saveNewTransactionModel(decodableModel: TransactionDecodableModel) {
        let model = decodableModel.items.map(TransactionItemViewModel.init).sorted(by: >)
        transactionModel.accept(model)
        modelBackUp = model
        generateFilterModel(model: model)
        isLoading.onNext(false)
    }
    
    private func filterTransactionList(newFilterModel: FilterListModel) {
        filterModel = newFilterModel
        let selectedItems = filterModel.items.filter({$0.isSelected}).compactMap({Int($0.title)})
        let newModelToShow = modelBackUp.filter({selectedItems.contains($0.transaction.category)})
        transactionModel.accept(newModelToShow)
    }
    
    private func generateFilterModel(model: [TransactionItemViewModel]) {
        let mapedModel = Array(Set(model.map({$0.transaction.category}))).sorted(by: <)
        filterModel = FilterListModel(title: "Category", items: mapedModel.map({(String(describing: $0),true)}))
    }
    
    private func calculateTotalValue(items: [TransactionItemViewModel]) -> Int {
        return items.reduce(0) { partialResult, transactionListItemModel in
            return partialResult + transactionListItemModel.transaction.valueAmount
        }
    }
}

struct TransactionItemViewModel {
    let transaction: TransactionListItemModel
}

extension TransactionItemViewModel {
    init(transaction: Transaction) {
        self.transaction = TransactionListItemModel(
            bookingDate: transaction.transactionDetail.bookingDate.localizedDateFromISO,
            partnerDisplayName: transaction.partnerDisplayName,
            transactionDetailDescription: transaction.transactionDetail.transactionDetailDescription?.rawValue,
            valueAmount: transaction.transactionDetail.value.amount,
            valueCurrency: transaction.transactionDetail.value.currency.rawValue,
            category: transaction.category
        )
    }
}

extension TransactionItemViewModel {
    var bookingDate: Observable<String> {
        Observable.just(transaction.bookingDate)
    }
    
    var partnerDisplayName: Observable<String> {
        Observable.just(transaction.partnerDisplayName)
    }
    
    var description: Observable<String?> {
        Observable.just(transaction.transactionDetailDescription)
    }
    
    var valueAndCurrency: Observable<String> {
        Observable.just(String(describing: transaction.valueAmount) + " " + (transaction.valueCurrency ?? ""))
    }
}

extension TransactionItemViewModel {
    static func >(lhs:TransactionItemViewModel, rhs: TransactionItemViewModel) -> Bool {
        return lhs.transaction.bookingDate.date > rhs.transaction.bookingDate.date
    }
}
