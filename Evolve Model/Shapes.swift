//
//  Shapes.swift
//  Evolve
//
//  Created by Liam Vinson on 03/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import Foundation
import UIKit

protocol Shape {
    mutating func mutate()
}

enum ShapeType: String, CaseIterable {
    case polygon = "Polygons"
    case rectangle = "Rectangles"
    case circle = "Circles"
}

struct Polygon: Shape {
    var points: [CGPoint]
    var color: UIColor
    let settings: Settings
    
    init(settings: Settings) {
        self.settings = settings
        points = Tools.randomPolygon(pointLimit: settings.pointLimit, imageSize: settings.imageSize)
        color = Tools.randomColor()
    }
    
    mutating func mutate() {
        if Tools.probability(chance: settings.pointChangeProbability) {
            let rand = Int.random(in: 0..<points.count)
            points[rand] = Tools.mutatePoint(point: points[rand], imageSize: settings.imageSize, pointDeviation: settings.pointDeviation)
        }

        //Remove a point
        if points.count > 3 && Tools.probability(chance: settings.removePointProbability) {
            let rand = Int.random(in: 0..<points.count)
            points.remove(at: rand)
        }

        //Add a point
        if points.count < settings.pointLimit && Tools.probability(chance: settings.addPointProbability) {
            points.append(Tools.randomPoint(limit: settings.imageSize))
        }

        // Change color
        if Tools.probability(chance: settings.colorChangeProbability) {
            color = Tools.mutateColor(original: color, colorDeviation: settings.colorDeviation)
        }
    }
}

struct Rectangle: Shape {
    let rect: CGRect
    let color: UIColor
    
    init(settings: Settings) {
        rect = Tools.randomRectangle(imageSize: settings.imageSize)
        color = Tools.randomColor()
    }
    
    mutating func mutate() {
        
    }
}
