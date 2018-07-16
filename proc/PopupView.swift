//
//  PopupView.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 9..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import UIKit

class PopupView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var baseView: UIView!
    @IBAction func closeBtnTapped(_ sender: Any){
        self.removeFromSuperview()
    }

}
