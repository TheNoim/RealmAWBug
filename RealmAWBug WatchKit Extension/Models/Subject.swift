//
//  Subject.swift
//  SitnuWatch Extension
//
//  Created by Nils Bergmann on 03.12.17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import RealmSwift

class Subject: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String?
  @objc dynamic var longName: String?
  @objc dynamic var alternateName: String?
  
  override static func primaryKey() -> String? {
    return "id";
  }
}


