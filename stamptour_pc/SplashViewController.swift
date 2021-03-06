//
//  SplashViewController.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 2..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController : UIViewController{
    
    @IBOutlet var bgImg: UIImageView!
    @IBOutlet var logoImg: UIImageView!
    @IBOutlet var applyName: UILabel!
    @IBOutlet var produceName: UILabel!
    
    let TAG = "SplashViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDefaultManager.init().setFirst(true)
        unZipTest()
        setView()
        callTimer()
       
        
    }
    
    func unZipTest(){
        //FileBrowser.init().updateFiles()
        let fileBrowser = FileBrowser.init()
        fileBrowser.updateFiles()
        //fileBrowser.setUnZip(file: "contents.zip")
        //fileBrowser.fileUnZip()
        
    }
    func setView(){
        switch AppInfomation.region! {
        case ResRegion.pochun.hashValue:
            self.bgImg.image = UIImage(named: "img_splash_bg")
            self.applyName.text = "©2016. POCHEON"
            break
        case ResRegion.shinan.hashValue:
            self.applyName.text = "©2016. SHINAN"
            self.applyName.textColor = UIControlManager.init().colorWithHexString("#303030")
            self.produceName.textColor =  UIControlManager.init().colorWithHexString("#B4B4B4")
            break
        case ResRegion.gyeongju.hashValue:
            self.applyName.text = "©2016. GYEONGJU"
            self.applyName.textColor = UIControlManager.init().colorWithHexString("#303030")
            self.produceName.textColor =  UIControlManager.init().colorWithHexString("#B4B4B4")
            break
        case ResRegion.gongju.hashValue:
            self.bgImg.image = UIImage(named: "img_splash_bg")
            self.applyName.text = "©2016. GONGJU"
            self.applyName.textColor = UIControlManager.init().colorWithHexString("#303030")
            self.produceName.textColor =  UIControlManager.init().colorWithHexString("#B4B4B4")
            break
        default: break
        }
        
        self.logoImg.image = UIImage(named: "img_splash_logo")
        
//        self.bgImg.image = UIImage(named: "img_splash_bg")
//        self.logoImg.image = UIImage(named: "img_splash_logo")
//        self.applyName.text = "©2016. POCHEON"
        //self.applyName.text = "©2016. SHINAN"

        //self.applyName.textColor = UIControlManager.init().colorWithHexString("#303030")
        //self.produceName.textColor =  UIControlManager.init().colorWithHexString("#B4B4B4")
        
        

    }

    
    func show() {
//       if(UserDefaultManager.init().getIsLoggedState()){
//           SideBarSetupGo.init().startSideBarThemeViewController()
//       }else{
//           self.performSegue(withIdentifier: "showApp", sender: self)
//       }
       // self.performSegue(withIdentifier: "showApp", sender: self)
        print("\(self.TAG) : login state : \(UserDefaultManager.init().getIsLoggedState())")
        if UserDefaultManager.init().getIsLoggedState(){
            UserDefaultManager.init().defaultLogin(uvc: self)
           
        }else{
             self.performSegue(withIdentifier: "showApp", sender: self)
        }
        
    }
    
    func callTimer(){
        let timer = Timer.scheduledTimer(
            timeInterval: 3.0, target: self, selector: #selector(UIAlertView.show), userInfo: nil, repeats: false
        )
    }
    
  

}
