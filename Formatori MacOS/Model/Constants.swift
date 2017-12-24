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


//var formatore : Formatore? {
//    if let data = UserDefaults.standard.data(forKey: "formatore") {
//        if let temp = try? JSONDecoder().decode(Formatore.self, from: data) {
//            return temp
//        }
//    }
//    if let form = tempFormatore { return form }
//
//    return nil
//}


//extension UIViewController {
//    func getAlert(title: String, message : String) -> UIAlertController {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        return alert
//    }
//}

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
