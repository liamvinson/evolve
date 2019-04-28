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
    
    init(settings: Settings, imageData: [Int]) {
        self.settings = settings
        points = Tools.randomPolygon(pointLimit: settings.pointLimit, imageSize: settings.imageSize)
//        color = Tools.randomColor()
        color = Tools.guessColor(x: Int(points[0].x), y: Int(points[0].y), imageData: imageData)
    }
    
    mutating func mutate() {
        // Move point
        if Tools.probability(chance: settings.mutateShape) {
            let rand = Int.random(in: 0..<points.count)
            points[rand] = Tools.mutatePoint(point: points[rand], imageSize: settings.imageSize, pointDeviation: settings.pointDeviation)
        }

        //Remove a point
        if points.count > 3 && Tools.probability(chance: 0.0) {
            let rand = Int.random(in: 0..<points.count)
            points.remove(at: rand)
        }

        //Add a point
        if points.count < settings.pointLimit && Tools.probability(chance: 0.0) {
            points.append(Tools.mutatePoint(point: points[0], imageSize: settings.imageSize, pointDeviation: settings.pointDeviation))
        }

        // Change color
        if Tools.probability(chance: 0.01) {
            color = Tools.mutateColor(original: color, colorDeviation: settings.colorDeviation)
        }
    }
}

struct Rectangle: Shape {
    let settings: Settings
    var rect: CGRect
    var color: UIColor
    
    init(settings: Settings) {
        self.settings = settings
        rect = Tools.randomRectangle(imageSize: settings.imageSize)
        color = Tools.randomColor()
    }
    
    mutating func mutate() {
        // Move
        if Tools.probability(chance: settings.mutateShape) {
            rect = Tools.mutateRectanglePosition(rect: rect, imageSize: settings.imageSize, deviation: settings.pointDeviation)
        }
        
        //Change Size
        if Tools.probability(chance: settings.mutateShape) {
            rect = Tools.mutateRectangleSize(rect: rect, imageSize: settings.imageSize)
        }
        
        // Change color
        if Tools.probability(chance: settings.mutateShape) {
            color = Tools.mutateColor(original: color, colorDeviation: settings.colorDeviation)
        }
    }
}

struct Circle: Shape {
    let settings: Settings
    var circle: CGRect
    var color: UIColor
    
    init(settings: Settings) {
        self.settings = settings
        circle = Tools.randomRectangle(imageSize: settings.imageSize)
        color = Tools.randomColor()
    }
    
    mutating func mutate() {
        // Move
        if Tools.probability(chance: settings.mutateShape) {
            circle = Tools.mutateRectanglePosition(rect: circle, imageSize: settings.imageSize, deviation: settings.pointDeviation)
        }
        
        //Change Width
        if Tools.probability(chance: settings.mutateShape) {
            circle = Tools.mutateRectangleSize(rect: circle, imageSize: settings.imageSize)
        }

        if Tools.probability(chance: settings.mutateShape) {
            color = Tools.mutateColor(original: color, colorDeviation: settings.colorDeviation)
        }
    }
}
