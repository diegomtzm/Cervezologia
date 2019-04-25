//
//  DiarioTableViewController.swift
//  Cervezologia
//
//  Created by Diego Martinez on 4/24/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit

class DiarioTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cervezasDiario = [CervezaDiario]()
    var filteredCervezas = [CervezaDiario]()
    var searchActive : Bool = false
    
    let alturaCelda = CGFloat(122)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCervezasDiario()

    }
    
    func getCervezasDiario() {
        let cerveza1 = CervezaDiario(nombre: "Cerveza 1", estilo: "Estilo 1", cerveceria: "Cerveceria 1", origen: "Origen 1", abv: "5", ibu: "10", srm: "22", lugar: "Lugar 1", almacenamiento: "Alm1", notas: "Notas 1", fotoURL: "-")
        let cerveza2 = CervezaDiario(nombre: "Cerveza 2", estilo: "Estilo 2", cerveceria: "Cerveceria 2", origen: "Origen 2", abv: "5", ibu: "10", srm: "22", lugar: "Lugar 2", almacenamiento: "Alm2", notas: "Notas 2", fotoURL: "-")
        self.cervezasDiario.append(cerveza1)
        self.cervezasDiario.append(cerveza2)
        self.tableView.reloadData()
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
    
    //MARK: - Search bar functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filtra cervezas por nombre o por estilo
        filteredCervezas = cervezasDiario.filter({ (cerveza) -> Bool in
            cerveza.nombre.lowercased().contains(searchText.lowercased()) || cerveza.estilo.lowercased().contains(searchText.lowercased())
        })
        if searchText == "" {
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchActive {
            return filteredCervezas.count
        } else {
            return cervezasDiario.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return alturaCelda
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell2", for: indexPath) as! CustomTableViewCell
        if searchActive {
            cell.lbNombre.text = filteredCervezas[indexPath.row].nombre
            cell.lbEstilo.text = filteredCervezas[indexPath.row].estilo
            let foto = photoFromURL(urlString: filteredCervezas[indexPath.row].fotoURL)
            cell.imgFoto.image = foto
        } else {
            cell.lbNombre.text = cervezasDiario[indexPath.row].nombre
            cell.lbEstilo.text = cervezasDiario[indexPath.row].estilo
            let foto = photoFromURL(urlString: cervezasDiario[indexPath.row].fotoURL)
            cell.imgFoto.image = foto
        }
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DiaryDetail" {
            let vista = segue.destination as! DiaryDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            var actualList = [CervezaDiario]()
            if searchActive {
                actualList = filteredCervezas
            } else {
                actualList = cervezasDiario
            }
            
            vista.nombre = actualList[indexPath.row].nombre
            vista.estilo = actualList[indexPath.row].estilo
            vista.cerveceria = actualList[indexPath.row].cerveceria
            vista.origen = actualList[indexPath.row].origen
            vista.abv = actualList[indexPath.row].abv
            vista.ibu = actualList[indexPath.row].ibu
            vista.srm = actualList[indexPath.row].srm
            vista.lugar = actualList[indexPath.row].lugar
            vista.almacenamiento = actualList[indexPath.row].almacenamiento
            vista.notas = actualList[indexPath.row].notas
            vista.fotourl = actualList[indexPath.row].fotoURL
            let foto = photoFromURL(urlString: actualList[indexPath.row].fotoURL)
            vista.foto = foto
        }
        
    }
    

}
