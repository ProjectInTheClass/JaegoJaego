//
//  CompleteViewController.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 6..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import Foundation
import UIKit

class CompleteViewController : UIViewController{
    @IBAction func touchBack (_ sender: Any){
        //self.navigationController?.popViewController(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
        //self.navigationController?.popToViewController(viewController: UIViewController, animated: true)
    }
}
