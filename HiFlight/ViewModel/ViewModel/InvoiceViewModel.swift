//
//  InvoiceViewModel.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/13.
//

import UIKit
import RxSwift

class InvoiceViewModel: NSObject {
    private var _subTestModel: Any?
    func applyInvoice(orderId: Int, info: String, email: String, success: @escaping (InvoiceBusinessModel) -> Void, failure: @escaping (InvoiceBusinessModel) -> Void) {
        var model: InvoiceModel?
        var obModel: Observable<InvoiceModel?> = ApiClient.shared.requestApplyInvoice(orderId: orderId, invoiceInfo: info, email: email)
        if let _sub = _subTestModel as? InvoiceModel {
            model = _sub
            obModel = Observable.just(model)
        }
        obModel.subscribe { model in
            guard let model = model else { return }
            success(InvoiceBusinessModel(code: model.code.rawValue, message: model.message))
        } onError: { error in
            guard let customError = error as? CustomError else { return }
            switch customError.errorCode {
            case 404:
                failure(InvoiceBusinessModel(code: PaymentResponseCode.notEnough.rawValue, message: "余额不足"))
            case 500:
                failure(InvoiceBusinessModel(code: PaymentResponseCode.serverError.rawValue, message: "系统异常"))
            default:
                break
            }
        }.disposed(by: rx.disposeBag)
    }
    
    // testOnly
    func _setSubTestModel<T>(model: T) {
        _subTestModel = model
    }
}
