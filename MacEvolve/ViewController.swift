//
//  ViewController.swift
//  MacEvolve
//
//  Created by Liam Vinson on 04/04/2019.
//  Copyright © 2019 Liam Vinson. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageOutlet: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageOutlet.image = UIImage(named: "mona")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

