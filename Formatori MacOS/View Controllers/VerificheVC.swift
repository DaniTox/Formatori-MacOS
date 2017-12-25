//
//  VerificheVC.swift
//  Formatori MacOS
//
//  Created by Dani Tox on 24/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Cocoa

class VerificheVC: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var segControl: NSSegmentedControl!
    @IBOutlet weak var eliminaOutlet: NSButton!
    
    var filterMode : ((Verifica) -> Bool)? = { return $0.idVerifica != -1 }
    var verificaSelected : Verifica?
    
    var loader : Loader?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = Loader()
        loader?.delegate = self
        
        loader?.loadMyVerifiche()   
    }
    
    
    @IBAction func segmentTouched(_ sender: NSSegmentedControl) {
        if let selectedLabelText = sender.label(forSegment: sender.selectedSegment) {
            filterMode = { return $0.classe == selectedLabelText }
            tableView.reloadData()
        }
        else {
            getAlert(title: "Errore", msg: "Error in segment touched").runModal()
        }

    }
    
    
    @IBAction func eliminaAction(_ sender: NSButton) {
        verificaSelected = correctVerifiche[tableView.selectedRow]
        loader?.removeVerifica(id: verificaSelected!.idVerifica)
    }
    
    @IBAction func setCorretta(_ sender: NSButton) {
        verificaSelected = correctVerifiche[tableView.selectedRow]
        if let ver = verificaSelected {
            loader?.set_ver_to_done_state(idVerifica: ver.idVerifica)
        }
    }
    
}

extension VerificheVC : NSTableViewDelegate, NSTableViewDataSource {
    
    var correctVerifiche : [Verifica] {
        return verifiche.filter(filterMode!)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 35
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return correctVerifiche.count
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRowIndexes.count > 0 {
            eliminaOutlet.isEnabled = true
        } else {
            eliminaOutlet.isEnabled = false
        }
        
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text = ""
        
        if tableColumn == tableView.tableColumns[0] {
            text = correctVerifiche[row].materia
        }
        if tableColumn == tableView.tableColumns[1] {
            text = correctVerifiche[row].titolo
        }
        if tableColumn == tableView.tableColumns[2] {
            text = correctVerifiche[row].classe
        }
        if tableColumn == tableView.tableColumns[3] {
            text = correctVerifiche[row].data
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}


extension VerificheVC : LoaderDelegate {
    func didFinishLoadVerificheWith(_ code: Int, and message: String?) {
        if code != 0 {
            DispatchQueue.main.async {
                let alert = NSAlert()
                alert.alertStyle = .warning
                alert.addButton(withTitle: "Ok")
                alert.messageText = "Errore"
                alert.informativeText = message ?? "Errore generico"
                alert.runModal()
            }
        } else {
            DispatchQueue.main.async {
                print("verifiche caricate... delegate sent reloadData()")
                self.tableView.reloadData()
            }
        }
    }
    
    func didRemoveVerificaWith(code: Int, andMsg message: String?) {
        if code != 0 {
            DispatchQueue.main.async {
                self.getAlert(title: "Errore", msg: message ?? "Errore generico").runModal()
            }
        } else {
            DispatchQueue.main.async {
                self.getAlert(title: "Completato", msg: "Verifica eliminata con successo").runModal()
                for (i, verifica) in verifiche.enumerated() {
                    if verifica.idVerifica == self.verificaSelected?.idVerifica {
                        verifiche.remove(at: i)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func set_ver_state_doneDidFinish(code: Int, andMsg message: String?) {
        if code != 0 {
            DispatchQueue.main.async {
                self.getAlert(title: "Errore", msg: message ?? "Errore generico").runModal()
            }
        }
        else {
            DispatchQueue.main.async {
                self.getAlert(title: "Successo!", msg: "La verifica è stata modificata come corretta senza aver ricevuto problemi").runModal()
                for (i, verifica) in verifiche.enumerated() {
                    if verifica.idVerifica == self.verificaSelected?.idVerifica {
                        verifiche.remove(at: i)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
}
