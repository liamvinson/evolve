//
//  Settings.swift
//  Evolve
//
//  Created by Liam Vinson on 05/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import Foundation

struct Settings { // Contains default values
    let shapeType: ShapeType = .rectangle
    let shapeCount: Int = 30
    let shapeLimit: Int = 100
    let pointLimit: Int = 5
    let imageSize: Int = 200
    
    let colorDeviation: Double = 0.1
    let pointDeviation: Int = 30
    
    let pointChangeProbability = 0.01
    let addPointProbability = 0.01
    let removePointProbability = 0.01
    let colorChangeProbability = 0.01
    let removePolygonProbability = 0.01
    let addPolygonProbability = 0.01
    
    let mutateShape = 0.01
}
