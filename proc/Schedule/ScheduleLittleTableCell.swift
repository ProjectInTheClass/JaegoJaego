import UIKit
import Foundation

class ScheduleLittleTableCell : UITableViewCell {
    @IBOutlet weak var littletime: UILabel! // 시간
    @IBOutlet weak var littlestack: UIImageView!
    @IBOutlet weak var littleJaegom: UIImageView!
    @IBOutlet weak var littlememo: UILabel! // 메모

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        littleView.layer.cornerRadius = 25
//        littleView.layer.shadowRadius = 1
//        littleView.layer.shadowOpacity = 0.12
//        littleView.layer.shadowOffset = CGSize(width: 3, height: 5)
//        littleView.clipsToBounds = false
//
////        littleView.layer.masksToBounds = true
////        littleView.layer.cornerRadius = 25
//
//        self.sizeThatFits(CGSize(width: self.frame.width, height: self.frame.height))
//    }

}
