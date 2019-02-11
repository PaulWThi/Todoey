//
//  Item.swift
//  Todoey
//
//  Created by paul thi on 2/10/19.
//  Copyright © 2019 Ambam. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated = Date()
    @objc dynamic var color: String = ""
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
