
import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let storeViewModel = StoreViewModel()
    let scheduleViewModel = ScheduleViewModel()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0)
        return true
    }
   
    func applicationDidEnterBackground(_ application: UIApplication) {
        storeViewModel.saveData()
        scheduleViewModel.saveData()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        storeViewModel.saveData()
        scheduleViewModel.saveData()
    }
}
