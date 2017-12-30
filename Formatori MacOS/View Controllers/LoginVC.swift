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
    @IBOutlet weak var loadingBar: NSProgressIndicator!
    
    var isLoading = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if self?.isLoading == true {
                    self?.loadingBar.isHidden = false
                    self?.loadingBar.startAnimation(self)
                }
                else {
                    self?.loadingBar.stopAnimation(self)
                    self?.loadingBar.isHidden = true
                }
            }
        }
    }
    
    
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
        
    }

    override func viewDidAppear() {
        if nome.isEmpty {
            nomeTextField.becomeFirstResponder()
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func login(_ sender: NSButton) {
        if checkInput() == false { return }
        
        isLoading = true
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
        self.isLoading = false
        
        if code == 1 {
            print("Errore: \(message!)")
            if let msg = message {
                DispatchQueue.main.async {
                    let alert = NSAlert()
                    alert.alertStyle = .warning
                    alert.addButton(withTitle: "Ok")
                    alert.messageText = "Errore"
                    alert.informativeText = msg
                    alert.runModal()
                }
            }
            
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
                
                NSApplication.shared.mainWindow?.close()
                self.performSegue(withIdentifier: NSStoryboardSegue.Identifier("showHomeVC"), sender: self)
            }
            
        }
    }
}

extension NSViewController {
    func getAlert(title: String, msg: String) -> NSAlert {
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Ok")
        alert.messageText = title
        alert.informativeText = msg
        return alert
    }
}




