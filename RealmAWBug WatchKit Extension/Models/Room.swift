//
//  Room.swift
//  SitnuWatch Extension
//
//  Created by Nils Bergmann on 03.12.17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import RealmSwift

class Room: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String?
  @objc dynamic var longName: String?
  @objc dynamic var building: String?
  
  override static func primaryKey() -> String? {
    return "id";
  }
}



