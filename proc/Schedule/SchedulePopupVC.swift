//
//  SchedulePopupVC.swift
//  proc
//
//  Created by 성다연 on 31/07/2019.
//  Copyright © 2019 swuad-19. All rights reserved.
//

import UIKit
import Foundation

protocol popupDelegate {
    func popupDateDelegate(data:Date)
}

class SchedulePopupVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var popupDate: UILabel!
    @IBOutlet weak var popupTF: UITextField!
    @IBOutlet weak var savebBtn :UIButton!
    
    var userDate = Date()
    var userStringDate = ""
    var delegate : popupDelegate?
    let scheduleModel = ScheduleDatabase
    
    @IBAction func cancleBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("scheduleDatabase count : \(scheduleModel.ScheduleArray.count)")
        popupDate.text =  dateSetting(date: userDate)
        popupTF.resignFirstResponder()
        
        savebBtn.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
}

extension SchedulePopupVC {
    func dateSetting(date : Date) -> String{
        let popupDateFormat = DateFormatter()
        popupDateFormat.dateFormat = "MM월 dd일"
        return popupDateFormat.string(from: date)
    }
    
    func saveDateFormatter(date : Date)->String {
        let saveDateFormatter = DateFormatter()
        saveDateFormatter.dateFormat = "yyyyMMdd"
        return saveDateFormatter.string(from: date)
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
        if (popupTF.text != ""){
            let newData = Schedule(memotitle: popupTF.text!, memodates: saveDateFormatter(date: userDate))
            scheduleModel.ScheduleArray.append(newData) // 날짜 임시 데이터
            scheduleModel.dateArray.append(saveDateFormatter(date: userDate))
            //self.delegate?.popupDateDelegate(data: userDate)
            //self.performSegue(withIdentifier: "popupSegue", sender: self)
        }
        dismiss(animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let param = segue.destination as! ScheduleViewController
//        let value = saveDateFormatter(date:userDate)
//        param.value(forKey: value)
//    }
}
