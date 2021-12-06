//
//  TableViewController.swift
//  TodoList
//
//  Created by faisal on 02/05/1443 AH.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    @IBOutlet var table: UITableView!
    var list=[Todo]()
    let cr=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        getall()
        table.dataSource=self
        table.delegate=self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                    if cell.accessoryType == .checkmark{
                        cell.accessoryType = .none
                        list[indexPath.row].check = false
                    }
                    else{
                        cell.accessoryType = .checkmark
                        list[indexPath.row].check = true
                    }
                }
        if cr.hasChanges {
            do {
                try cr.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
    }
    
    func cancel(by cont: UIViewController) {
        getall()
        table.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func getall(){
        let req=NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do{
            let fet = try cr.fetch(req)
            list = fet as! [Todo]
            
        }catch{
            print(error)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let nv = segue.destination as! UINavigationController
            let seg = nv.topViewController! as! ViewController
            seg.owner=self
            
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellmodel
        cell.title.text=list[indexPath.row].title
        cell.date.text=list[indexPath.row].date
        cell.detail.text=list[indexPath.row].detail
        if list[indexPath.row].check{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        items.remove(at: indexPath.row)
        cr.delete(list[indexPath.row])
        if cr.hasChanges {
            do {
                try cr.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        getall()
        table.reloadData()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
