//
//  HomeChartCell.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 25..
//  Copyright © 2018년 swuad-19. All rights reserved.
//
import UIKit
import Foundation

class HomeChartCell:UITableViewCell {
    @IBOutlet weak var ThrowProcessImage: UIImageView! // 통계 이미지
    @IBOutlet weak var ThrowName: UILabel! // 이름
    @IBOutlet weak var ThrowSaveStyle:UILabel! // 저장방법
    @IBOutlet weak var ThrowMany: UILabel! // 수량
    @IBOutlet weak var ThrowManytype: UILabel! // 단위
}
