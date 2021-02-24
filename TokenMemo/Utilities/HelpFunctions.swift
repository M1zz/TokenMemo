//
//  HelpFunctions.swift
//  TokenMemo
//
//  Created by 이현호 on 2020/12/03.
//

import UIKit

open class HelperFunctions: NSObject {
    class func makeToast(_ message: String?, lineCount: Int = 2) {
        guard message != nil else {
            return
        }
        
        let WIDTH = CGFloat(305)
        let HEIGHT = CGFloat(80)
        
        let toastLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width / 2 - 150,
                                               y: UIScreen.main.bounds.size.height * 0.75,
                                               width: WIDTH,
                                               height: HEIGHT))
        
        toastLabel.backgroundColor = UIColor.systemGray
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        if let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) {
            window.addSubview(toastLabel)
        }
        
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 18.0
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        UIView.animate(withDuration: 1, delay: 4, options: .curveEaseInOut, animations: { toastLabel.alpha = 0.0 }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
}
