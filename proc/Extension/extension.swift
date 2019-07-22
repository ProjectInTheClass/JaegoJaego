//
//  extension.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    
    // rgb
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
    // hex
    convenience init(hex: String){
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 0
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        Scanner(string:cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

// optional control
extension UIViewController {
    func gsno(_ value: String?) -> String{
        guard let value_ = value else {//optional 을 해재해서 값을 받아옴
            return ""
        }
        return value_
    }
    
    func gino(_ value: Int?) -> Int{
        guard let value_ = value else {
            return 0
        }
        return value_
    }//func gino
    
    func gbno(_ value: Bool?) -> Bool{
        guard let value_ = value else {
            return false
        }
        return value_
    }//func gbno
    
    func gfno(_ value: Float?) -> Float{
        guard let value_ = value else{
            return 0
        }
        return value_
    }//func gfno
}

extension UIViewController {
    var previousViewController:UIViewController?{
        if let controllersOnNavStack = self.navigationController?.viewControllers{
            let n = controllersOnNavStack.count
            
            if controllersOnNavStack.last === self, n > 1{
                return controllersOnNavStack[n - 2]
            } else if n > 0{
                return controllersOnNavStack[n - 1]
            }
        }
        return nil
    }
    
    func stringToDate(_ value: String?) -> Date{
        guard let value_ = value else { return Date()}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.date(from: value_) ?? Date()
    }
    
    func dateToString(_ value: Date?) -> String {
        guard let value_ = value else {return ""}
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: value_)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension Dictionary where Value: Equatable {

    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
    //let dict: [Int: String] = [1: "one", 2: "two", 4: "four"]
    
//    if let key = dict.someKey(forValue: "two") {
//        print(key)
//    } // 2
    
    //let componentsArray = dict.allKeys()
}

extension UICollectionViewCell {
    func setSubLayer(){
        /** 효과 씌우기 */
        super.layoutSubviews()
        self.clipsToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
    }
    
    func stringToDate(_ value: String?) -> Date{
        guard let value_ = value else { return Date()}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.date(from: value_) ?? Date()
    }
    
    func dateToString(_ value: Date?) -> String {
        guard let value_ = value else {return ""}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: value_)
    }
}

extension UINavigationController {
    func getPreviousViewController() -> UIViewController? {
        let count = viewControllers.count
        guard count > 1 else { return nil }
        return viewControllers[count - 2]
    }
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
