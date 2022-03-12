//
//  ApiClient.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import Foundation
import Alamofire
import RxSwift

struct CustomError: Error {
    let errorCode: Int
}

class ApiClient {
    static let shared = ApiClient()

    private func requestUrl<Element: Codable>(url: String, method: HTTPMethod, parameters: Dictionary<String, String>?) -> Observable<Element?> {
        let header: HTTPHeaders =  ["x-access-token": "XXXXX"]
        return Observable.create({observable -> Disposable in
            let request = AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: header).responseData { responseData in
                switch responseData.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let result = data.isEmpty ? nil : try decoder.decode(Element.self, from: data)
                        if responseData.response?.statusCode == 200 {
                            observable.onNext(result)
                            observable.onCompleted()
                        } else {
                            observable.onError(CustomError(errorCode: responseData.response?.statusCode ?? -1))
                        }
                    } catch let error {
                        observable.onError(error)
                    }
                case .failure(let error):
                    observable.onError(error)
                }
            }
            return Disposables.create { request.cancel() }
        })
    }

    func requestPayOrder(orderId: Int, payType: String) -> Observable<PaymentModel?> {
        let url = "http://balance/payment/\(orderId)"
        let parameters = ["payType": payType]
        return requestUrl(url: url, method: .post, parameters: parameters)
    }
}
