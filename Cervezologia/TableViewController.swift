//
//  TableViewController.swift
//  Cervezologia
//
//  Created by Linetes on 3/25/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController, UISearchBarDelegate, FilterOptions {
    
    var db: Firestore!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var btFavorites : UIBarButtonItem!
    
    var searchActive: Bool = false
    var cervezas = [Cerveza]()
    var filteredCervezas = [Cerveza]()
    var favoriteCervezas = [Cerveza]()
    var verFavoritos = false
    var usedFilters = ["estilo": ["", 0],
                       "cerveceria": ["", 0],
                       "origen": ["", 0],
                       "abv": ["", 0],
                       "ibu": ["", 0],
                       "srm": ["", 0]]
    
    var diarioVC : DiarioTableViewController!
    
    let alturaCelda = CGFloat(122)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        //search bar delegate
        searchBar.delegate = self
        
        btFavorites = UIBarButtonItem(image: UIImage(named: "star-small"), style: .plain, target: self, action: #selector(btFavoritesTapped))
        
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = btFavorites
        
        let navigationCtrl = tabBarController?.viewControllers![2] as! UINavigationController
        diarioVC = (navigationCtrl.viewControllers[0] as! DiarioTableViewController)
        
        getBeers()
    }

    //get cervezas from database
    func getBeers() {
        db.collection("Cervezas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
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
                self.obtenerListaFavoritos()
                self.diarioVC.obtenerListaDiario()
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
    
    func changeFavoriteButton() {
        if verFavoritos {
            btFavorites.image = UIImage(named: "star-small")
            verFavoritos = !verFavoritos
            tableView.reloadData()
        } else {
            btFavorites.image = UIImage(named: "starFilled-small")
            verFavoritos = !verFavoritos
            tableView.reloadData()
        }
    }
    
    @objc func btFavoritesTapped(sender: UIBarButtonItem) {
        changeFavoriteButton()
    }
    
    //MARK: - Search bar functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if (searchBar.text != "") {
            searchActive = true;
            print("TRUE")
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        print("FALSE")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("FALSE")

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("FALSE")

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filtra cervezas por nombre o por estilo
        if verFavoritos {
            filteredCervezas = favoriteCervezas
        } else {
            filteredCervezas = cervezas
        }
        filteredCervezas = filteredCervezas.filter({ (cerveza) -> Bool in
            cerveza.nombre.lowercased().contains(searchText.lowercased()) || cerveza.estilo.lowercased().contains(searchText.lowercased())
        })
        if searchText == "" {
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
    }
    
    //MARK - Codable persistence for favorites
    func storeFavorites() {
        do {
            print(Cerveza.archiveURL.path)
            let data = try PropertyListEncoder().encode(favoriteCervezas)
            try data.write(to: Cerveza.archiveURL)
        } catch {
            print("Favorites save failed")
        }
    }
    
    func retrieveFavorites() -> [Cerveza]? {
        do {
            let data = try Data(contentsOf: Cerveza.archiveURL)
            let fvts = try PropertyListDecoder().decode([Cerveza].self, from: data)
            return fvts
        } catch {
            print("Error reading or decoding favorites file")
            return [Cerveza]()
        }
    }
    
    func obtenerListaFavoritos() {
        favoriteCervezas.removeAll()
        let tmp = retrieveFavorites()
        favoriteCervezas = tmp!
        for favorita in favoriteCervezas {
            favorita.isFavorite = true
            if let index = cervezas.firstIndex(where: { $0.nombre == favorita.nombre }) {
                cervezas[index].isFavorite = true
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if verFavoritos && searchActive {
            return filteredCervezas.count
        } else if verFavoritos {
            return favoriteCervezas.count
        } else if searchActive {
            return filteredCervezas.count
        } else {
            return cervezas.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return alturaCelda
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! CustomTableViewCell
        if verFavoritos && searchActive {
            cell.lbNombre.text = filteredCervezas[indexPath.row].nombre
            cell.lbEstilo.text = filteredCervezas[indexPath.row].estilo
            let foto = photoFromURL(urlString: filteredCervezas[indexPath.row].fotoURL)
            cell.imgFoto.image = foto
        } else if verFavoritos {
            cell.lbNombre.text = favoriteCervezas[indexPath.row].nombre
            cell.lbEstilo.text = favoriteCervezas[indexPath.row].estilo
            let foto = photoFromURL(urlString: favoriteCervezas[indexPath.row].fotoURL)
            cell.imgFoto.image = foto
        } else if searchActive {
            cell.lbNombre.text = filteredCervezas[indexPath.row].nombre
            cell.lbEstilo.text = filteredCervezas[indexPath.row].estilo
            let foto = photoFromURL(urlString: filteredCervezas[indexPath.row].fotoURL)
            cell.imgFoto.image = foto
        } else {
            cell.lbNombre.text = cervezas[indexPath.row].nombre
            cell.lbEstilo.text = cervezas[indexPath.row].estilo
            let foto = photoFromURL(urlString: cervezas[indexPath.row].fotoURL)
            cell.imgFoto.image = foto
        }
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "BeerDetail" {
            let vista = segue.destination as! BeerDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            var actualList = [Cerveza]()
            if verFavoritos && searchActive {
                actualList = filteredCervezas
            } else if verFavoritos {
                actualList = favoriteCervezas
            } else if searchActive {
                actualList = filteredCervezas
            } else {
                actualList = cervezas
            }
            
            vista.nombre = actualList[indexPath.row].nombre
            vista.estilo = actualList[indexPath.row].estilo
            vista.cerveceria = actualList[indexPath.row].cerveceria
            vista.origen = actualList[indexPath.row].origen
            vista.abv = actualList[indexPath.row].abv
            vista.ibu = actualList[indexPath.row].ibu
            vista.srm = actualList[indexPath.row].srm
            vista.fotourl = actualList[indexPath.row].fotoURL
            let foto = photoFromURL(urlString: actualList[indexPath.row].fotoURL)
            vista.foto = foto
            vista.isFavorite = actualList[indexPath.row].isFavorite
            vista.inDiary = actualList[indexPath.row].inDiary
        } else {
            let vista = segue.destination as! FilterViewController
            vista.delegado = self
            searchActive = true
        }
    }
    
    @IBAction func unwindFilter(unwindSegue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    // MARK: - FilterOptions protocol
    func filter(estilo: String, cerveceria: String, origen: String, abvIndex: Int, ibuIndex: Int, srmIndex: Int) {
        if verFavoritos {
            filteredCervezas = favoriteCervezas
        } else {
            filteredCervezas = cervezas
        }
        
        if (estilo != "") {
            filteredCervezas = filteredCervezas.filter( { (cerveza) -> Bool in
                cerveza.estilo.lowercased().elementsEqual(estilo.lowercased())
            })
        }
        if (cerveceria != "") {
            filteredCervezas = filteredCervezas.filter( { (cerveza) -> Bool in
                cerveza.cerveceria.lowercased().elementsEqual(cerveceria.lowercased())
            })
        }
        if (origen != "") {
            filteredCervezas = filteredCervezas.filter( { (cerveza) -> Bool in
                cerveza.origen.lowercased().elementsEqual(origen.lowercased())
            })
        }
        
        if (abvIndex != 0) {
            filteredCervezas = filteredCervezas.filter( { (cerveza) -> Bool in
                var fABV = Float(-1)
                if (cerveza.abv != "-") {
                    fABV = Float(cerveza.abv)!
                }
                
                if (abvIndex == 1) {
                    return (fABV >= 0 && fABV <= 3.9)
                } else if (abvIndex == 5) {
                    return (fABV >= 10)
                } else {
                    let val = Float(abvIndex) * 2
                    return (fABV >= val && fABV < val + 2)
                }
            })
        }
        
        if (ibuIndex != 0) {
            filteredCervezas = filteredCervezas.filter( { (cerveza) -> Bool in
                var fIBU = Float(-1)
                if (cerveza.ibu != "-") {
                    fIBU = Float(cerveza.ibu)!
                }
                if (ibuIndex == 6) {
                    return (fIBU >= 100)
                } else {
                    let val = Float(ibuIndex) * 20
                    return (fIBU >= val - 20 && fIBU < val)
                }
            })
        }
        
        if (srmIndex != 0) {
            filteredCervezas = filteredCervezas.filter( { (cerveza) -> Bool in
                var fSRM = Float(-1)
                if (cerveza.srm != "-") {
                    fSRM = Float(cerveza.srm)!
                }
                let val = Float(srmIndex) * 10
                return (fSRM >= val - 10 && fSRM < val)
            })
        }
        
        searchActive = true
        self.tableView.reloadData()
    }
    
    func setUsedFilters(key: String, values: [Any]) {
        usedFilters[key] = values
    }
    
    func getUsedFilters() -> [String : [Any]] {
        return usedFilters
    }
    
    func getEstilos() -> Set<String> {
        var estilos = Set<String>()
        for cerveza in cervezas {
            estilos.insert(cerveza.estilo)
        }
        return estilos
    }
    
    func getCervecerias() -> Set<String> {
        var cervecerias = Set<String>()
        for cerveza in cervezas {
            cervecerias.insert(cerveza.cerveceria)
        }
        return cervecerias
    }
    
    func getOrigenes() -> Set<String> {
        var origenes = Set<String>()
        for cerveza in cervezas {
            origenes.insert(cerveza.origen)
        }
        return origenes
    }
    
    //MARK - Autorotate
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
