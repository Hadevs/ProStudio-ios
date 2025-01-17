//
//  AppDelegate.swift
//  ProStudio
//
//  Created by Nikita on 22/06/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Fabric
import Crashlytics
import Firebase

enum ProjectType: String {
    case appsAndSites = "Сайты, приложения"
    case branding = "Брендинг"
    case seo = "Продвижение"
    case analytics = "Аналитика"
	
	var color: UIColor {
		switch self {
		case .appsAndSites: return UIColor(netHex: 0x0081CC)
		case .branding: return UIColor(netHex: 0xF7C200)
		case .seo: return UIColor(netHex: 0x8E1C77)
		case .analytics: return UIColor(netHex: 0xDB2149)
		}
	}
}

extension String {
    func formattedEmail() -> String {
        return self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "@", with: "")
    }
}

func createProject(for email: String) {
    func date(_ str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: str)!
    }
  
    let ref = Database.database().reference()
    let startDate = "01.05.2018"
    let endDate = "21.12.2018"
    let id = ID()
    ref.child("projects").child(email.formattedEmail()).child(id).setValue([
        "id": id,
        "client": email,
        "type": ProjectType.branding.rawValue,
        "startDate": date(startDate).timeIntervalSince1970,
        "endDate": date(endDate).timeIntervalSince1970,
        "name": "Prostudio",
        "isEnded": false,
        "progress": 65,
        "steps": [
            ["name": "Разработка прототипа", "isEnded": true, "endDate": date(endDate).timeIntervalSince1970],
            ["name": "Разработка 123", "isEnded": false, "endDate": date(endDate).timeIntervalSince1970]
        ]
        ])
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
//    func reigisterUser() {
//        Auth.auth().createUser(withEmail: "hhadevs@gmail.com", password: "12345678") { (result, error) in
//            print("jojojoj")
//            print(result, error)
//        }
//    }
    
   
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let customFont = PSFont.introBook.with(size: 17)
		UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        UIApplication.shared.statusBarStyle = .lightContent
		Fabric.with([Crashlytics.self])
        FirebaseApp.configure()
		IQKeyboardManager.shared.enable = true
		IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Готово"
//        reigisterUser()
//        createProject(for: "hhadevs@gmail.com")
		//TEMP LOADING VIEW DELETE IT AFTER LOAD TO GIT
		let tabBarController = UITabBarController()
		let appearance = UITabBarItem.appearance()
		let attributes = [NSAttributedString.Key.font: PSFont.introRegular.with(size: 10)]
		appearance.setTitleTextAttributes(attributes, for: .normal)
		let registerVC = UINavigationController(rootViewController: RegistraionViewController())
		let registerTabItem = UITabBarItem(title: "Регистрация", image: UIImage.init(named: "key"), tag: 0)
		let inset: CGFloat = 0
		registerTabItem.imageInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
		tabBarController.tabBar.tintColor = PSColor.cerulean
		tabBarController.tabBar.unselectedItemTintColor = PSColor.coolGrey
		registerVC.tabBarItem = registerTabItem
		
		
		let contactsVC = UINavigationController(rootViewController: ContactsViewController())
		let contactsTabItem = UITabBarItem(title: "Контакты", image: UIImage.init(named: "contacts"), tag: 0)
		let inset2: CGFloat = 0
		registerTabItem.imageInsets = UIEdgeInsets(top: inset2, left: inset2, bottom: inset2, right: inset2)
		tabBarController.tabBar.tintColor = PSColor.cerulean
		tabBarController.tabBar.unselectedItemTintColor = PSColor.coolGrey
		contactsVC.tabBarItem = contactsTabItem
		
		
		let discussVC = UINavigationController(rootViewController: ProjectDiscussion())
		let discussTabItem = UITabBarItem(title: "Обсудить проект", image: UIImage.init(named: "discuss"), tag: 0)
		let inset3: CGFloat = 0
		registerTabItem.imageInsets = UIEdgeInsets(top: inset3, left: inset3, bottom: inset3, right: inset3)
		discussVC.tabBarItem = discussTabItem
		tabBarController.setViewControllers([registerVC, discussVC, contactsVC], animated: true)
		let root = tabBarController
		
		if let window = self.window {
			window.rootViewController = root
		}
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
}

