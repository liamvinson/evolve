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
    func didRecieveData(_ image: UIImage)
}


class Evolve {
    
    weak var delegate: ModelDelegate?
    
    func outputImage(image: UIImage) {
        delegate?.didRecieveData(image)
    }
    
    var imageData: [Int]
    var settings: Settings
    var dna: DNA
    
    init(settings: Settings, image: UIImage) {
        self.settings = settings
        self.imageData = Tools.getPixelData(image: image, width: settings.imageSize, height: settings.imageSize)
        dna = DNA(settings: settings)
    }
    
    
    func start() {
        
        DispatchQueue.global().async {
            for _ in 0 ... 1 {
                var dnaCopy = self.dna
                
                // Mutate
                //                dnaCopy.mutate()
                
                // Draw
                let renderedImage = Tools.drawImage(shapes: self.dna.shapes, shapeType: self.settings.shapeType, imageSize: self.settings.imageSize)
                
                // Find fitness
                let fitness = Tools.fitness(renderedImage: renderedImage, imageData: self.imageData, imageSize: self.settings.imageSize)
                
                //Do more
                DispatchQueue.main.async {
                    self.outputImage(image: renderedImage)
                }
            }
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
