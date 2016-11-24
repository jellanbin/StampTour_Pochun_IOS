//
//  JoinViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class JoinViewController : UIViewController, UITextFieldDelegate, HttpResponse{
    
    let TAG : String = "JoinViewController"
    var chkId : Bool? = false
    var chkNick : Bool? = false
    var httpRequest : HttpRequestToServer?
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var id_txt: UITextField!
    @IBOutlet var nick_txt: UITextField!
    @IBOutlet var pass_txt: UITextField!
    @IBOutlet var repass_txt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.id_txt.addTarget(self, action: #selector(self.textFieldDidChangeId(_:)), for: UIControlEvents.editingChanged)
        self.nick_txt.addTarget(self, action: #selector(self.textFieldDidChangeName(_:)), for: UIControlEvents.editingChanged)
        
        scrollView.contentSize.height = 667
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
       
    }
  
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    
    @IBAction func id_overlap_btn(_ sender: AnyObject) {
        self.chkIdOverlap()
    }
    
    @IBAction func nick_overlap_btn(_ sender: AnyObject) {
        self.chkNickOverlap()
    }
    
    @IBAction func submit_btn(_ sender: AnyObject) {
        self.join()
    }
    
    @IBAction func terms_btn(_ sender: AnyObject) {
    }
    
    func textFieldDidChangeId(_ textField: UITextField) {
        self.chkId = false
        NSLog("중복체크 상태 : \(self.chkId!)")
    }
    
    func textFieldDidChangeName(_ textField: UITextField) {
        self.chkNick = false
        NSLog("중복체크 상태 : \(self.chkNick!)")
    }
    
    func chkIdOverlap(){
        let id = self.id_txt.text?.trimmingCharacters(in: .whitespaces)
       
        if(id != ""){
            if(TextValidation.init().isValidEmail(id)){
                
                let path = HttpReqPath.JoinIdOverlap
                let parameters : [ String : String] = [
                    "id" : id!
                ]
                
                self.httpRequest!.connection(path, reqParameter: parameters)
                
            }else{
                ActionDisplay.init(uvc: self).displayMyAlertMessage("이메일 형식으로 입력해주세요")
            }
        }else{
            ActionDisplay.init(uvc: self).displayMyAlertMessage("아이디를 입력해주세요")
        }
    }
    
    func chkNickOverlap(){
         let nick = self.nick_txt.text?.trimmingCharacters(in: .whitespaces)
        if(nick != ""){
            if(TextValidation.init().isValidName(nick)){
                let path = HttpReqPath.JoinNickOverlap
                let parameters : [ String : String] = [
                    "nick" : nick!
                ]
                
                self.httpRequest!.connection(path, reqParameter: parameters)
                
            }else{
                ActionDisplay.init(uvc: self).displayMyAlertMessage("6자이내 국문이나 영문으로 입력해주세요")
            }
        }else{
            ActionDisplay.init(uvc: self).displayMyAlertMessage("별명을 입력해주세요")
        }
    }
    
    func join(){
        let id = self.id_txt.text?.trimmingCharacters(in: .whitespaces)
        let nick = self.nick_txt.text?.trimmingCharacters(in: .whitespaces)
        let pass = self.pass_txt.text
        let repass = self.repass_txt.text
        if (!(id == "" || nick == "" || pass == "" || repass == "")){
            if (self.chkId! == true) {
                if(self.chkNick! == true){
                    if(pass == repass){
                        if(TextValidation.init().isValidPassword(self.repass_txt.text)){
                            let path = HttpReqPath.JoinReq
                            let parameters : [ String : String] = [
                                "loggedincase" : LoggedInCase.normal.description,
                                "id" : id!,
                                "password" : pass!,
                                "nick" : nick!
                            ]
                            self.httpRequest?.connection(path, reqParameter: parameters)
                            
                        }else{
                            ActionDisplay.init(uvc: self).displayMyAlertMessage("비밀번호는 6~16자 영문 소문자, 숫자를 조합하세요")
                        }
                    }else{
                        ActionDisplay.init(uvc: self).displayMyAlertMessage("비밀번호가 일치하지 않습니다")
                    }
                    
                }else{
                    ActionDisplay.init(uvc: self).displayMyAlertMessage("별명 중복확인이 필요합니다")
                }
            }else{
                ActionDisplay.init(uvc: self).displayMyAlertMessage("아이디 중복확인이 필요합니다")
            }
        }else{
            ActionDisplay.init(uvc: self).displayMyAlertMessage("빈칸을 모두 채워주세요")
        }
        
    }
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        if(reqPath == HttpReqPath.JoinIdOverlap){
            if data == "duplicate"{
                self.chkId = false
                 ActionDisplay.init(uvc: self).displayMyAlertMessage("중복된 아이디명입니다")
            }else {
                self.chkId = true
                 ActionDisplay.init(uvc: self).displayMyAlertMessage("사용할 수 있는 아이디명입니다")
            }
        }else if(reqPath == HttpReqPath.JoinNickOverlap){
            if data == "duplicate"{
                self.chkNick = false
                 ActionDisplay.init(uvc: self).displayMyAlertMessage("중복된 별명입니다")
            }else {
                self.chkNick = true
                 ActionDisplay.init(uvc: self).displayMyAlertMessage("사용할 수 있는 별명입니다")
            }
        }else if(reqPath == HttpReqPath.JoinReq){
             ActionDisplay.init(uvc: self).displayMyAlertMessageActionFromUvc("회원가입 되었습니다", action: CommonFunction.dismiss)
        }
    }

    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
    
}

