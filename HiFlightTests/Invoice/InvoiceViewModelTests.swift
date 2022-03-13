//
//  PaymentTests.swift
//  HiFlightTests
//
//  Created by shuai.wang on 2022/3/12.
//

import Quick
import Nimble

@testable import HiFlight

class InvoiceModelTests: QuickSpec {
    override func spec() {
        describe("PaymentViewModelTests") {
            context("stub networking, test viewmodel logic") {
                it("shoudle callback success logic in viewmodel when payment is success") {
                    let orderId = 888888
                    let email = "shuai.wang@thoughtworks.com"
                    let invoiceInfo = "taxNumber:123123"
                    
                    let subModel = InvoiceModel(code: .success, message: "申请成功")
                    let expected = InvoiceBusinessModel(code: "success", message: "申请成功")
                    var actual: InvoiceBusinessModel?
                    
                    let viewmodel = InvoiceViewModel()
                    viewmodel._setSubTestModel(model: subModel)
                    viewmodel.applyInvoice(orderId: orderId, info: invoiceInfo, email: email) { model in
                        actual = model
                    } failure: { InvoiceBusinessModel in
                    }
                    expect(expected).to(equal(actual))
                }
            }
        }
    }
}
