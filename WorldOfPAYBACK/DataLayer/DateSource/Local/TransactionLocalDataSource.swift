//
//  TransactionLocalDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 12/25/22.
//

import Foundation
import RxSwift

protocol TransactionLocalDataSource {
    func provideTransactionData() -> Observable<TransactionDecodableModel>
}

struct TransactionJsonReaderDataSource: TransactionLocalDataSource {
    
    let fileReader: FileReader
    
    init(fileReader: FileReader) {
        self.fileReader = fileReader
    }
    
    func provideTransactionData() -> Observable<TransactionDecodableModel> {
        
        let response: Observable<TransactionDecodableModel> = fileReader.loadFile(fileName: "PBTransactions")
        
        return response
    }
}
