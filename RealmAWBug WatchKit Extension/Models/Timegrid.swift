//
//  Timegrid.swift
//  SitnuWatch Extension
//
//  Created by Nils Bergmann on 03.12.17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import RealmSwift

class Timegrid: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var day: Int = 0
  @objc dynamic var start: Int = 0
  @objc dynamic var end: Int = 0
  
  override static func primaryKey() -> String? {
    return "id";
  }
  
  override static func indexedProperties() -> [String] {
    return ["start", "end", "day"]
  }
}




