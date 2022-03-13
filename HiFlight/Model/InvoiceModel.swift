//
//  InvoiceModel.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/13.
//

import Foundation

import Foundation

enum InvoiceResponseCode: String, Codable {
    case success = "success"
    case notFound = "order_not_found"
    case serverError = "internal_server_error"
}

struct InvoiceModel: Codable, Hashable, Equatable {
    let code: InvoiceResponseCode
    let message: String
    public static func == (lhs: InvoiceModel, rhs: InvoiceModel) -> Bool {
        return lhs.code.rawValue == rhs.code.rawValue
            && lhs.message == rhs.message
    }
}
