//
//  HomeViewController.swift
//  proc
//
//  Created by swuad_22 on 2018. 7. 19..
//  Copyright © 2018년 swuad-19. All rights reserved.
//


import UIKit
import Foundation

class HomeViewCtroller: UIViewController {
    
    @IBOutlet weak var labelDate :UILabel?
    
    
    
    //오늘 날짜 구하는 함수
    func dateInfo()-> String {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
        
    }
    
    override func viewDidLoad() {
        let infoDate:String = dateInfo()
        
        if let date:String = infoDate {
            labelDate?.text = infoDate
            
        }
        
    }
    
}

