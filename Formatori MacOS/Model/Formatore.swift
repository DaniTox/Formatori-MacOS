//
//  Formatore.swift
//  Formatori
//
//  Created by Dani Tox on 17/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Formatore : Decodable, Encodable {
    
    var idFormatore : Int!
    var nome : String!
    var token : String!
    
    func login() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: "formatore")
        }
        else {
            print("ERROR ENCODING DATA FORMATORE TO USER DEFAULTS")
        }
    }
    
    func logout() {
        UserDefaults.standard.set(nil, forKey: "formatore")
    }
}

