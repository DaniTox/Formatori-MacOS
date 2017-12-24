//
//  ViewController.swift
//  Formatori MacOS
//
//  Created by Dani Tox on 24/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Cocoa

class LoginVC: NSViewController {

    var nome : String {
        get {
            return nomeTextField.stringValue
        }
        set {
            nomeTextField.stringValue = newValue
        }
    }
    var password : String {
        get {
           return passwordTextField.stringValue
        }
        set {
            passwordTextField.stringValue = newValue
        }
    }
    
    @IBOutlet weak var nomeTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var saveMeButton: NSButton!
    
    var auther : Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auther = Auth()
        auther?.delegate = self

        
        if let userData = savedData {
            nome = userData["user"]!
            password = userData["password"]!
            if let hasToActivate = userData["activate"] {
                if hasToActivate == "on" {
                    saveMeButton.state = .on
                }
                else {
                    saveMeButton.state = .off
                }
            }
            else {
                saveMeButton.state = .off
            }
        }
        
        if nome.isEmpty {
            
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func login(_ sender: NSButton) {
        if checkInput() == false { return }
        
        auther?.login(with: nome, password: password)
        
    }
    
    private func checkInput() -> Bool {
        if nomeTextField.stringValue.isEmpty {
            return false
        }
        if passwordTextField.stringValue.isEmpty {
            return false
        }
        
        return true
    }

}

extension LoginVC : responseDelegate {
    func loginDidFinish(with code: Int, and message: String?) {
        if code == 1 {
            print("Errore: \(message!)")
        }
        else {
            print("Formatore ottenuto con successo: \(tempFormatore?.nome ?? "Errore")")
            DispatchQueue.main.async {
                if self.saveMeButton.state == .on {
                    savedData = ["user" : self.nome, "password": self.password, "activate" : "on"]
                }
                else {
                    savedData = nil
                }
            }
            
        }
    }
}






