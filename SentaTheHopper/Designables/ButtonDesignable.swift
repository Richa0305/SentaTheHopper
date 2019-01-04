//
//  ButtonDesignable.swift
//  LittleHopper
//
//  Created by Richu on 03/12/18.
//  Copyright © 2018 Shivhari Inc. All rights reserved.
//

import UIKit
@IBDesignable
class ButtonDesignable: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

}
