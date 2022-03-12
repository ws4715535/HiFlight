//
//  PaymentViewModel.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import UIKit

public struct PayType: RawRepresentable, Equatable, Hashable {
    public static let balance = PayType(rawValue: "balance")
    public static let wechat = PayType(rawValue: "wechat")
    public static let alipay = PayType(rawValue: "alipay")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

class PaymentViewModel: NSObject {
    func payWithOrderId(orderId: Int, payType: PayType, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        ApiClient.shared.requestPayOrder(PaymentModel.self, orderId: orderId, payType: payType.rawValue) { result in
            guard let result = result else {
                return
            }
            switch result.code {
            case .success:
                success()
            case .notEnough:
                failure("余额不足，请及时充值")
            case .serverError:
                failure("系统异常，请稍后再试")
            }
        }
    }
}
