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
    func updateFitness(_ fitness: Int) {
        outputFitness.text = String(fitness)
    }
    
    func updatePolygons(_ polygons: Int) {
        outputPolygons.text = String(polygons)
    }
    
    func updateIterations(_ iterations: Int) {
        outputIteration.text = String(iterations)
    }
    
    func updateImage(_ image: UIImage) {
        outputImage.image = image
    }
    
    
    
    // Output
    @IBOutlet weak var outputImage: UIImageView!
    @IBOutlet weak var outputPolygons: UILabel!
    @IBOutlet weak var outputIteration: UILabel!
    @IBOutlet weak var outputFitness: UILabel!


    let image = UIImage(named: "mona")!
    var generator: Evolve?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let settings = Settings()
        generator = Evolve(settings: settings, image: image)
        generator!.delegate = self
        DispatchQueue.global().async {
            self.generator?.start()
        }
    }

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
