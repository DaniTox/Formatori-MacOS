//
//  Constants.swift
//  Formatori
//
//  Created by Dani Tox on 18/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

var verifiche : [Verifica] = []

var tempFormatore : Formatore?

var savedData : [String: String]? {
    get {
        if let dict = UserDefaults.standard.dictionary(forKey: "userSaved") as? [String: String] {
            return dict
        }
        else {
            return ["user": "", "password": ""]
        }
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userSaved")
    }
}


extension Date {
    var string : String {
        let c = Calendar.current
        let day = c.component(.day, from: self)
        let month = c.component(.month, from: self)
        let year = c.component(.year, from: self)
        
        let str = "\(day)-\(month)-\(year)"
        return str
    }
}



let classi : [String] = ["1E", "2E", "3E", "4E", "1M", "2M", "3M", "4M"]

let materie : [String] = [
    "Italiano",
    "Matematica",
    "Inglese",
    "Informatica",
    "Scienze",
    "IRC",
    "Diritto",
    "Att. Motoria",
    "Economia",
    "Disegno Elettrico",
    "Narrativa",
    "Elettrotecnica",
    "Lab. Elettrico",
    "Tecnologia Elettrica",
    "Sicurezza",
    "Impianti",
    "Automazione",
    "Meccanica",
    "PLC",
    "Elettronica",
    "Sistemi",
    "CAD CAM",
    "Comunicazione",
    "Disegno Meccanico",
    "Tecnologia Motoristica"
]
