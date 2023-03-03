//
//  ChildModel.swift
//  Task
//
//  Created by Артур Кондратьев on 26.10.2022.
//

import Foundation

struct Parent {
    var parentName: String
    var parentAge: Int
    var childs: [ChildModel]
}

struct ChildModel {
    var name: String
    var age: Int
}
