//
//  RegionPartitionSystem.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit


class RegionPartitionSystem  {
    
    class var shared: RegionPartitionSystem {
        struct Static {
            static let instance: RegionPartitionSystem = RegionPartitionSystem()
        }
        return Static.instance
    }
    
    func setResourse(){
        let enm : ResRegion
        
        let region = ResRegion.shinan
        AppInfomation.region = region
        AppInfomation.themeColor = region.mainColor
        AppInfomation.name = region.appName
        print("RegionPartitionSystem : \(region.appName)")
        AppInfomation.pakageName = region.appPakage
        AppInfomation.host = region.appHost
        AppInfomation.localizeCode = LocalizationManager.shared.getLanguageCode()
    }
    
    
    func adjust(){
        
    }
    
    func show(regionInCase : Int){
        switch regionInCase {
        case RegionInCase.pochun.hashValue:
            break
        case RegionInCase.shinan.hashValue:
            break
        default:
            break
        }
    }
    
    func setRegion(regionInCase : Int){
        //패키지명변경
        //앱이름 변경
        //앱아이콘변경
        //스탬프이미지변경
        //스플래시 이미지변경
        //앱 배경색 변경
        //텍스트변경
    }
    
}
