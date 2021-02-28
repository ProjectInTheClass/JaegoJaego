//
//  TabBarExtention.swift
//  proc
//
//  Created by 성다연 on 02/09/2019.
//  Copyright © 2019 swuad-19. All rights reserved.
//

import UIKit

class TabBarExtention: UITabBarController {
    let button = UIButton(type: .custom)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let newButton = UIImage(named: "calendartabicon"){
            self.addCenterButton(withImage: newButton,highlightImage: newButton)
        }
    }
    
    func addCenterButton(withImage buttonImage: UIImage, highlightImage : UIImage){
        let paddingBottom : CGFloat = 20.0

        let button = UIButton(type: .custom)
        button.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin]
        button.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width / 1.4 , height: buttonImage.size.height / 1.4 )
        button.setBackgroundImage(buttonImage, for: .normal)
        button.setBackgroundImage(highlightImage, for: .highlighted)

        
        let rectBoundTabbar = self.tabBar.bounds
        let xx = rectBoundTabbar.midX
        let yy = rectBoundTabbar.midY - paddingBottom
        button.center = CGPoint(x: xx, y: yy)

        self.tabBar.addSubview(button)
        self.tabBar.bringSubviewToFront(button)

        button.addTarget(self, action: #selector(handleTouchTabbarCenter), for: .touchUpInside)

        if let count = self.tabBar.items?.count
        {
            let i = floor(Double(count / 2))
            let item = self.tabBar.items![Int(i)]
            item.title = ""
        }
    }
    
    @objc func handleTouchTabbarCenter(sender: UIButton){
        if let count = self.tabBar.items?.count {
            let i = floor(Double(count/2))
            self.selectedViewController = self.viewControllers?[Int(i)]
        }
    }
}
