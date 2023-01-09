//
//  JsonReader.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 1/9/23.
//

import Foundation
import RxSwift

protocol FileReader {
    func loadFile<T: Decodable>(fileName: String) -> Observable<T>
}

struct JsonReader: FileReader {
    func loadFile<T: Decodable>(fileName: String) -> Observable<T> {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let pathUrl = URL(fileURLWithPath: path)
        
        return Observable.just(pathUrl)
            .flatMap { url -> Observable<Data> in
                let data = try Data(contentsOf: url)
                return Observable.just(data)
            }.map { data in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}
