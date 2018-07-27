//
//  HomeViewController.swift
//  proc
//
//  Created by swuad_22 on 2018. 7. 19..
//  Copyright © 2018년 swuad-19. All rights reserved.
//


import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    // 오늘의 날짜
    @IBOutlet weak var TodayDate :UILabel?

    
    
    override func viewDidLoad() {
    
        let Today = HomeDateModel.dateInfo()
        
        
        if let date:String = Today {
            TodayDate?.text = Today
        }
    }
    
}
