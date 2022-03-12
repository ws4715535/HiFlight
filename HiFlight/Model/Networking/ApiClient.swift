//
//  ApiClient.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import UIKit
import Alamofire

class ApiClient {
    static let shared = ApiClient()

    private func requestUrl<Element: Codable>(url: String, method: HTTPMethod, parameters: Dictionary<String, String>?, responseType: Element.Type, responseData: @escaping (Element?) -> Void) {
        let header: HTTPHeaders =  ["x-access-token": "XXXXX"]
        AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("123")
                    let decoder = JSONDecoder()
                    do {
                        let result = data.isEmpty ? nil : try decoder.decode(Element.self, from: data)
                        responseData(result)
                    } catch let error {
                        print(error)
                    }
                default: break
                }
            }
    }
    
    func requestPayOrder<T: Codable>(_ type: T.Type, orderId: Int, payType: String, response: @escaping (T?) -> Void) {
        requestUrl(url: "123", method: .post,
                   parameters:["payType": payType],
                   responseType: T.self) { result in
            response(result)
        }
    }
}
