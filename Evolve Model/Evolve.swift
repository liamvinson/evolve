//
//  Evolve.swift
//  Evolve
//
//  Created by Liam Vinson on 03/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import Foundation
import UIKit

protocol ModelDelegate: class {
    func updateIterations(_ iterations: Int)
    func updatePolygons(_ polygons: Int)
    func updateFitness(_ fitness: Int)
    func updateImage(_ image: UIImage)
}


class Evolve {
    
    weak var delegate: ModelDelegate?
    
    
    
    var iterations = 0
    var polygons = 0
    
    var imageData: [Int]
    var settings: Settings
    var dna: DNA
    var running = false
    
    init(settings: Settings, image: UIImage) {
        self.settings = settings
        self.imageData = Tools.getPixelData(image: image, width: settings.imageSize, height: settings.imageSize)
        dna = DNA(settings: settings)
    }
    
    
    func start() {
        
        var bestFitness = Int.max
        
        while running {
            var dnaCopy = self.dna
            
            // Mutate
            dnaCopy.mutate()
            
            // Draw
            let renderedImage = Tools.drawImage(shapes: dnaCopy.shapes, shapeType: self.settings.shapeType, imageSize: settings.imageSize, scale: 1)
            
            // Find fitness
            let fitness = Tools.fitness(renderedImage: renderedImage, imageData: imageData, imageSize: settings.imageSize)
            
            // Output polygons and iterations values
            self.iterations += 1
            self.outputIterations(iterations: iterations)
            
            
            if fitness < bestFitness {
                // Replace values with better solution
                bestFitness = fitness
                self.dna = dnaCopy
                
                // Update UI
                self.outputPolygons(polygons: dna.shapes.count)
                self.outputFitness(fitness: fitness)
                let image = Tools.drawImage(shapes: dnaCopy.shapes, shapeType: settings.shapeType, imageSize: settings.imageSize, scale: 5)
                outputImage(image: image)
            }
            
        }
    }
    
    func stop() {
        running = false
    }
    
    func toggle() {
        if running == false {
            running = true
            DispatchQueue.global().async {
                self.start()
            }
        } else {
            stop()
        }
    }
    
    func outputImage(image: UIImage) {
        DispatchQueue.main.async {
            self.delegate?.updateImage(image)
        }
    }
    
    func outputIterations(iterations: Int) {
        DispatchQueue.main.async {
            self.delegate?.updateIterations(iterations)
        }
    }
    
    func outputPolygons(polygons: Int) {
        DispatchQueue.main.async {
            self.delegate?.updatePolygons(polygons)
        }
    }
    
    func outputFitness(fitness: Int) {
        DispatchQueue.main.async {
            self.delegate?.updateFitness(fitness)
        }
    }
    
}













extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
