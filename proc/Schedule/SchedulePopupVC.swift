//
//  SchedulePopupVC.swift
//  proc
//
//  Created by 성다연 on 31/07/2019.
//  Copyright © 2019 swuad-19. All rights reserved.
//

import UIKit
import Foundation

class SchedulePopupVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var popupDate: UILabel!
    @IBOutlet weak var popupTF: UITextField!
    @IBOutlet weak var savebBtn :UIButton!
    
    var userStringDate = ""
    let scheduleModel = ScheduleDatabase
    
    @IBAction func cancleBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        popupDate.text = Date2String(date: Date(), format: "MM월 dd일")
        keyboardSetting()
        savebBtn.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
}

extension SchedulePopupVC {
    func keyboardSetting(){
        popupTF.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        popupTF.resignFirstResponder()
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -212
    }
    @objc func keyboardWillHide(_ sender: Notification){
        self.view.frame.origin.y = 0
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    @objc func saveButton(){
        popupTF.resignFirstResponder()
        
        guard let texts = popupTF.text else { return }
        
        if !texts.isEmpty {
            let newData = Schedule(memotitle: texts, memodates: Date2String(date: Date(), format: "yyyyMMdd"))
            scheduleModel.ScheduleArray.append(newData) // 날짜 임시 데이터
            scheduleModel.dateArray.append(Date2String(date: Date(), format: "yyyyMMdd"))
            
        }
        dismiss(animated: true)
    }
}
