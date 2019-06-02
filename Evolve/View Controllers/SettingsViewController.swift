//
//  SettingsViewController.swift
//  Evolve
//
//  Created by Liam Vinson on 02/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import UIKit



class SettingsViewController: UIViewController {
    
    var settings = Settings()
    
    @IBOutlet weak var pointLimit: UITextField!
    @IBOutlet weak var shapeCount: UITextField!
    @IBOutlet weak var shapeLimit: UITextField!
    @IBOutlet weak var imageSize: UITextField!
    
    @IBOutlet weak var colorDeviation: UITextField!
    @IBOutlet weak var pointDeviation: UITextField!
    
    @IBOutlet weak var mutateDNA: UITextField!
    @IBOutlet weak var mutateShape: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Unsaved changes", message: "Are you sure, your changes wont be saved", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
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
