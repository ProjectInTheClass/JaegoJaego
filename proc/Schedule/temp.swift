//@IBOutlet weak var calendar: FSCalendar!
//
//@IBAction func addEventButton(_ sender: UIBarButtonItem) {
//    let date = Date()
//    let formatter = DateFormatter()
//
//    // initially set the format based on your datepicker date
//    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//    let myString = formatter.string(from: date)
//    // convert your string to date
//    let yourDate = formatter.date(from: myString)
//    //then again set the date format whhich type of output you need
//
//    formatter.calendar = Calendar (identifier: .persian)
//    formatter.dateFormat = "yyyy/MM/dd"
//    formatter.locale = Locale.init(identifier: "fa_IR")
//    // again convert your date to string
//    dateString = formatter.string(from: yourDate!)
//
//    self.performSegue(withIdentifier: "addEvent", sender: UIView.self)
//}
//
//@IBOutlet weak var tblCalendar: UITableView!
//
//
//func calendar(_ calendar: FSCalendar!, didSelectDate date: Date!) {
//
//    eventIndex.removeAll()
//    let formatter = DateFormatter()
//    // initially set the format based on your datepicker date
//    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//    let myString = formatter.string(from: date)
//    // convert your string to date
//    let yourDate = formatter.date(from: myString)
//    //then again set the date format whhich type of output you need
//
//    formatter.calendar = Calendar (identifier: .persian)
//    formatter.dateFormat = "yyyy/MM/dd"
//    formatter.locale = Locale.init(identifier: "fa_IR")
//    // again convert your date to string
//    let selectedDate = formatter.string(from: yourDate!)
//
//    var index = [Int()]
//    if dates.isEmpty == false{
//        for i in 0...dates.count - 1 {
//            if dates[i] == selectedDate{
//                index.append(i)
//            }
//        }
//    }
//    index.remove(at: 0)
//    if index.isEmpty == false {
//        for i in 0...index.count - 1 {
//            let isIndexValid = dates.indices.contains(index[i])
//
//            if  isIndexValid == true {
//                let isEventValid = event.indices.contains(index[i])
//                if isEventValid == true{
//                    eventIndex.append(event[index[i]])
//                }
//            }
//        }
//    }
//
//    tblCalendar.reloadData()
//}
//
//func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//    return 0
//}
//
//func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition){
//
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy/MM/dd"
//    dateFormatter.locale = Locale.init(identifier: "fa_IR")
//
//    for dateStr in dates{
//        if(dateFormatter.string(from: date) == dateStr)
//        {
//            cell.eventIndicator.numberOfEvents = 1
//            cell.eventIndicator.isHidden = false
//            cell.eventIndicator.color = UIColor.blue
//        }
//    }
//}
//
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    return eventIndex.count
//}
//
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//    if eventIndex.indices.contains(indexPath.row) == true {
//        cell.textLabel?.text = eventIndex [indexPath.row]
//    }
//
//    return cell
//}
//
//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    if eventIndex.indices.contains(indexPath.row) == true {
//        let text = eventIndex[indexPath.row]
//        if let indexOfCellString = event.index(of: text) {
//            tableViewCellNumber = indexOfCellString
//        }
//    }
//    tblCalendar.reloadData()
//    self.performSegue(withIdentifier: "infoView", sender: self)
//}
//
//func showArabicSubTitle(date: Date!) -> String!
//{
//    let dateFormater = DateFormatter()
//    dateFormater.dateFormat = "dd"
//    dateFormater.locale = Locale(identifier: "fa_IR")
//
//    var calendarDate = dateFormater.string(from: date as Date)
//    let characters = Array(calendarDate.characters)
//    let substituteArabic = ["0":"٠", "1":"١", "2":"٢", "3":"٣", "4":"٤", "5":"٥", "6":"٦", "7":"٧", "8":"٨", "9":"٩"]
//    var arabicDate =  ""
//
//    for i in characters {
//        if let subs = substituteArabic[String(i)] {
//            arabicDate += subs
//        } else {
//            arabicDate += String(i)
//        }
//    }
//    return arabicDate
//}
//
////MARK: - FSCalendarDelegate
//func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//    L102Language.setAppleLAnguageTo(lang: "fa")
//
//    return self.showArabicSubTitle(date: date)
//}
//
//override func viewDidLoad() {
//
//    if firstIndexRemover == true {
//        eventIndex.removeAll()
//        firstIndexRemover = false
//    }
//    super.viewDidLoad()
//
//    self.calendar.firstWeekday = 7
//    self.calendar.locale = Locale(identifier: "fa_IR")
//    self.calendar.select(Date())
//    self.calendar.identifier = NSCalendar.Identifier.persian.rawValue
//
//    tblCalendar.delegate = self
//    tblCalendar.dataSource = self
//    userData = UserDefaults.standard.bool(forKey: "userData")
//    if userData == true {
//        event = UserDefaults.standard.object(forKey: "theEvent") as! [String]
//    }else{
//        event.append("رخدادی موجود نیست")
//        UserDefaults.standard.set(event, forKey: "theEvent")
//        if event[0] == "رخدادی موجود نیست"{
//            event.remove(at:0)
//            UserDefaults.standard.set(event, forKey: "theEvent")
//        }
//    }
//    tblCalendar.reloadData()
//    tblCalendar.backgroundColor = UIColor.lightGray
//}
//
//func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    cell.backgroundColor = UIColor.clear
//}
//
//func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
//    let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
//    if editingStyle == UITableViewCellEditingStyle.delete{
//        eventIndex.remove (at:indexPath.row)
//        for i in 0...event.count - 1{
//            let isIndexValid = event.indices.contains(i)
//            if isIndexValid == true {
//                if event[i] == cell.textLabel?.text{
//                    event.remove(at: i)
//                }
//
//            }
//        }
//        UserDefaults.standard.set (event, forKey:"theEvent")
//    }
//    tblCalendar.reloadData()
//
//}
//func tableView(_ tableView: UITableView,
//               titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
//    return "حذف"
//}
//override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//}
//override func viewDidAppear(_ animated: Bool){
//    tblCalendar.reloadData()
//}
