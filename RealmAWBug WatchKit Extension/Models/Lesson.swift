//
//  Lesson.swift
//  SitnuWatch Extension
//
//  Created by Nils Bergmann on 03.12.17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import RealmSwift

class Lesson: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var date: Date = Date()
  @objc dynamic var startTime: Date = Date()
  @objc dynamic var endTime: Date = Date()
  @objc dynamic var code: String = ""
  @objc dynamic var course: String?
  @objc dynamic var text: String?
  let classes = List<Class>()
  let teachers = List<Teacher>()
  let subjects = List<Subject>()
  let rooms = List<Room>()
  let instead = List<Teacher>()
  
  override static func primaryKey() -> String? {
    return "id";
  }
  
  override static func indexedProperties() -> [String] {
    return ["date", "startTime", "endTime"]
  }
}
