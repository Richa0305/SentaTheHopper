//
//  ViewController.swift
//  LittleHopper
//
//  Created by Richu on 03/12/18.
//  Copyright © 2018 Shivhari Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jack: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let jackIdleImages = ["Idle_1","Idle_2","Idle_3","Idle_4","Idle_5","Idle_6","Idle_7","Idle_8","Idle_9","Idle_10"]
        var images = [UIImage]()
        for image in jackIdleImages{
            images.append(UIImage(named: image)!)
        }
        jack.animationImages = images
        jack.animationDuration = 2.0
        jack.startAnimating()
    }


}

