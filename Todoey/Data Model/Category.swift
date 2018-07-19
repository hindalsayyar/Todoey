//
//  Category.swift
//  Todoey
//
//  Created by imedev4 on 05/11/1439 AH.
//  Copyright © 1439 5W2H. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var  name: String = ""
    let items = List<Item>()
}
