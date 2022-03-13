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
                    let orderId = 800001
                    let email = "shuai.wang@thoughtworks.com"
                    let invoiceInfo = "tax:123123"
                    
                    let stubData = "{\"code\": \"success\",\"message\": \"开票申请成功\"}"

                    let expectPath = "/flights-ticket-orders/\(orderId)/invoice/apply"
                    let expectedModel = InvoiceModel(code: .success, message: "开票申请成功")

                    stub(condition: isMethodPOST()) { request in
                        expect(expectPath).to(equal(request.url?.path))
                        return HTTPStubsResponse(data: stubData.data(using: .utf8)!, statusCode: 200, headers: nil)
                     }
                    _ = ApiClient.shared.requestApplyInvoice(orderId: orderId, invoiceInfo: invoiceInfo, email: email).subscribe { model in
                        expect(expectedModel).to(equal(model!))
                    } onError: { error in
                }
              }
            }
        }
    }
}
