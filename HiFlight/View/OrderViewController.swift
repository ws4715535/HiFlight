//
//  OrderViewController.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let paddingInvoices = DataStoreManager.shared.objects(InvoiceApplyDBEntity.self)
        paddingInvoices.forEach { entity in
            ApiClient.shared.requestApplyInvoice(orderId: entity.id, invoiceInfo: entity.invoiceInfo, email: entity.email).subscribe { _ in
                DataStoreManager.shared.delete(element: entity)
            }
        }
    }
}
