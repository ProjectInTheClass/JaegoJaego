//
//  StorePopupVC.swift
//  proc
//
//  Created by 성다연 on 2019. 2. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class StorePopupVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var pop_nameLabel: UILabel!
    @IBOutlet weak var pop_manyLabel: UILabel!
    @IBOutlet weak var pop_TF: UITextField!
    @IBAction func pop_cancleBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBOutlet weak var pop_completeBtn: UIButton!
    
    private var item : Store?
    var position : Int = 0
    private var delegate : UpdateDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
}


extension StorePopupVC {
    func setView(){
        item = StoreDatabase.arrayList[position]
        pop_nameLabel.text = "제품명 : \(item!.name)"
        pop_manyLabel.text = "현재 수량 : \(item!.many) \(item!.manytype)"
        
        pop_TF.becomeFirstResponder()
        
        pop_completeBtn.addTarget(self, action: #selector(isItemUsed), for: .touchUpInside)
    }
    
    @objc func isItemUsed(){
        guard let usedItem = pop_TF.text else {
            ToastView.shared.short(self.view, txt_msg: "사용한 개수를 입력해주세요.")
            return
        }
        
        if (usedItem.isNumber && StoreDatabase.arrayList[position].many - Int(usedItem)! >= 0)  {
            StoreDatabase.arrayList[position].many -= Int(usedItem)!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let temp = formatter.string(from: Date())
            formatter.date(from: temp)
            
            
            
            let name = StoreDatabase.arrayList[position].name
            let update = StoreDatabase.arrayList[position].UpDate
            let downdate = formatter.date(from: temp)!
            let many = Int(usedItem)!
            let manytype = StoreDatabase.arrayList[position].manytype
            let savetype = StoreDatabase.arrayList[position].saveStyle
            
            let Stock = Store(name: name, UpDate: update, DownDate: downdate, many: many, manytype: manytype, saveStyle: savetype)
            
            StoreDatabase.outList.append(Stock)
            StoreDatabase.sameStoreMany()
            StoreDatabase.saveData()
            presentingViewController?.viewWillAppear(true)
            self.delegate?.didUpDate(sender: true)
            // ++ Storevc 새로고침 해야함
            dismiss(animated: true)
        } else {
            ToastView.shared.short(self.view, txt_msg: "가지고 있는 수량보다 개수가 많거나 숫자가 아닙니다!")
        }
    }
}
