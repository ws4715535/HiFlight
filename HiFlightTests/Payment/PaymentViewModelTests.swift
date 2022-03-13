//
//  PaymentTests.swift
//  HiFlightTests
//
//  Created by shuai.wang on 2022/3/12.
//

import Quick
import Nimble

@testable import HiFlight

class PaymentViewModelTests: QuickSpec {
    override func spec() {
        describe("PaymentViewModelTests") {
            context("stub networking, test viewmodel logic") {
                it("shoudle callback success logic in viewmodel when payment is success") {
                    let orderId = 888888
                    let payType = PayType.balance
                    
                    let subModel = PaymentModel(code: .success, message: "支付成功")
                    let expected = PaymentResultModel(code: "success", message: "支付成功")
                    var actual: PaymentResultModel?
                    
                    let viewmodel = PaymentViewModel()
                    viewmodel._setSubTestModel(model: subModel)
                    viewmodel.payWithOrderId(orderId: orderId, payType: payType) { result in
                        actual = result
                    } failure: { error in
                    }
                    expect(expected).to(equal(actual))
                }
                
                it("shoudle callback failed logic in viewmodel when payment is failed because of balance isn't enough") {
                    let orderId = 888888
                    let payType = PayType.balance
                    
                    let subModel = PaymentModel(code: .notEnough, message: "余额不足")
                    let expected = PaymentResultModel(code: "balance_not_enough", message: "余额不足")
                    var actual: PaymentResultModel?
                    
                    let viewmodel = PaymentViewModel()
                    viewmodel._setSubTestModel(model: subModel)
                    viewmodel.payWithOrderId(orderId: orderId, payType: payType) { result in
                    } failure: { error in
                        actual = error
                    }
                    expect(expected).to(equal(actual))
                }
                
                it("shoudle callback failed logic in viewmodel when payment is failed because of internal server error") {
                    let orderId = 888888
                    let payType = PayType.balance
                    
                    let subModel = PaymentModel(code: .serverError, message: "系统异常")
                    let expected = PaymentResultModel(code: "internal_server_error", message: "系统异常")
                    var actual: PaymentResultModel?
                    
                    let viewmodel = PaymentViewModel()
                    viewmodel._setSubTestModel(model: subModel)
                    viewmodel.payWithOrderId(orderId: orderId, payType: payType) { result in
                    } failure: { error in
                        actual = error
                    }
                    expect(expected).to(equal(actual))
                }
            }
        }
    }
}
