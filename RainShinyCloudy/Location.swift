//
//  Location.swift
//  RainShinyCloudy
//
//  Created by Habibur Rahman on 5/7/17.
//  Copyright © 2017 Habibur Rahman. All rights reserved.
//

import Foundation

class Location{
    static var shareInstance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
