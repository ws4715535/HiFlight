//
//  PaymentModel.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import Foundation

enum PaymentResponseCode: String, Codable {
    case success = "success"
    case notEnough = "balance_not_enough"
    case serverError = "internal_server_error"
}

struct PaymentModel: Codable, Hashable, Equatable {
    let code: PaymentResponseCode
    let message: String
    public static func == (lhs: PaymentModel, rhs: PaymentModel) -> Bool {
        return lhs.code.rawValue == rhs.code.rawValue
            && lhs.message == rhs.message
    }
}
