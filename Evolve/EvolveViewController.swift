//
//  EvolveViewController.swift
//  Evolve
//
//  Created by Liam Vinson on 29/03/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import UIKit
import GameKit

//struct Polygon {
//    var points: [CGPoint]
//    var color: UIColor
//}

class EvolveViewController: UIViewController, ModelDelegate {
    
    
    func didRecieveData(_ image: UIImage) {
        outputImage.image = image
    }
    
    
    
    
    // Output
    @IBOutlet weak var outputImage: UIImageView!
    @IBOutlet weak var outputPolygons: UILabel!
    @IBOutlet weak var outputIteration: UILabel!
    
    var polygons = 0
    var iteration = 0
    
    // Settings
    let startPolygon = 30
    let polygonLimit = 200
    let colorDeviation = 0.1
    let pointDeviation = 30
    
    let shapeType = ShapeType.rectangle
    let shapeCount = 30
    let image = UIImage(named: "mona")!
    let imageSize = 200
    let pointLimit = 4
    
    
    var generator: Evolve?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let settings = Settings()
        generator = Evolve(settings: settings, image: image)
        generator!.delegate = self
        generator?.start()
    }
    
    
    
    
//
//    func mutate(shapes: [Polygon], imageData: [Int]) {
//        DispatchQueue.global().async {
//
//            var bestShapes: [Polygon] = shapes
//            var bestFitness: Int = Int.max
//            var mutateShapes: [Polygon]
//            var bestImage: UIImage = UIImage()
//
//            let pointChangeProbability = 0.01
//            let addPointProbability = 0.01
//            let removePointProbability = 0.01
//            let colorChangeProbability = 0.01
//            let removePolygonProbability = 0.01
//            let addPolygonProbability = 0.01
//
//            for _ in 1...100000 { // Each iteration
//                mutateShapes = bestShapes // Provides array that can be mutated
//
//                for i in 0 ..< mutateShapes.count {
//                    // Move a point
//                    if self.probability(chance: pointChangeProbability) {
//                        let rand = Int.random(in: 0..<mutateShapes[i].points.count)
//                        mutateShapes[i].points[rand] = self.movePoint(point: mutateShapes[i].points[rand])
//                    }
//
//                    //Remove a point
//                    if mutateShapes[i].points.count > 3 && self.probability(chance: removePointProbability) {
//                        let rand = Int.random(in: 0..<mutateShapes[i].points.count)
//                        mutateShapes[i].points.remove(at: rand)
//                    }
//
//                    //Add a point
//                    if mutateShapes[i].points.count < self.pointLimit && self.probability(chance: addPointProbability) {
//                        mutateShapes[i].points.append(self.randomCGPoint(xLimit: self.imageSize, yLimit: self.imageSize))
//                    }
//
//                    // Change color
//                    if self.probability(chance: colorChangeProbability) {
//                        mutateShapes[i].color = self.similarColor(original: mutateShapes[i].color)
//                    }
//                }
//
//                // Remove polygon
//                if mutateShapes.count > 1 && self.probability(chance: removePolygonProbability) {
//                    mutateShapes.remove(at: Int.random(in: 0..<mutateShapes.count)) // Removes random polygon
//                }
//
//                // Add polygon
//                if self.probability(chance: addPolygonProbability) {
//                    mutateShapes.append(self.createPolygon(pointLimit: self.pointLimit, xLimit: self.imageSize, yLimit: self.imageSize)) // Removes random polygon
//                }
//
//                // Draw
//                let renderedImage = self.drawImage(shapes: mutateShapes, size: self.imageSize)
//
//                // Find Fitness
//                let fitness = self.fitness2(image: renderedImage, data: imageData, width: self.imageSize, height: self.imageSize)
//
//                if fitness < bestFitness {
//                    bestFitness = fitness
//                    bestShapes = mutateShapes
//                    bestImage = renderedImage
//                }
//
//                DispatchQueue.main.async {
//                    self.iteration += 1
//                    self.outputIteration.text = String(self.iteration)
//                    //                }
//                    self.outputImage.image = renderedImage
//                }
//            }
//        }
//    }


//
//    func movePoint(point: CGPoint) -> CGPoint {
//
//        let randomX = myRandom2(in: (0...imageSize), mean: Int(point.x), deviation: pointDeviation)
//        let randomY = myRandom2(in: (0...imageSize), mean: Int(point.y), deviation: pointDeviation)
//
//        return CGPoint(x: randomX, y: randomY)
//    }
//
//    func myRandom2(in range: ClosedRange<Int>, mean: Int, deviation: Int) -> Int {
//
//        let randomSource = GKARC4RandomSource()
//        let randomDistribution = GKGaussianDistribution(randomSource: randomSource, mean: Float(mean), deviation: Float(deviation))
//
//        // Clamp the result to within the specified range
//        let rnd = randomDistribution.nextInt()
//
//        if rnd < range.lowerBound {
//            return range.lowerBound
//        } else if rnd > range.upperBound {
//            return range.upperBound
//        } else {
//            return rnd
//        }
//    }
////
//    func probability(chance: Double) -> Bool {
//        let x = Double.random(in: 0...1)
//        if x < chance {
//            return true
//        }
//        return false
//    }
//

//
//    func similarColor(original: UIColor) -> UIColor {
//        let x = original.cgColor.components!
//
//        let r = myRandom(mean: Float(x[0]), deviation: Float(colorDeviation), in: (0...1))
//        let g = myRandom(mean: Float(x[1]), deviation: Float(colorDeviation), in: (0...1))
//        let b = myRandom(mean: Float(x[2]), deviation: Float(colorDeviation), in: (0...1))
//        let a = myRandom(mean: Float(x[3]), deviation: Float(colorDeviation), in: (0...1))
//
//        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
//    }
//
//    func myRandom(mean: Float, deviation: Float, in range: ClosedRange<Float>) -> Float {
//        let randomSource = GKRandomSource()
//
//        // Checks deviation >= 0
//
//        guard deviation > 0 else { return mean }
//
//        let x1 = randomSource.nextUniform() // a random number between 0 and 1
//        let x2 = randomSource.nextUniform() // a random number between 0 and 1
//        let z1 = sqrt(-2 * log(x1)) * cos(2 * Float.pi * x2) // z1 is normally distributed
//        let rnd = z1 * deviation + mean
//
//        if rnd < range.lowerBound {
//            return range.lowerBound
//        } else if rnd > range.upperBound {
//            return range.upperBound
//        } else {
//            return rnd
//        }
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
