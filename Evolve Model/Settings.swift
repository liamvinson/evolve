//
//  Settings.swift
//  Evolve
//
//  Created by Liam Vinson on 05/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import Foundation

struct Settings { // Contains default values
    var shapeType: ShapeType = .polygon
    var shapeCount: Int = 30
    var shapeLimit: Int = 100
    var pointLimit: Int = 5
    var imageSize: Int = 100
    
    var colorDeviation: Double = 0.1
    var pointDeviation: Int = 30
    
    var mutateDNA = 0.01
    var mutateShape = 0.01
}
