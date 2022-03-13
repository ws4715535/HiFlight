//
//  InvoiceController.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/13.
//

import UIKit

class InvoiceController: UIViewController {
    var viewModel: InvoiceViewModel?
    let orderId = 800001
    let info = "texInfo:123123"
    let email = "shuai.wang@thoughtworks.com"
    override func viewDidLoad() {
        viewModel = InvoiceViewModel()
    }

    @IBAction func apply(_ sender: Any) {
        viewModel?.applyInvoice(orderId: orderId, info: info, email: email, success: { model in
            self.handleSuccessfulApply()
        }, failure: { error in
            self.handleFailedApply(message: error.message)
        })
    }

    private func handleSuccessfulApply() {
        let alert = UIAlertController(title: "开票申请结果", message: "开票申请成功！", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "确认", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    private func handleFailedApply(message: String) {
        let alert = UIAlertController(title: "开票申请结果", message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "确认", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
}
