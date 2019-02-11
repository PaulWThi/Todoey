//
//  Category.swift
//  Todoey
//
//  Created by paul thi on 2/10/19.
//  Copyright © 2019 Ambam. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
