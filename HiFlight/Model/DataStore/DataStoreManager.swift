//
//  DataStoreManager.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/13.
//

import Foundation
import RealmSwift

class DataStoreManager: NSObject {
    static let shared = DataStoreManager()
    let defaultRealm = try! Realm()
    
    func object<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element? {
        return defaultRealm.object(ofType: type, forPrimaryKey: key)
    }

    func objects<Element: RealmFetchable>(_ type: Element.Type) -> Results<Element> {
        return defaultRealm.objects(type)
    }
    
    public func write<Result>(withoutNotifying tokens: [NotificationToken] = [], _ block: (() throws -> Result)) throws -> Result {
        try! defaultRealm.write(block)
    }
    
    func add(element: Object) {
        defaultRealm.add(element)
    }
    
    func delete(element: Object) {
        defaultRealm.delete(element)
    }
}
