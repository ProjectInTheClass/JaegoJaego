import UIKit
import Foundation

class ScheduleAddViewController : UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  

    //@IBOutlet weak var btnComplete:UIButton!
    
    let scheduleModel = ScheduleDatabase
    let AddPikDate = UIPickerView()
    var pickerrealdate = ""
    var pickerTimerealdate = ""
    @IBOutlet weak var name: UITextField!

    @IBOutlet weak var okbutton: UIButton!
    
    @IBOutlet weak var alarm1: UILabel!
    @IBOutlet weak var alarm2: UILabel!
    @IBOutlet weak var alarm3: UILabel!
    
    @IBOutlet weak var AddldlDatePiker: UITextField!
    @IBOutlet weak var AddlblTimePicker: UITextField! // 시간 입력 피커
    
    // 날짜 데이터 저장 배열
    let myPickerDate = [["2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030"],["01","02","03","04","05","06","07","08","09","10","11","12"],["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]]
    
    let myPickerTime = [["01","02","03","04","05","06","07","08","09","10","11","12"],["00","10","20","30","40","50"],["AM","PM"]]
    
    func dateformatting() -> String{
        let formatter = DateFormatter()
        let formatterdate = Date()
        formatter.dateFormat = "yy.MM.dd"
        
        let todayDate = formatter.string(from: formatterdate)
        return todayDate
    }
    
    override func viewDidLoad() {
        AddldlDatePiker.placeholder = "" + dateformatting()
        name.placeholder = "내용을 입력해주세요."
        super.viewDidLoad()
        alarm1.text = " "
        alarm2.text = " "
        alarm3.text = " "
        
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
        AddPikDate.delegate = self
        AddPikDate.tag = 1
        AddldlDatePiker.inputView = AddPikDate
        AddPikDate.backgroundColor = UIColor.white
        
        AddldlDatePiker.inputAccessoryView = toolBar
        
        // 시간 피커뷰
        let TimePikView = UIPickerView()
        TimePikView.delegate = self
        TimePikView.tag = 2
        AddlblTimePicker.inputView = TimePikView
        TimePikView.backgroundColor = UIColor.white
        
        AddlblTimePicker.inputAccessoryView = toolBar
        
        
    }
    
    // 피커뷰 함수 시작
    
    @objc func doneClick() {
        
        AddldlDatePiker.resignFirstResponder()
        AddlblTimePicker.resignFirstResponder()
        
    }
    @objc func cancelClick() {
        AddldlDatePiker.resignFirstResponder()
        AddlblTimePicker.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return myPickerDate.count
        }
        
        if pickerView.tag == 2 {
            return myPickerTime.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return myPickerDate[component].count
        }
        
        if pickerView.tag == 2 {
            return myPickerTime[component].count
        }
        
        return 0
        
    }
  
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return myPickerDate[component][row]
        }
        
        if pickerView.tag == 2 {
            return myPickerTime[component][row]
        }
        
        return nil
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            let year = myPickerDate[0][pickerView.selectedRow(inComponent: 0)]
            let month = myPickerDate[1][pickerView.selectedRow(inComponent: 1)]
            let day = myPickerDate[2][pickerView.selectedRow(inComponent: 2)]
            AddldlDatePiker.text = year + "." + month + "." + day
            pickerrealdate = year + month + day
            
            if AddldlDatePiker.text != nil {
                pickerrealdate = year + month + day
            }
        }
        
        if pickerView.tag == 2 {
            
            let hour = myPickerTime[0][pickerView.selectedRow(inComponent: 0)]
            let minute = myPickerTime[1][pickerView.selectedRow(inComponent: 1)]
            let selAMPM = myPickerTime[2][pickerView.selectedRow(inComponent: 2)]
            AddlblTimePicker.text = hour + ":" + minute + " " + selAMPM
            pickerTimerealdate = hour + ":" + minute + selAMPM
            
            if AddldlDatePiker.text != nil {
                pickerTimerealdate = hour + ":" + minute + " " + selAMPM
         }
        }
    }
    
// 피커뷰 함수 끝
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func complete(_ sender: AnyObject) {
        
        var DateAdd:String = pickerrealdate //AddldlDatePiker.text!
        let TimeAdd:String = pickerTimerealdate

        
        let eventname = name.text!
      
        // 빈칸 처리문
        if( eventname == ""){
            alarm1.text = "값이 없습니다"
        }
        else{
            alarm1.text = " "
        }
        if( TimeAdd == ""){
            alarm2.text = "값이 없습니다"
        }
        else{
            alarm2.text = "  "
        }
        if( DateAdd == ""){
            DateAdd = dateformatting()
        }
        else{
            alarm3.text = "  "
        }
        if( eventname != "" && TimeAdd != "" && DateAdd != "" ){
            scheduleModel.ScheduleArray.append(Schedule(memotitle: eventname, memotime: TimeAdd, memodates: DateAdd))
            print("scheduleDatabase \(ScheduleDatabase.ScheduleArray)")
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }

    }
    

}

