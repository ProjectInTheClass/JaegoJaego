//
//  Protocol.swift
//  proc
//
//  Created by 성다연 on 2019. 2. 15..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import Foundation

protocol UpdateDelegate {
    func didUpDate(sender: Bool)
}

protocol popupDelegate {
    func popupDateDelegate(data:Date)
}

func Date2String(date: Date, format : String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func String2Date(date: String) -> Date {
    let dateFormatter = DateFormatter()
    return dateFormatter.date(from: date)!
}
