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
    func mutate()
}

enum ShapeType: String, CaseIterable {
    case polygon = "Polygons"
    case rectangle = "Rectangles"
    case circle = "Circles"
}

struct Polygon: Shape {
    let points: [CGPoint]
    let color: UIColor
    
    init(settings: Settings) {
        points = Tools.randomPolygon(pointLimit: settings.pointLimit, imageSize: settings.imageSize)
        color = Tools.randomColor()
    }
    
    func mutate() {
        
    }
}

struct Rectangle: Shape {
    let rect: CGRect
    let color: UIColor
    
    init(settings: Settings) {
        rect = Tools.randomRectangle(imageSize: settings.imageSize)
        color = Tools.randomColor()
    }
    
    func mutate() {
        
    }
}
