import Foundation
import UIKit

class storeChartCell : UITableViewCell {
    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var labelSaveStyle:UIImageView!
    @IBOutlet weak var ChartImage:UIImageView!
    @IBOutlet weak var labelDownDate:UILabel!
    @IBOutlet weak var labelMany:UILabel!
    
    func bindViewModel(store: Store){
        labelName.text = store.name
        labelSaveStyle.image = UIImage(named: store.saveStyle.rawValue)
        labelDownDate.text = store.DownDate.returnString(format: "yyyy. MM. dd")
        labelMany.text = "\(store.many)\(store.manytype)"
        ChartImage.image = UIImage(named: store.Image)
    }
}
