//
//  LoginPresenter.swift
//  Weather
//
//  Created by Test on 12/03/21.
//

import Foundation
class LoginPresenter: NSObject {
    weak private var loginView: LoginViewController?
    
    func attachView(view: LoginViewController){
        loginView = view
    }
    
    func login(user: String, password: String){
        if user == "JozafatCronox" && password == "Pass"{
            loginView?.logged()
        }else{
            loginView?.error(title: "Login", message: "User or password are wrong")
            
        }
    }
}
