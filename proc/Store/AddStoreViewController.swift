//
//  AddStoreViewController.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 24..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import Foundation
import UIKit

class AddStoreViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var AddlblName :UITextField!
    @IBOutlet weak var AddlblMany :UITextField!
    @IBOutlet weak var AddlblDate: UITextField!
    @IBOutlet weak var AddbtnSave: UIButton!
    @IBOutlet weak var AddlblCall: UITextField!
    
    @IBOutlet weak var AddbtnFinish: UIButton!

 
    
    // 화면 아무곳 누르면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func getValue () {
        var Nametext:String = AddlblName.text!
        var Manytext:String = AddlblMany.text!
    }
}
