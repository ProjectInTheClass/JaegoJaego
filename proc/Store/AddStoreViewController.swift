import Foundation
import UIKit

class AddStoreViewController:UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var AddlblName :UITextField!
    @IBOutlet weak var AddlblMany :UITextField!
    @IBOutlet weak var AddlblDate: UITextField!
    @IBOutlet weak var AddbtnSave: UIButton! //저장방법
    @IBOutlet weak var AddlblCall: UITextField!
    @IBOutlet weak var AddbtnFinish: UIButton! //완료
    @IBOutlet weak var AddlblManyType: UITextField!
    @IBOutlet weak var AddlblUsAmount: UITextField!
    
    
    @IBOutlet weak var AddlblWriteday : UITextField! // 들여온 날짜
    
    
    // 피커뷰 사용
    @IBOutlet weak var AddldlDatePiker2: UITextField! // 유통기한 피커
    @IBOutlet weak var AddlblSavePiker: UITextField! // 저장방법
    @IBOutlet weak var AddlblUpDatePiker: UITextField! // 등록일
    
    // 날짜 데이터 저장 배열
    let myPickerDate = [["18","19","20","21","22","23","24","25","26","27","28","29","30"],["01","02","03","04","05","06","07","08","09","10","11","12"],["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]]
    
    
    
    // 저장 방법 저장 배열
    let myPickerSave = ["실온", "냉동", "냉장"]
    
    var addTemp = StoreDatabase
    var pickerrealdate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 툴바
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        
        
        // 날짜 피커뷰
        let AddPikDate = UIPickerView()
        AddPikDate.delegate = self
        AddPikDate.tag = 1
        AddldlDatePiker2.inputView = AddPikDate
        AddPikDate.backgroundColor = UIColor.white
        AddPikDate.selectRow( 1 , inComponent: 1, animated: true)
        AddPikDate.showsSelectionIndicator = true
        
        AddldlDatePiker2.inputAccessoryView = toolBar
        
       

        // 저장 피커뷰
        let SavePikView = UIPickerView()
        SavePikView.delegate = self
        SavePikView.tag = 2
        AddlblSavePiker.inputView = SavePikView
        SavePikView.backgroundColor = UIColor.white
        
        AddlblSavePiker.inputAccessoryView = toolBar

        //등록날
        let AddPikUpDate = UIPickerView()
        AddPikUpDate.delegate = self
        AddPikUpDate.tag = 3
        AddlblUpDatePiker.inputView = AddPikUpDate
        AddPikUpDate.backgroundColor = UIColor.white
        
        AddlblUpDatePiker.inputAccessoryView = toolBar

    }
    
    
// 피커뷰 함수 시작

    @objc func doneClick() {
        
        AddldlDatePiker2.resignFirstResponder()
        AddlblSavePiker.resignFirstResponder()
        AddlblUpDatePiker.resignFirstResponder()
    }
    @objc func cancelClick() {
        AddldlDatePiker2.resignFirstResponder()
        AddlblSavePiker.resignFirstResponder()
        AddlblUpDatePiker.resignFirstResponder()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 1 {
            return myPickerDate.count
        }
        
        if pickerView.tag == 2 {
            return 1
        }
        
        if pickerView.tag == 3 {
            return myPickerDate.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
           return myPickerDate[component].count
        }
        
        if pickerView.tag == 2 {
            return myPickerSave.count
        }
        
        if pickerView.tag == 3 {
            return myPickerDate[component].count
        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return myPickerDate[component][row]
        }
        
        if pickerView.tag == 2 {
            return myPickerSave[row]
        }
        
        if pickerView.tag == 3 {
            return myPickerDate[component][row]
        }
        
        return nil
        
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       
        
        if pickerView.tag == 1 {
            let year = myPickerDate[0][pickerView.selectedRow(inComponent: 0)]
            let month = myPickerDate[1][pickerView.selectedRow(inComponent: 1)]
            let day = myPickerDate[2][pickerView.selectedRow(inComponent: 2)]
            AddldlDatePiker2.text = year + "." + month + "." + day
            pickerrealdate = year + month + day
            
            if AddldlDatePiker2.text != nil {
                pickerrealdate = year + month + day
            }
        }
        
        if pickerView.tag == 2 {
           AddlblSavePiker.text = myPickerSave[row]
        }
        
        if pickerView.tag == 3 {
            let year = myPickerDate[0][pickerView.selectedRow(inComponent: 0)]
            let month = myPickerDate[1][pickerView.selectedRow(inComponent: 1)]
            let day = myPickerDate[2][pickerView.selectedRow(inComponent: 2)]
            AddlblUpDatePiker.text = year + "." + month + "." + day
        }
     
    }
    
// 피커뷰 함수 끝
    
    
   // @IBOutlet weak var womanRadioButton: RadioButton!
   // @IBOutlet weak var manRadioButton: RadioButton!
    
    /*
    //라디오 버튼
    override func awakeFromNib() {
        self.view.layoutIfNeeded()
        
        womanRadioButton.isSelected = true
        manRadioButton.isSelected = false
    }
    */
    
  
    // 화면 아무곳 누르면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    


    @IBAction func closeBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    
//버튼 클릭했을 때 함수
    @IBAction func saveAddInfoBtn(_ sender: AnyObject) {
        
        // 오류 처리문 추가해야함
        let infoDateAdd:String = AddlblUpDatePiker.text!
        
        
        let NameAdd:String = AddlblName.text!
        let ManyAdd:Int = Int(AddlblMany.text!)!
        let DateAdd:String = AddldlDatePiker2.text!
        let CallAdd:String = AddlblCall.text!
        let ManyTypeAdd:String = AddlblManyType.text!
        let SaveAdd:saveStyle = .Cold
            //AddlblSavePiker.text!

        let TtManyAdd:Int = (30 + ManyAdd)
        
        //시험용 배열 데이터 선언
        var _:Array<Store>

    

        _ = Store(name: NameAdd, UpDate: infoDateAdd , DownDate: DateAdd, many: ManyAdd,manytype: ManyTypeAdd,  saveStyle:SaveAdd,  TotalMany: TtManyAdd, Call: CallAdd)

        let addStock = Store(name: NameAdd, UpDate: infoDateAdd, DownDate: DateAdd, many: ManyAdd,manytype: ManyTypeAdd,  saveStyle:SaveAdd,  TotalMany: TtManyAdd, Call: CallAdd)
    

            //        addArrayList.append(addStock)
            //        for i in addArrayList{
            //            if addArrayList[i] == " "{
            //
            //            }
            //        }
            
            // 데이터 받기, 출력 확인
            addTemp.arrayList.append(addStock)
            
            print("AddViewController - addStock -> addTemp.arrayList = \(addStock)")
            print("AddViewController - addtemp : StoreDataBase = \(addTemp.arrayList)")
            print("AddViewController - stockdatabase : \(StoreDatabase.arrayList)")
            self.dismiss(animated: true, completion: nil)
      
    }
}
