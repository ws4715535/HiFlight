//
//  PaymentResultModel.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import Foundation

struct PaymentResultModel: Hashable, Equatable {
    let code: String
    let message: String
    public static func == (lhs: PaymentResultModel, rhs: PaymentResultModel) -> Bool {
        return lhs.code == rhs.code
            && lhs.message == rhs.message
    }
}
