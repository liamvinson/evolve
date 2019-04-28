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
    var shapeCount: Int = 80
    var shapeLimit: Int = 100
    var pointLimit: Int = 9
    var imageSize: Int = 75
    
    var colorDeviation: Double = 0.01
    var pointDeviation: Int = 1
    
    var mutateDNA = 0.01
    var mutateShape = 0.03
}
