//
//  UIUtils.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
import UIKit

class UIUtils: NSObject {
    
    // get view controller by identifier
    class func viewControllerWithIndentifier(identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    // store object to user default
    class func storeObjectToUserDefault(_ object: AnyObject, key: String) {
        let dataSave = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(dataSave, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    // get object to user default
    class func getObjectFromUserDefault(_ key: String) -> AnyObject? {
        if let object = UserDefaults.standard.object(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: object as! Data) as AnyObject?
        }
        return nil
    }
    
    class func removeObjectUserDefault(_ key: String) -> Void {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key)
    }
    
    class func removeAllValueUserDefault() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }

}
