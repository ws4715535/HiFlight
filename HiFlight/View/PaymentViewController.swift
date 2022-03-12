//
//  PaymentViewController.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import UIKit

class PaymentViewController: UIViewController {
    var order: OrderBusinessModel?
    var viewModel: PaymentViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        order = OrderBusinessModel(orderId: 888888)
        viewModel = PaymentViewModel()
    }
    @IBAction func pay(_ sender: UIButton) {
        guard let order = order else {
            return
        }
        viewModel?.payWithOrderId(orderId: order.orderId, payType: .balance, success: { [weak self] in
            let alert = UIAlertController(title: "支付结果", message: "支付成功！", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "确认", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(confirm)
            self?.present(alert, animated: true)
        }, failure: { [weak self] message in
            let alert = UIAlertController(title: "支付结果", message: message, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "确认", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(confirm)
            self?.present(alert, animated: true)
        })
    }
    
}
