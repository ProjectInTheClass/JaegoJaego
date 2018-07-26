import Foundation
import UIKit

class AddStoreViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var AddlblName :UITextField!
    @IBOutlet weak var AddlblMany :UITextField!
    @IBOutlet weak var AddlblDate: UITextField!
    @IBOutlet weak var AddbtnSave: UIButton! //저장방법
    @IBOutlet weak var AddlblCall: UITextField!
    @IBOutlet weak var AddbtnFinish: UIButton! //완료
    
    
    // 화면 아무곳 누르면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    
    //버튼 클릭했을 때 함수
    @IBAction func saveAddInfoBtn(_ sender: AnyObject) {
        var test = StoreModel.init()
        var infoDateAdd:String = HomeDateModel.dateInfo()
        
        var NameAdd:String = AddlblName.text!
        var ManyAdd:Int = Int(AddlblMany.text!)!
        var DateAdd:String = AddlblDate.text!
        var CallAdd:String = AddlblCall.text!
        var SaveAdd:saveStyle = .Cold
        var TtManyAdd:Int = (30 + ManyAdd)
        
        //시험용 배열 데이터 선언
        var addStock = Store(name: NameAdd, UpDate: infoDateAdd, DownDate: DateAdd, many: ManyAdd, saveStyle: SaveAdd, TotalMany: TtManyAdd, Call: CallAdd)
        
        // 데이터 받기, 출력 확인
        print(addStock)
        self.dismiss(animated: true, completion: nil)

    }
}
