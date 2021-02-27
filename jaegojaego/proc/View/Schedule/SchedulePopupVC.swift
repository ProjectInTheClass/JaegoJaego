//
//  SchedulePopupVC.swift
//  proc
//
//  Created by 성다연 on 31/07/2019.
//  Copyright © 2019 swuad-19. All rights reserved.
//

import UIKit
import Foundation

class SchedulePopupVC: UIViewController {
    @IBOutlet weak var popupDate: UILabel!
    @IBOutlet weak var popupTF: UITextField!
    @IBOutlet weak var savebBtn :UIButton!
    @IBAction func cancleBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private let viewModel = ScheduleViewModel()
    private var userStringDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpkeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SchedulePopupVC : UITextFieldDelegate {
    func setUpSubViews() {
        popupTF.delegate = self
        popupTF.becomeFirstResponder()
        popupDate.text = Date().returnString(format: "MM월 dd일")
        savebBtn.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setUpkeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        hideKeyboardWhenTappedAround()
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -212
    }
    @objc func keyboardWillHide(_ sender: Notification){
        self.view.frame.origin.y = 0
    }


    @objc func saveButton(){
        guard let texts = popupTF.text else { return }
        
        if !texts.isEmpty {
            let newData = Schedule(scheduleTitle: texts, scheduleTime: Date().returnString(format: "yyyyMMdd"))
            viewModel.addSchedule(data: newData)
        }
        dismiss(animated: true)
    }
}
