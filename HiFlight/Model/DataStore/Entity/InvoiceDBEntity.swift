//
//  InvoiceDBEntity.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/13.
//

import Foundation
import RealmSwift

class InvoiceApplyDBEntity: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var email: String = ""
    @Persisted var invoiceInfo: String = ""
    @Persisted var status = 0
    convenience init(id: Int, email: String, invoiceInfo: String, status: Int) {
        self.init()
        self.id = id
        self.invoiceInfo = invoiceInfo
        self.status = status
        self.email = email
    }
}
