//
//  EvolveViewController.swift
//  Evolve
//
//  Created by Liam Vinson on 29/03/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import UIKit


class EvolveViewController: UIViewController, ModelDelegate {
    
    
    // Output
    @IBOutlet weak var outputImage: UIImageView!
    @IBOutlet weak var outputPolygons: UILabel!
    @IBOutlet weak var outputIteration: UILabel!
    @IBOutlet weak var outputFitness: UILabel!

    @IBOutlet weak var toggleButton: UIButton!
    
    let image = UIImage(named: "mona")!
    var generator: Evolve?
    var running = true
    let settings = Settings()
    var allowImageUpdate = true
    var backupImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initiateGenerator()
    }
    
    func initiateGenerator() {
        generator = Evolve(settings: settings, image: image)
        generator!.delegate = self
        generator?.toggle()
    }
    
    func toggle() {
        // Pause Evolve class
        generator?.toggle()
        
        // Change button
        if running == true {
            toggleButton.setImage(UIImage(named: "Play Button"), for: .normal)
            running = false
        } else {
            toggleButton.setImage(UIImage(named: "Pause Button"), for: .normal)
            running = true
        }
    }
    
    func reset() {
        generator?.stop()
        initiateGenerator()
    }

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
        if allowImageUpdate {
            outputImage.image = image
        } else {
            backupImage = image
        }
    }
    
    @IBAction func holdImage(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            outputImage.image = image
            allowImageUpdate = false
        } else if sender.state == .ended {
            outputImage.image = backupImage
            allowImageUpdate = true
        }
    }
    @IBAction func backPressed(_ sender: Any) {
        generator?.stop()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pausePressed(_ sender: Any) {
        toggle()
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        reset()
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        let activityItem: [AnyObject] = [self.outputImage.image as AnyObject]
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        present(avc, animated: true, completion: nil)
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
