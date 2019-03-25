//
//  TableViewController.swift
//  Cervezologia
//
//  Created by Linetes on 3/25/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    
    var db: Firestore!
    
    var cervezas = [Cerveza]()
    var alturaCelda = CGFloat(122)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        getBeers()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //get cervezas from database
    func getBeers() {
        db.collection("Cervezas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
//          debug getting collections correctly
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let nombre = data["Nombre"] as! String
                    let estilo = data["Estilo"] as! String
                    let cerveceria = data["Cervecería"] as! String
                    let origen = data["Origen"] as! String
                    let abv = data["ABV"] as! String
                    let ibu = data["IBU"] as! String
                    let srm = data["SRM"] as! String
                    let fotoURL = data["fotoURL"] as! String

                    let cerveza = Cerveza(nombre: nombre, estilo: estilo, cerveceria: cerveceria, origen: origen, abv: abv, ibu: ibu, srm: srm, fotoURL: fotoURL)
                    self.cervezas.append(cerveza)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func photoFromURL(urlString: String) -> UIImage {
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                let foto = UIImage(data: data)!
                return foto
            } catch let err {
                print("Error : \(err.localizedDescription)")
                let fotoGenerica = UIImage(named: "cerveza")!
                return fotoGenerica
            }
        } else {
            let fotoGenerica = UIImage(named: "cerveza")!
            return fotoGenerica
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cervezas.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return alturaCelda
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! CustomTableViewCell
        cell.lbNombre.text = cervezas[indexPath.row].nombre
        cell.lbEstilo.text = cervezas[indexPath.row].estilo
        let foto = photoFromURL(urlString: cervezas[indexPath.row].fotoURL)
        cell.imgFoto.image = foto
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vista = segue.destination as! ViewController
        let indexPath = tableView.indexPathForSelectedRow!
        vista.nombre = cervezas[indexPath.row].nombre
        vista.estilo = cervezas[indexPath.row].estilo
        vista.cerveceria = cervezas[indexPath.row].cerveceria
        vista.origen = cervezas[indexPath.row].origen
        vista.abv = cervezas[indexPath.row].abv
        vista.ibu = cervezas[indexPath.row].ibu
        vista.srm = cervezas[indexPath.row].srm
        let foto = photoFromURL(urlString: cervezas[indexPath.row].fotoURL)
        vista.foto = foto
        
    }

}
