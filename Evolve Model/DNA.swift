//
//  DNA.swift
//  Evolve
//
//  Created by Liam Vinson on 03/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import Foundation

struct DNA {
    var shapes: [Shape] = []
    let settings: Settings
    
    init(settings: Settings) {
        self.settings = settings
        generateShapes()
    }
    
    mutating func generateShapes() {
        for _ in 0 ..< settings.shapeCount {
            switch settings.shapeType {
            case .polygon:
                shapes.append(Polygon(settings: settings))
            case .rectangle:
                shapes.append(Rectangle(settings: settings))
            case .circle:
                shapes.append(Circle(settings: settings))
            }
        }
    }
    
    mutating func mutate() {
        // Remove Polygon
        if shapes.count > 1 && Tools.probability(chance: settings.removePolygonProbability) {
            shapes.remove(at: Int.random(in: 0 ..< shapes.count)) // Removes random polygon
        }

        // Add polygon
        if Tools.probability(chance: settings.addPolygonProbability) {
            switch settings.shapeType {
            case .polygon:
                shapes.append(Polygon(settings: settings))
            case .rectangle:
                shapes.append(Rectangle(settings: settings))
            case .circle:
                shapes.append(Rectangle(settings: settings))
            }
        }
            
        for i in 0 ..< shapes.count {
            shapes[i].mutate()
        }

    }
}
