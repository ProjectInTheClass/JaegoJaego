import UIKit
import Foundation

class ScheduleLittleTableCell : UITableViewCell {
    @IBOutlet weak var littletime: UILabel! // 시간
    @IBOutlet weak var littlestack: UIImageView!
    @IBOutlet weak var littleJaegom: UIImageView! {
        didSet {
            littleJaegom.image = UIImage(named: "gaegom_skyblue")
        }
    }
    @IBOutlet weak var littlememo: UILabel! // 메모
    
    func bindViewModel(title: String) {
        littlememo.text = title
    }
}
