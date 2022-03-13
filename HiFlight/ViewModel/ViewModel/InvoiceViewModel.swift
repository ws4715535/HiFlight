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
            switch model?.code {
            case .success:
                obModel = Observable.just(model)
            case .notFound:
                obModel = Observable.error(CustomError(errorCode: 404, errorBody: nil))
            case .serverError:
                obModel = Observable.error(CustomError(errorCode: 500, errorBody: nil))
            case .none:
                break
            }
        }
        obModel.subscribe { model in
            guard let model = model else { return }
            success(InvoiceBusinessModel(code: model.code.rawValue, message: model.message))
        } onError: { error in
            guard let customError = error as? CustomError else { return }
            switch customError.errorCode {
            case 404:
                failure(InvoiceBusinessModel(code: InvoiceResponseCode.notFound.rawValue, message: "开票失败，订单不存在"))
            case 500:
                self.cacheInvoice(InvoiceApplyBusinessModel(orderId: orderId, email: email, invoiceInfo: info))
                failure(InvoiceBusinessModel(code: InvoiceResponseCode.serverError.rawValue, message: "系统异常"))
            default:
                break
            }
        }.disposed(by: rx.disposeBag)
    }

    func cacheInvoice(_ model: InvoiceApplyBusinessModel) {
        DataStoreManager.shared.add(element: InvoiceApplyDBEntity(id: model.orderId, email: model.email, invoiceInfo: model.invoiceInfo, status: 1))
    }

    // testOnly
    func _setSubTestModel<T>(model: T) {
        _subTestModel = model
    }
}
