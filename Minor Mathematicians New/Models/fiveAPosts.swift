//
//  fiveAPosts.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 26/01/20.
//  Copyright © 2020 Ricardo Aguiar Bomeny. All rights reserved.
//

import Foundation

class Post {
    
    var id: String
    var text: String
    var createdAt: Date
    var url: String
    
    init(id: String, timestamp: Double, text: String, url: String) {
        self.id = id
        self.createdAt = Date(timeIntervalSince1970: timestamp/1000)
        self.text = text
        self.url = url
    }
    
}
