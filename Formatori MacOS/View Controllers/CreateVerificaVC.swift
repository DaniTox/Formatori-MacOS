//
//  CreateVerificaVC.swift
//  Formatori MacOS
//
//  Created by Dani Tox on 24/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Cocoa

class CreateVerificaVC: NSViewController {

    @IBOutlet weak var classePopButton: NSPopUpButton!
    @IBOutlet weak var selectMateriaPop: NSPopUpButton!
    @IBOutlet weak var argomentoTextField: NSTextField!
    @IBOutlet weak var datePicker: NSDatePicker!
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
    
    var materia : String { return selectMateriaPop.selectedItem?.title ?? "nil" }
    var classe : String { return classePopButton.selectedItem?.title ?? "nil" }
    var argomento : String { return argomentoTextField.stringValue }
    var data : Date { return datePicker.dateValue }
    
    var loader : Loader?
    override func viewDidLoad() {
        super.viewDidLoad()
        selectMateriaPop.removeAllItems()
        selectMateriaPop.addItem(withTitle: "Seleziona una materia")
        selectMateriaPop.addItems(withTitles: materie)
        classePopButton.removeAllItems()
        classePopButton.addItem(withTitle: "Scegli una classe")
        classePopButton.addItems(withTitles: classi)
        datePicker.dateValue = Date()
        
        loader = Loader()
        loader?.delegate = self
    }
    
    @IBAction func creaVerifica(_ sender: NSButton) {
        isLoading = true
        loader?.createVerifica(materia: materia, argomento: argomento, classe: classe, data: data)
    }
}

extension CreateVerificaVC : LoaderDelegate {
    func didCreateVerificaWithReturnCode(_ code: Int, and message: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            let alert = NSAlert()
            
            alert.alertStyle = .warning
            alert.addButton(withTitle: "Ok")
            if code != 0 {
                alert.messageText = "Errore"
                alert.informativeText = message ?? "errore generico"
            } else {
                alert.messageText = "Completato"
                alert.informativeText = "La verifica è stata creata con successo!"
            }
            alert.runModal()
            NSApplication.shared.mainWindow?.close()
            
        }
        
    }
}

