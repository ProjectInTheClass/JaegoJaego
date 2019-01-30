//
//  AddStoreVC.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 29..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class AddStoreVC: UIViewController {
    // 오토레이아웃용
    @IBOutlet weak var stockPickerView: UIView!
    @IBOutlet weak var saveStyleView: UIView!
    
    @IBOutlet weak var stockDateLabel: UILabel!
    @IBOutlet weak var stockNameTF: UITextField!
    @IBOutlet weak var stockManyTF: UITextField!
    @IBOutlet weak var stockManyTypeTF: UITextField!
    @IBOutlet weak var stockDatePK: UIDatePicker!
    @IBOutlet weak var saveBtn: UIButton!
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    var stockDate = Date()
    var stockSaveType = saveStyle.Fresh
    var dataFilePath : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentSetting()
        hideKeyboardWhenTappedAround()
        stockDatePK.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)
        saveBtn.addTarget(self, action: #selector(addStock), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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

// 세그먼트
extension AddStoreVC {
    func segmentSetting(){
        let saveTypeSegmentControl = BetterSegmentedControl(frame: CGRect(x: (view.frame.width - 310) / 2 , y: 40, width: 317, height: 56), segments: LabelSegment.segments(withTitles: ["실온", "냉장", "냉동"], normalBackgroundColor: .white, normalTextColor: UIColor.init(hex: "#7396D0"), selectedBackgroundColor: UIColor.init(hex: "#7396D0"), selectedTextColor: .white), index: 0, options: [.backgroundColor(UIColor.init(hex: "#7396D0")), .indicatorViewBackgroundColor(.white) ])
        saveTypeSegmentControl.layer.borderWidth = 3
        saveTypeSegmentControl.layer.borderColor = UIColor.init(hex: "#7396D0").cgColor
        saveTypeSegmentControl.layer.cornerRadius = 7
        saveTypeSegmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        self.saveStyleView.addSubview(saveTypeSegmentControl)
    }
}

extension AddStoreVC {
    @objc func segmentValueChanged(sender: BetterSegmentedControl){
        switch sender.index {
        case 0:
            stockSaveType = saveStyle.Fresh
        case 1:
            stockSaveType = saveStyle.Cold
        default:
            stockSaveType = saveStyle.Ice
        }
    }
    
    @objc func getDateFromPicker() {
        let date = stockDatePK.date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy년 MM월 dd일"
        stockDate = date
        stockDateLabel.text = dateformatter.string(from: date)
    }
    
    @objc func addStock(sender: UIButton){
        guard let stockName = stockNameTF.text else {return}
        guard let stockMany = stockManyTF.text else {return}
        guard let stockManyType = stockManyTypeTF.text else {return}
        
        if !(stockName.isEmpty == true || stockMany.isEmpty == true || stockManyType.isEmpty == true){
            
            let stockManyToInt = Int(stockMany)!
            let stock = Store(name: stockName, UpDate: Date(), DownDate: stockDate, many: stockManyToInt, manytype: stockManyType, saveStyle: stockSaveType)
            
            StoreDatabase.arrayList.append(stock)
            StoreDatabase.saveData()
            presentingViewController?.viewWillAppear(true)
            dismiss(animated: true, completion: nil)
        }
        else {
            ToastView.shared.short(self.view, txt_msg: "입력되지 않은 정보가 있습니다.")
        }
    }
}
