//
//  AppDelegate.swift
//  Cup'N'Spoon
//
//  Created by Raymond Diamonds on 2017-07-10.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let clientId = "QPNrE0x7lV35PZrftEtXug"
    let clientSecret = "JmnL4tC4ujOYo0ocnTho5pxuLgA3WUCcuBENiQWEDTEgcvUiEzyDZKbqfnmAbmfh"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaults.standard.value(forKey: "token") as? String == nil {
            let tokenURL = "https://api.yelp.com/oauth2/token"

            let params: Parameters = ["client_id": clientId, "client_secret": clientSecret]
            
            //Alamofire.request(tokenURL, method: .post, parameter: params)
            Alamofire.request(tokenURL, method: .post, parameters: params, encoding: URLEncoding.default).responseData { (response) in
                let json = JSON(with: response.data!)
                //            print("Here is JSON: \(json)")
                print(json["access_token"])
                let accessToken = json["access_token"].stringValue
                
                UserDefaults.standard.setValue(accessToken, forKey: "token")
            }
        }
        
        // 1
        


        
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

