//
//  Item.swift
//  Todoey
//
//  Created by imedev4 on 05/11/1439 AH.
//  Copyright © 1439 5W2H. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var  title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated:Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
