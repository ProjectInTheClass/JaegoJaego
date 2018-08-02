import UIKit


class StoreViewController : UIViewController {
    
    //네비게이션 바 숨기기
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar() //네비바 셋팅
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setNavigationBar(){
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
}

