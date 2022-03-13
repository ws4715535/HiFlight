//
//  InvoiceDBTests.swift
//  HiFlightTests
//
//  Created by shuai.wang on 2022/3/13.
//

import Quick
import Nimble
import RealmSwift
import OHHTTPStubs

@testable import HiFlight

class InvoiceDBTests: QuickSpec {
    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    func mockSerserFucntion(block: () -> Void) {
        block()
    }

    override func spec() {
        describe("InvoiceDBTests Tests") {
            context("Fake DB") {
                afterEach {
                    HTTPStubs.removeAllStubs()
                }
                it("should insert invoice info into db when bff internal server error ") {
                    
                    let orderId = 800001
                    let email = "shuai.wang@thoughtworks.com"
                    let invoiceInfo = "tax:123123"
                    
                    let expectEntity = InvoiceApplyDBEntity(id: orderId, email: email, invoiceInfo: invoiceInfo, status: -1)
                    let fakeRealm = try! Realm(configuration: .defaultConfiguration)

                    self.mockSerserFucntion {
                        do {
                            try fakeRealm.write({
                                fakeRealm.add(expectEntity)
                            })
                        } catch {
                            
                        }
                    }
                    if let acturlEntity = fakeRealm.objects(InvoiceApplyDBEntity.self).first {
                        expect(acturlEntity.email).to(equal(email))
                        expect(acturlEntity.id).to(equal(orderId))
                        expect(acturlEntity.invoiceInfo).to(equal(invoiceInfo))
                        expect(acturlEntity.status).to(equal(-1))
                    }
                    
                }
            }
        }
    }
}
