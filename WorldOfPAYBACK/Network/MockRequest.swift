//
//  MockRequest.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/21/22.
//

import Foundation
import RxSwift

struct MockRequest<T: Decodable>: Requestable {
    var endPoint: EndPoint
    func perform() -> Observable<T> {
        return Observable.just(endPoint.mockUrl)
            .flatMap { url -> Observable<Data> in
                let data = try Data(contentsOf: url)
                return Observable.just(data)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}
