//
//  buttonNumber.swift
//  CountOnMe
//
//  Created by Luc Derosne on 26/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation
import UIKit

class NumberButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {

// round corners
        tintColor = UIColor.white
        
        backgroundColor = UIColor.lightGray
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
    }
    
}
