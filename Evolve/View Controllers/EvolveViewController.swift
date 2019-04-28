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

    @IBOutlet weak var outputTime: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    var image = UIImage(named: "mona")!
    var generator: Evolve?
    var running = true
    let settings = Settings()
    var allowImageUpdate = true
    var backupImage = UIImage()
    var timer = Timer()
    var myTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initiateGenerator()
    }
    
    func initiateGenerator() {
        generator = Evolve(settings: settings, image: image)
        generator!.delegate = self
        generator?.toggle()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.codeToBeRun() })
    }
    
    
    
    func codeToBeRun() {
        myTime += 1
        outputTime.text = String(myTime) + "s"
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
        if iterations == 50000 {
            print(outputFitness.text!)
        }
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
        timer.invalidate()
        toggle()
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        reset()
        myTime = 0
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
