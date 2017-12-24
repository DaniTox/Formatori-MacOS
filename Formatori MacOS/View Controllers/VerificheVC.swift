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
    
    var filterMode : ((Verifica) -> Bool)? = { return $0.idVerifica != -1 }
    
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
}
