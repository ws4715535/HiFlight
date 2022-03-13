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
                    let orderId = 800001
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
                
                it("shoudle callback failed logic in viewmodel when invoice apply is failed because of order isn't found") {
                    let orderId = 800001
                    let email = "shuai.wang@thoughtworks.com"
                    let invoiceInfo = "taxNumber:123123"
                    
                    let subModel = InvoiceModel(code: .notFound, message: "订单不存在")
                    let expected = InvoiceBusinessModel(code: "order_not_found", message: "开票失败，订单不存在")
                    var actual: InvoiceBusinessModel?
                    
                    let viewmodel = InvoiceViewModel()
                    viewmodel._setSubTestModel(model: subModel)
                    viewmodel.applyInvoice(orderId: orderId, info: invoiceInfo, email: email) { model in
                    } failure: { error in
                        actual = error
                    }
                    expect(expected).to(equal(actual))
                }
                
                it("shoudle callback failed logic in viewmodel when invoice apply is failed because of internal server error") {
                    let orderId = 800001
                    let email = "shuai.wang@thoughtworks.com"
                    let invoiceInfo = "taxNumber:123123"
                    
                    let subModel = InvoiceModel(code: .serverError, message: "系统异常")
                    let expected = InvoiceBusinessModel(code: "internal_server_error", message: "系统异常")
                    var actual: InvoiceBusinessModel?
                    
                    let viewmodel = InvoiceViewModel()
                    viewmodel._setSubTestModel(model: subModel)
                    viewmodel.applyInvoice(orderId: orderId, info: invoiceInfo, email: email) { model in
                    } failure: { error in
                        actual = error
                    }
                    expect(expected).to(equal(actual))
                }
            }
        }
    }
}
