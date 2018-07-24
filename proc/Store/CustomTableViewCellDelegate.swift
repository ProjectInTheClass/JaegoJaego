//import UIKit
//import Foundation
//
//protocol  CustomTableViewCellDelegate {
//    func buttonPressed()
//}
//
//class CustomTableViewCell : UITableViewCell {
//    var delegate : CustomTableViewCellDelegate?
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//    @IBAction func cellButtonPressed (sender: UIButton){
//        if (self.delegate != nil){
//            self.delegate?.buttonPressed()
//        }
//    }
//}
