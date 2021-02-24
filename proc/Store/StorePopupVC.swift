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
    
    private var viewModel = StoreViewModel()
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
        item = viewModel.findStock(data: position)
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
        let item = viewModel.findStock (data: position)
        
        if (usedItem.isNumber && item.many - Int(usedItem)! >= 0)  {
            item.many -= Int(usedItem)!
            var downDate = item.DownDate
            
            if item.many <= 0 {
                downDate = DateFormatter().date(from: Date2String(date: Date(), format: "yyyy.MM.dd"))!
            }
            
            let stock = Store(name: item.name, UpDate: item.UpDate, DownDate: downDate, many: Int(usedItem)!, manytype:  item.manytype, saveStyle: item.saveStyle)
                    
            viewModel.addStock(data: stock)
            viewModel.returnStockTotalCount()
            viewModel.saveData()

            presentingViewController?.viewWillAppear(true)
            delegate?.didUpDate()
            dismiss(animated: true)
        } else {
            ToastView.shared.short(self.view, txt_msg: "가지고 있는 수량보다 개수가 많거나 숫자가 아닙니다!")
        }
    }
}
