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
    let imageData: [Int]
    
    init(settings: Settings, imageData: [Int]) {
        self.settings = settings
        self.imageData = imageData
        generateShapes()
    }
    
    mutating func generateShapes() {
        for _ in 0 ..< settings.shapeCount {
            switch settings.shapeType {
            case .polygon:
                shapes.append(Polygon(settings: settings, imageData: imageData))
            case .rectangle:
                shapes.append(Rectangle(settings: settings))
            case .circle:
                shapes.append(Circle(settings: settings))
            }
        }
    }
    
    mutating func mutate() {
        // Remove Polygon
        if shapes.count > 1 && Tools.probability(chance: settings.mutateDNA) {
            shapes.remove(at: Int.random(in: 0 ..< shapes.count)) // Removes random polygon
        }

        // Add polygon
        if Tools.probability(chance: settings.mutateDNA) && shapes.count > settings.shapeLimit {
            switch settings.shapeType {
            case .polygon:
                shapes.append(Polygon(settings: settings, imageData: imageData))
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
