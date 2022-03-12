//
//  MockServer.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/13.
//

import Foundation

class MockServer: NSObject {
    var response: String?
    var path: String?
    var statusCode: Int?
    
    func mock(_ path: String, _ statusCode: Int, _ response: String?) {
        self.path = path
        self.statusCode = statusCode
        self.response = response
    }
}
