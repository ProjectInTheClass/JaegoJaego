import UIKit
import Foundation

class ScheduleAddViewController : UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
    var eventArray : [Event] = []
    //@IBOutlet weak var btnComplete:UIButton!
    
    let scheduleModel = ScheduleDatabase
  
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var textV: UITextView!
    @IBOutlet weak var okbutton: UIButton!
    
    @IBOutlet weak var alarm1: UILabel!
    @IBOutlet weak var alarm2: UILabel!
    @IBOutlet weak var alarm3: UILabel!
    
    @IBOutlet weak var AddldlDatePiker: UITextField!
    
    // 날짜 데이터 저장 배열
    let myPickerDate = [["2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030"],["1","2","3","4","5","6","7","8","9","10","11","12"],["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]]
    // 저장 방법 저장 배열
    let myPickerSave = ["실온", "냉동", "냉장"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarm1.text = " "
        alarm2.text = " "
        alarm3.text = " "
        
        // 날짜 피커뷰
        let AddPikDate = UIPickerView()
        AddPikDate.delegate = self
        AddldlDatePiker.inputView = AddPikDate
    
    }
    
    // 피커뷰 함수 시작
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      
            return myPickerDate.count

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return myPickerDate[component].count
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return myPickerDate[component][row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let year = myPickerDate[0][pickerView.selectedRow(inComponent: 0)]
        let month = myPickerDate[1][pickerView.selectedRow(inComponent: 1)]
        let day = myPickerDate[2][pickerView.selectedRow(inComponent: 2)]
        AddldlDatePiker.text = year + "-" + month + "-" + day
        
    }
    
    // 피커뷰 함수 끝

    
    @IBAction func closeBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func complete(_ sender: AnyObject) {
        
        var DateAdd:String = AddldlDatePiker.text!
        
        var eventname = name.text!
        var text = textV.text!
        
        
        // 빈칸 처리문
        if( eventname == ""){
            alarm1.text = "값이 없습니다"
        }
        else{
            alarm1.text = " "
        }
        if( text == ""){
            alarm2.text = "값이 없습니다"
        }
        else{
            alarm2.text = "  "
        }
        if( DateAdd == ""){
            alarm3.text = "값이 없습니다"
        }
        else{
            alarm3.text = "  "
        }
        if( eventname != "" && text != "" && DateAdd != "" ){
            
            scheduleModel.ScheduleArray.append(Schedule(title: eventname, memo: text, dates: DateAdd))
            print(scheduleModel.ScheduleArray)
            self.dismiss(animated: true, completion: nil)
        }


        func complete (_ sender: AnyObject) {
        // 값 받는 코드

            self.dismiss(animated: true, completion: nil)

        }

    }

}
