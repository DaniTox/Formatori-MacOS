//
//  Auth.swift
//  Formatori
//
//  Created by Dani Tox on 17/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Auth {
    
    weak var delegate : responseDelegate!
    
    func login(with nome: String, password: String) {
        let link = "\(Links.login)?nome=\(nome)&password=\(password)"
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            if let json = try? JSONDecoder().decode(Response.self, from: data) {
                
                if json.code != "200", let msg = json.message {
                    self?.delegate.loginDidFinish!(with: 1, and: msg)
                }
                else {
                    if let formatore = json.formatore {
                        tempFormatore = formatore
                        self?.delegate.loginDidFinish!(with: 0, and: nil)
                    }
                    else {
                        self?.delegate.loginDidFinish!(with: 1, and: "Can't get formatore form json")
                    }
                }
            }
        }.resume()
        
    }

    
}

@objc protocol responseDelegate {
    @objc optional func loginDidFinish(with code: Int, and message : String?)
}
