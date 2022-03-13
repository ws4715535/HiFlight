//
//  PaymentNetworkingTests.swift
//  HiFlightTests
//
//  Created by shuai.wang on 2022/3/13.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import HiFlight

class InvoiceNetworkingTests: QuickSpec {
    override func spec() {
        describe("PaymentNetworkingTests") {
            context("Face BFF, test Networking function") {
                afterEach {
                    HTTPStubs.removeAllStubs()
                }
                it("shoudle get success response in happy path") {
                    let orderId = 888888
                    let stubData = "{\"code\": \"success\",\"message\": \"支付成功\"}"
                    
                    let expectPath = "/balance/payment/\(orderId)"
                    let expectedModel = PaymentModel(code: .success, message: "支付成功")
                    
                    stub(condition: isMethodPOST()) { request in
                        expect(expectPath).to(equal(request.url?.path))
                        return HTTPStubsResponse(data: stubData.data(using: .utf8)!, statusCode: 200, headers: nil)
                     }
                    _ = ApiClient.shared.requestPayOrder(orderId: orderId, payType: PayType.balance.rawValue).subscribe { model in
                        expect(expectedModel).to(equal(model!))
                    } onError: { error in
                }
              }
            }
        }
    }
}
