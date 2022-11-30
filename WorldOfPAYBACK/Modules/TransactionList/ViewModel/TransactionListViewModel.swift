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
    var model: BehaviorRelay<[TransactionItemViewModel]> = BehaviorRelay(value: [])
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var totalText: PublishSubject<String> = PublishSubject()
//    var itemsToShow: [TransactionItemViewModel] = []
    private var disposeBag = DisposeBag()
    
    func fetchTransactions() {
        let request: MockRequest<TransactionDecodableModel> = MockRequest(endPoint: .transactionList)
        isLoading.onNext(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            request.perform()
                .subscribe(onNext: { transactions in
                    let model = transactions.items.map(TransactionItemViewModel.init)
                    self.model.accept(model)
                    self.generateTotalText(items: model)
                    self.isLoading.onNext(false)
                }).disposed(by: self.disposeBag)
        })
    }
    
    private func generateTotalText(items: [TransactionItemViewModel]) {
        self.totalText.onNext(String(describing: calculateTotal(items: items)) + " " + (items[0].transaction.valueCurrency ?? ""))
    }
    
    private func calculateTotal(items: [TransactionItemViewModel]) -> Int {
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
            bookingDate: DateConverter.dateConverter(str: transaction.transactionDetail.bookingDate),
            partnerDisplayName: transaction.partnerDisplayName,
            transactionDetailDescription: transaction.transactionDetail.transactionDetailDescription?.rawValue,
            valueAmount: transaction.transactionDetail.value.amount,
            valueCurrency: transaction.transactionDetail.value.currency.rawValue
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
