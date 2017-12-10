//
//  Share.swift
//  RealmAWBug
//
//  Created by Nils Bergmann on 09.12.17.
//  Copyright © 2017 Noim. All rights reserved.
//

import Foundation

class Share {
    
    var idToken: String?
    
    var callbacks: [([String : Any]) -> Void] = [];
    
    static let shared = Share();
    
    
    init() {}
    
}
