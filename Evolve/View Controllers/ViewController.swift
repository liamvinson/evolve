//
//  ViewController.swift
//  Evolve
//
//  Created by Liam Vinson on 29/03/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var imageOutput: UIImageView!
    @IBOutlet weak var shapeTypeInput: UITextField!
    
    var settings = Settings()
    var changed = false
    var type = ShapeType.polygon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds shadow to imageOutput
        imageOutput.layer.masksToBounds = false;
        imageOutput.layer.shadowColor = UIColor.lightGray.cgColor
        imageOutput.layer.shadowRadius = 5
        imageOutput.layer.shadowOpacity = 0.2
        imageOutput.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        let thePicker = UIPickerView()
        shapeTypeInput.inputView = thePicker
        thePicker.delegate = self
    }
    
    
    
    // Shape Type Picker
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ShapeType.allCases.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ShapeType.allCases[row].rawValue
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        shapeTypeInput.text = ShapeType.allCases[row].rawValue
        type = ShapeType.allCases[row]
    }
    

    // Image Picker
    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        let actionSheet = UIAlertController(title: "Photo Source", message:"Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        imageOutput.image = image
        changed = true
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settings" {
            let controller = segue.destination as! SettingsViewController
            controller.settings = settings
        } else if segue.identifier == "help" {
            let _ = segue.destination as! HelpViewController
        } else if segue.identifier == "evolve" {
            let controller = segue.destination as! EvolveViewController
            switch type {
            case .polygon:
                settings.shapeType = .polygon
            case .rectangle:
                settings.shapeType = .rectangle
            case .circle:
                settings.shapeType = .circle
            }
            controller.settings = settings
            if changed == true {
                controller.image = imageOutput.image!
            }
            
        }
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let src = sender.source as? SettingsViewController {
            
            settings.pointLimit = Int(src.pointLimit.text!)!
            settings.shapeCount = Int(src.shapeCount.text!)!
            settings.shapeLimit = Int(src.shapeLimit.text!)!
            settings.imageSize = Int(src.imageSize.text!)!
            settings.colorDeviation = Double(src.colorDeviation.text!)!
            settings.pointDeviation = Int(src.pointDeviation.text!)!
            settings.mutateDNA = Double(src.mutateDNA.text!)!
            settings.mutateShape = Double(src.mutateShape.text!)!
            
        }
    }
    
}

