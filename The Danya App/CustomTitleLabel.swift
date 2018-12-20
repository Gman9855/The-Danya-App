//
//  CustomTitleLabel.swift
//  The Danya App
//
//  Created by Gershy Lev on 9/14/17.
//  Copyright © 2017 Gershy Lev. All rights reserved.
//

import UIKit

class CustomTitleLabel: UILabel {
    init(text: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        self.font = UIFont(name: "Marker Felt", size: 25.0)
        self.textColor = UIColor(red: 128/355, green: 0/355, blue: 255/355, alpha: 1.0)
        self.textAlignment = .center
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
