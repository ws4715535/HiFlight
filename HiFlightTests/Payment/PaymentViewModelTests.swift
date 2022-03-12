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
        describe("PaymentTests") {
            context("stub networking, test viewmodel logic") {
                it("stub networking, test viewmodel logic of successfully pay") {
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
            }
        }
    }
}
