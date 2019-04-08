//
//  Tools.swift
//  Evolve
//
//  Created by Liam Vinson on 03/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import Foundation
import UIKit
import GameKit

class Tools {
    
    static func randomPolygon(pointLimit: Int, imageSize: Int) -> [CGPoint] {
        
        var points: [CGPoint] = []
        let number = Int.random(in: 3 ... pointLimit)
        for _ in 0 ..< number {
            points.append(randomPoint(limit: imageSize))
        }
        return points
    }
    
    static func randomPoint(limit: Int) -> CGPoint {
        let x = Int.random(in: 0...limit)
        let y = Int.random(in: 0...limit)
        return CGPoint(x: x, y: y)
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
    
    static func drawImage(shapes: [Shape], shapeType: ShapeType, imageSize: Int, scale: Int) -> UIImage {
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = CGFloat(scale) // Should be 1 for geting image data.
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
                    ctx.cgContext.addEllipse(in: (i as! Circle).circle)
                    ctx.cgContext.setFillColor((i as! Circle).color.cgColor)
                    ctx.cgContext.fillPath()
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
    
    static func probability(chance: Double) -> Bool {
        let x = Double.random(in: 0 ... 1)
        if x < chance {
            return true
        }
        return false
    }
    
    static func mutatePoint(point: CGPoint, imageSize: Int, pointDeviation: Int) -> CGPoint {
        let randomX = myRandom2(in: (0...imageSize), mean: Int(point.x), deviation: pointDeviation)
        let randomY = myRandom2(in: (0...imageSize), mean: Int(point.y), deviation: pointDeviation)
        
        return CGPoint(x: randomX, y: randomY)
    }
    
    static func mutateRectanglePosition(rect: CGRect, imageSize: Int, deviation: Int) -> CGRect {
        let x = myRandom2(in: 0...imageSize - Int(rect.width), mean: Int(rect.origin.x), deviation: deviation)
        let y = myRandom2(in: 0...imageSize - Int(rect.height), mean: Int(rect.origin.y), deviation: deviation)
        
        return CGRect(x: x, y: y, width: Int(rect.width), height: Int(rect.height))
    }
    
    static func mutateRectangleSize(rect: CGRect, imageSize: Int) -> CGRect {
        let width = myRandom2(in: 0...imageSize - Int(rect.origin.x), mean: Int(rect.width), deviation: 10)
        let height = myRandom2(in: 0...imageSize - Int(rect.origin.y), mean: Int(rect.height), deviation: 10)
        
        return CGRect(x: Int(rect.origin.x), y: Int(rect.origin.y), width: width, height: height)
    }
    
    static func myRandom2(in range: ClosedRange<Int>, mean: Int, deviation: Int) -> Int {
        
        let randomSource = GKARC4RandomSource()
        let randomDistribution = GKGaussianDistribution(randomSource: randomSource, mean: Float(mean), deviation: Float(deviation))
        
        // Clamp the result to within the specified range
        let rnd = randomDistribution.nextInt()
        
        if rnd < range.lowerBound {
            return range.lowerBound
        } else if rnd > range.upperBound {
            return range.upperBound
        } else {
            return rnd
        }
    }
    
    
    
    static func mutateColor(original: UIColor, colorDeviation: Double) -> UIColor {
        let x = original.cgColor.components!
        
        let r = myRandom(mean: Float(x[0]), deviation: Float(colorDeviation), in: (0...1))
        let g = myRandom(mean: Float(x[1]), deviation: Float(colorDeviation), in: (0...1))
        let b = myRandom(mean: Float(x[2]), deviation: Float(colorDeviation), in: (0...1))
        let a = myRandom(mean: Float(x[3]), deviation: Float(colorDeviation), in: (0...1))
        
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
    
    static func myRandom(mean: Float, deviation: Float, in range: ClosedRange<Float>) -> Float {
        let randomSource = GKRandomSource()
        
        // Checks deviation >= 0
        
        guard deviation > 0 else { return mean }
        
        let x1 = randomSource.nextUniform() // a random number between 0 and 1
        let x2 = randomSource.nextUniform() // a random number between 0 and 1
        let z1 = sqrt(-2 * log(x1)) * cos(2 * Float.pi * x2) // z1 is normally distributed
        let rnd = z1 * deviation + mean
        
        if rnd < range.lowerBound {
            return range.lowerBound
        } else if rnd > range.upperBound {
            return range.upperBound
        } else {
            return rnd
        }
    }
}
