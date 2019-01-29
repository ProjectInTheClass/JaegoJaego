//
//  AddStoreVC.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 29..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class AddStoreVC: UIViewController {
    @IBOutlet weak var stockDateLabel: UILabel!
    @IBOutlet weak var stockNameTF: UITextField!
    @IBOutlet weak var stockManyTF: UITextField!
    @IBOutlet weak var stockDatePK: UIDatePicker!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    var stockDate : Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender: )))
        view.addGestureRecognizer(tapGesture)
        
        stockDatePK.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
}

extension AddStoreVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -250, up: false)
    }
    
    func moveTextField(textfield: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

extension AddStoreVC {
    @objc func getDateFromPicker() {
        let date = stockDatePK.date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy년 MM월 dd일"
        stockDate = date
        stockDateLabel.text = dateformatter.string(from: date)
    }
}
