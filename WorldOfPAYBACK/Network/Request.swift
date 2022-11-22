//
//  Request.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/21/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol Requestable {
    associatedtype T: Decodable
    func perform() -> Observable<T>
}

struct Request<T: Decodable>: Requestable {
    var endPoint: EndPoint
    func perform() -> Observable<T> {
        return NetworkService.request(endPoint: endPoint)
    }
}
