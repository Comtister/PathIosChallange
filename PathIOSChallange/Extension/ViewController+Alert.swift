//
//  ViewController+Alert.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 10.03.2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    func alert(error : String){
        let alert = UIAlertController(title: "Ops", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
