//
//  LoginViewController.swift
//  Weather
//
//  Created by Test on 11/03/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginPresenter: LoginPresenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
        loginPresenter.attachView(view: self)
        view.backgroundColor = UIColor(named: "background")
    }
    
    private let backLogoImg: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary")
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImg: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.image = UIImage(named: "loginIcon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let userTxt: UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .center
        textfield.backgroundColor = .white
        textfield.textColor = UIColor(named: "font")
        textfield.layer.cornerRadius = 15
        textfield.placeholder = "USER"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    
    private let passwordTxt: UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .center
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 15
        textfield.textColor = UIColor(named: "font")
        textfield.placeholder = "PASSWORD"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let loginBtn: UIButton = {
       let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.textColor = UIColor(named: "background")
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 15
        button.addTarget(self, action:#selector(login(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let iconImg: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.image = UIImage(named: "logoIcon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func createView(){
        var padding = CGFloat(50)
        let heightTxt = CGFloat(50)
        
        if Sesion.instance.typeDevice == "phone"{
            padding = CGFloat(50)
        }else if Sesion.instance.typeDevice == "pad"{
            padding = CGFloat(150)
        }
        
        
        view.addSubview(backLogoImg)
        
        backLogoImg.topAnchor.constraint(equalTo: view.topAnchor, constant: -10).isActive = true
        backLogoImg.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backLogoImg.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backLogoImg.heightAnchor.constraint(equalToConstant: Sesion.instance.topPading + 150).isActive = true
        
        backLogoImg.addSubview(logoImg)
        
        logoImg.bottomAnchor.constraint(equalTo: backLogoImg.bottomAnchor, constant: -10).isActive = true
        logoImg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        logoImg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
        logoImg.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(userTxt)
        view.addSubview(passwordTxt)
        view.addSubview(loginBtn)
        
        userTxt.topAnchor.constraint(equalTo: backLogoImg.bottomAnchor, constant: 50).isActive = true
        userTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        userTxt.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
        userTxt.heightAnchor.constraint(equalToConstant: heightTxt).isActive = true
        
        passwordTxt.topAnchor.constraint(equalTo: userTxt.bottomAnchor, constant: 20).isActive = true
        passwordTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        passwordTxt.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
        passwordTxt.heightAnchor.constraint(equalToConstant: heightTxt).isActive = true
        
        loginBtn.topAnchor.constraint(equalTo: passwordTxt.bottomAnchor, constant: 20).isActive = true
        loginBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: heightTxt).isActive = true
        
        view.addSubview(iconImg)
        
        iconImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-padding).isActive = true
        iconImg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        iconImg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
        iconImg.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    @objc
    func login(sender: UIButton){
        loginPresenter.login(user: userTxt.text ?? "", password: passwordTxt.text ??  "")
    }
    
    func logged(){
        self.performSegue(withIdentifier: "climatesListSegue", sender: nil)
    }
    
    func error(title: String, message: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
