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

class PaymentNetworkingTests: QuickSpec {
    override func spec() {
        describe("PaymentNetworkingTests") {
            context("Face BFF, test Networking function") {
                afterEach {
                    HTTPStubs.removeAllStubs()
                }
                it("shoudle get success response in happy path") {
                    let orderId = 800001
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
                
                it("shoudle get success response in happy path") {
                    let orderId = 800001
                    let stubData = "{\"code\": \"balance_not_enough\",\"message\": \"余额不足\"}"
                    
                    let expectPath = "/balance/payment/\(orderId)"
                    let expectedModel = PaymentModel(code: .notEnough, message: "余额不足")
                    
                    stub(condition: isMethodPOST()) { request in
                        expect(expectPath).to(equal(request.url?.path))
                        return HTTPStubsResponse(data: stubData.data(using: .utf8)!, statusCode: 200, headers: nil)
                     }
                    _ = ApiClient.shared.requestPayOrder(orderId: orderId, payType: PayType.balance.rawValue).subscribe { model in
                        expect(expectedModel).to(equal(model!))
                    } onError: { error in
                    }
                }
                
                it("shoudle get success response in happy path") {
                    let orderId = 800001
                    let stubData = "{\"code\": \"internal_server_error\",\"message\": \"系统异常\"}"
                    
                    let expectPath = "/balance/payment/\(orderId)"
                    let expectedModel = PaymentModel(code: .notEnough, message: "系统异常")
                    
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
