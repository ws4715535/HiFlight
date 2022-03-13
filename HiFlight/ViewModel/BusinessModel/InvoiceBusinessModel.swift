//
//  InvoiceBusinessModel.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/13.
//

import Foundation

struct InvoiceBusinessModel: Hashable, Equatable {
    let code: String
    let message: String
    public static func == (lhs: InvoiceBusinessModel, rhs: InvoiceBusinessModel) -> Bool {
        return lhs.code == rhs.code
            && lhs.message == rhs.message
    }
}

struct InvoiceApplyBusinessModel {
    let orderId: Int
    let email: String
    let invoiceInfo: String
}

