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
    
    init(settings: Settings) {
        generateShapes(settings: settings)
    }
    
    mutating func generateShapes(settings: Settings) {
        for _ in 0 ..< settings.shapeCount {
            switch settings.shapeType {
            case .polygon:
                shapes.append(Polygon(settings: settings))
            case .rectangle:
                shapes.append(Rectangle(settings: settings))
            case .circle:
                break
                //                shape.append(Rectangle())
            }
            
        }
    }
    
    mutating func mutate() {
        
    }
    
}
