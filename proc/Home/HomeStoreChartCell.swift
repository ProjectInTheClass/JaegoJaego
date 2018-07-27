import UIKit
import Foundation

class HomeStoreChartCell:UITableViewCell {
    @IBOutlet weak var HomeStoreImage: UIImageView! // 통계 이미지
    @IBOutlet weak var HomeStoreName: UILabel! // 이름
    @IBOutlet weak var HomeStoreSaveStyle:UILabel! // 저장방법
    @IBOutlet weak var HomeStoreMany: UILabel! // 수량
    @IBOutlet weak var HomeStoreManytype: UILabel! // 단위
}
