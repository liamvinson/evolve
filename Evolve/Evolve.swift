//
//  Evolve.swift
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

struct DNA {
    var shapes: [Shape] = []
    
    init(shapeType: ShapeType, shapeCount: Int, imageSize: Int) {
        generateShapes(shapeType: shapeType, shapeCount: shapeCount, imageSize: imageSize)
    }
    
    mutating func generateShapes(shapeType: ShapeType, shapeCount: Int, imageSize: Int) {
        for _ in 0 ..< shapeCount {
            switch shapeType {
            case .polygon:
                shapes.append(Polygon(imageSize: imageSize))
            case .rectangle:
                shapes.append(Rectangle(imageSize: imageSize))
            case .circle:
                break
                //                shape.append(Rectangle())
            }
            
        }
    }
    
    mutating func mutate() {
        
    }
    
}

struct Polygon: Shape {
    let points: [CGPoint]
    let color: UIColor
    
    init(imageSize: Int) {
        points = Tools.randomPolygon()
        color = Tools.randomColor()
    }
    
    func mutate() {
        
    }
}

struct Rectangle: Shape {
    let rect: CGRect
    let color: UIColor
    
    init(imageSize: Int) {
        rect = Tools.randomRectangle(imageSize: imageSize)
        color = Tools.randomColor()
    }
    
    func mutate() {
        
    }
}


class Tools {
    
    static func randomPolygon() -> [CGPoint] {
        let x: [CGPoint] = []
        return x
    }
    
    static func randomRectangle(imageSize: Int) -> CGRect {
        
        let width = Int.random(in: 0 ... imageSize)
        let height = Int.random(in: 0 ... imageSize)
        let x = Int.random(in: 0 ... imageSize - width)
        let y = Int.random(in: 0...imageSize - height)
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    static func randomColor() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: .random(in: 0...1))
    }
    
    static func drawImage(shapes: [Shape], shapeType: ShapeType, imageSize: Int) -> UIImage {
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageSize, height: imageSize), format: format)
        let renderedImage = renderer.image { ctx in
            
            // Black background
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.addRect(CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
            ctx.cgContext.fillPath()
            
            // Draw shapes
            for i in shapes {
                
                switch shapeType {
                case .polygon:
                    ctx.cgContext.addLines(between: (i as! Polygon).points)
                    ctx.cgContext.setFillColor((i as! Polygon).color.cgColor)
                    ctx.cgContext.fillPath()
                case .rectangle:
                    ctx.cgContext.addRect((i as! Rectangle).rect)
                    ctx.cgContext.setFillColor((i as! Rectangle).color.cgColor)
                    ctx.cgContext.fillPath()
                case .circle:
                    break
                }
                
                
            }
        }
        return renderedImage
    }
    
    static func getPixelData(image:  UIImage, width: Int, height: Int) -> [Int] {
        
        var pixels: [Int] = []
        
        let providerData = image.cgImage!.dataProvider!.data
        let data = CFDataGetBytePtr(providerData)!
        
        let x = width * height * 4
        for i in stride(from: 0, to: x, by: 4) {
            
            let r = Int(data[i])
            let g = Int(data[i+1])
            let b = Int(data[i+2])
            let a = Int(data[i+3])
            
            pixels.append(r)
            pixels.append(g)
            pixels.append(b)
            pixels.append(a)
        }
        
        return pixels
    }
    
    static func fitness(renderedImage: UIImage, imageData: [Int], imageSize: Int) -> Int {
        
        var pixelFitness: Int = 0
        var red: Int
        var green: Int
        var blue: Int
        
        let providerData = renderedImage.cgImage!.dataProvider!.data
        let renderedImageData = CFDataGetBytePtr(providerData)!
        
        let x = imageSize * imageSize * 4
        for i in stride(from: 0, to: x, by: 4) {
            
            red = Int(renderedImageData[i]) - imageData[i]
            green = Int(renderedImageData[i + 1]) - imageData[i + 1]
            blue = Int(renderedImageData[i + 2]) - imageData[i + 2]
            
            pixelFitness += red*red + green*green + blue*blue
            
        }
        
        return pixelFitness
        
    }
}

enum ShapeType {
    case polygon, rectangle, circle
}





protocol ModelDelegate: class {
    func didRecieveData(_ image: UIImage)
}


class Evolve {
    
    weak var delegate: ModelDelegate?
    
    func outputImage(image: UIImage) {
        delegate?.didRecieveData(image)
    }
    
    let shapeType: ShapeType
    let imageSize: Int
    let imageData: [Int]
    
    var dna: DNA
    
    init(shapeType: ShapeType, shapeCount: Int, imageSize: Int, image: UIImage) {
        self.shapeType = shapeType
        self.imageSize = imageSize
        self.imageData = Tools.getPixelData(image: image, width: imageSize, height: imageSize)
        dna = DNA(shapeType: shapeType, shapeCount: shapeCount, imageSize: imageSize)
    }
    
    
    func start() {
        
        DispatchQueue.global().async {
            for _ in 0 ... 1 {
                var dnaCopy = self.dna
                
                // Mutate
                //                dnaCopy.mutate()
                
                // Draw
                let renderedImage = Tools.drawImage(shapes: self.dna.shapes, shapeType: self.shapeType, imageSize: self.imageSize)
                
                // Find fitness
                let fitness = Tools.fitness(renderedImage: renderedImage, imageData: self.imageData, imageSize: self.imageSize)
                
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
