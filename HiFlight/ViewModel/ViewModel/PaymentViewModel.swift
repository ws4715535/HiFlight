//
//  PaymentViewModel.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import UIKit
import RxSwift
import NSObject_Rx

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
    var subNetworking: MockServer?
    private var _subTestModel: Any?
    func payWithOrderId(orderId: Int, payType: PayType, success: @escaping (PaymentResultModel) -> Void, failure: @escaping (PaymentResultModel) -> Void) {
        var model: PaymentModel?
        var obModel: Observable<PaymentModel?> = ApiClient.shared.requestPayOrder(orderId: orderId, payType: payType.rawValue)
        if let _sub = _subTestModel as? PaymentModel {
            model = _sub
            obModel = Observable.just(model)
        }
        obModel.subscribe { model in
            guard let model = model else { return }
            success(PaymentResultModel(code: model.code.rawValue, message: model.message))
        } onError: { error in
            guard let customError = error as? CustomError else { return }
            switch customError.errorCode {
            case 401:
                failure(PaymentResultModel(code: PaymentResponseCode.notEnough.rawValue, message: "余额不足"))
            case 500:
                failure(PaymentResultModel(code: PaymentResponseCode.serverError.rawValue, message: "系统异常"))
            default:
                break
            }
        }.disposed(by: rx.disposeBag)
    }
    
    func _setSubTestModel<T>(model: T) {
        _subTestModel = model
    }
}
