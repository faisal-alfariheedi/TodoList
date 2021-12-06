//
//  ViewController.swift
//  TodoList
//
//  Created by faisal on 02/05/1443 AH.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tit: UITextField!
    @IBOutlet weak var det: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    var owner:UITableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func canc(_ sender: UIBarButtonItem) {
        
        (owner as! TableViewController).cancel(by: self)
    }
    @IBAction func add(_ sender: UIButton) {
        if(tit.text!.isEmpty&&det.text!.isEmpty){}else{
                let thing = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: (owner as! TableViewController).cr) as! Todo
            thing.title = String(tit.text!)
            thing.detail = String(det.text!)
            thing.check = false
            thing.date = date.date.formatted()
                if (owner as! TableViewController).cr.hasChanges {
                    do {
                        try (owner as! TableViewController).cr.save()
                        print("Success")
                    } catch {
                        print("\(error)")
                    }
            
            }
        }
        
        (owner as! TableViewController).cancel(by: self)
    }
    
}

