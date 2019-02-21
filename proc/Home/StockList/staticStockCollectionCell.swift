//
//  staticStockCollectionCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class staticStockCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    /** 효과 씌우기 */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
    }
    
    override func awakeFromNib() {
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
    }
}
