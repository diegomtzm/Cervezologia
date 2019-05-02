//
//  FilterViewController.swift
//  Cervezologia
//
//  Created by Diego Martinez on 3/30/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit
import iOSDropDown

protocol FilterOptions {
    func getEstilos() -> Set<String>
    func getCervecerias() -> Set<String>
    func getOrigenes() -> Set<String>
    func getUsedFilters() -> [String: [Any]]
    func setUsedFilters(key: String, values: [Any])
    func filter(estilo: String, cerveceria: String, origen: String, abvIndex: Int, ibuIndex: Int, srmIndex: Int)
}

class FilterViewController: UIViewController {
    
    var delegado : FilterOptions!
    
    @IBOutlet weak var btCancelar: UIButton!
    @IBOutlet weak var btAplicar: UIButton!
    
    @IBOutlet weak var ddEstilo: DropDown!
    @IBOutlet weak var ddCerveceria: DropDown!
    @IBOutlet weak var ddOrigen: DropDown!
    @IBOutlet weak var ddABV: DropDown!
    @IBOutlet weak var ddIBU: DropDown!
    @IBOutlet weak var ddSRM: DropDown!
    
    //[key: [text, index]]
    var usedFilters : [String: [Any]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDropDowns()
        btAplicar.layer.cornerRadius = 4
        btCancelar.layer.cornerRadius = 4
        
        ddEstilo.didSelect { (text, index, id) in
            self.delegado.setUsedFilters(key: "estilo", values: [text, index])
        }
        ddCerveceria.didSelect { (text, index, id) in
            self.delegado.setUsedFilters(key: "cerveceria", values: [text, index])
        }
        ddOrigen.didSelect { (text, index, id) in
            self.delegado.setUsedFilters(key: "origen", values: [text, index])
        }
        ddABV.didSelect { (text, index, id) in
            self.delegado.setUsedFilters(key: "abv", values: [text, index])
        }
        ddIBU.didSelect { (text, index, id) in
            self.delegado.setUsedFilters(key: "ibu", values: [text, index])
        }
        ddSRM.didSelect { (text, index, id) in
            self.delegado.setUsedFilters(key: "srm", values: [text, index])
        }
        
    }
    
    func preselectFilterOptions () {
        usedFilters = delegado.getUsedFilters()
        //estilo
        ddEstilo.selectedIndex = usedFilters["estilo"]?[1] as? Int
        ddEstilo.text = usedFilters["estilo"]?[0] as? String
        //cerveceria
        ddCerveceria.selectedIndex = usedFilters["cerveceria"]?[1] as? Int
        ddCerveceria.text = usedFilters["cerveceria"]?[0] as? String
        //origen
        ddOrigen.selectedIndex = usedFilters["origen"]?[1] as? Int
        ddOrigen.text = usedFilters["origen"]?[0] as? String
        //ABV
        ddABV.selectedIndex = usedFilters["abv"]?[1] as? Int
        ddABV.text = usedFilters["abv"]?[0] as? String
        //IBU
        ddIBU.selectedIndex = usedFilters["ibu"]?[1] as? Int
        ddIBU.text = usedFilters["ibu"]?[0] as? String
        //SRM
        ddSRM.selectedIndex = usedFilters["srm"]?[1] as? Int
        ddSRM.text = usedFilters["srm"]?[0] as? String
    }
    
    func initDropDowns() {
        
        let lightGray = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        
        //estilo
        ddEstilo.optionArray = [""] + Array(delegado.getEstilos())
        ddEstilo.selectedRowColor = lightGray
        ddEstilo.arrowSize = 12
        //cerveceria
        ddCerveceria.optionArray = [""] + Array(delegado.getCervecerias())
        ddCerveceria.selectedRowColor = lightGray
        ddCerveceria.arrowSize = 12
        //origen
        ddOrigen.optionArray = [""] + Array(delegado.getOrigenes())
        ddOrigen.selectedRowColor = lightGray
        ddOrigen.arrowSize = 12
        //ABV
        ddABV.optionArray = ["", "0-4", "4-6", "6-8", "8-10", "> 10"]
        ddABV.selectedRowColor = lightGray
        ddABV.arrowSize = 12
        ddABV.isSearchEnable = false
        //IBU
        ddIBU.optionArray = ["", "0-20", "20-40", "40-60", "60-80", "80-100", "> 100"]
        ddIBU.selectedRowColor = lightGray
        ddIBU.arrowSize = 12
        ddIBU.isSearchEnable = false
        //SRM
        ddSRM.optionArray = ["", "0-10", "10-20", "20-30", "30-40"]
        ddSRM.selectedRowColor = lightGray
        ddSRM.arrowSize = 12
        ddSRM.isSearchEnable = false
        
        preselectFilterOptions()
    }
    
    @IBAction func limpiarFiltros(_ sender: UIButton) {
        let arr = ["estilo", "cerveceria", "origen", "abv", "ibu", "srm"]
        for k in arr {
            self.delegado.setUsedFilters(key: k, values: ["", 0])
        }
        preselectFilterOptions()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let vista = segue.destination as! TableViewController
        
        if (sender as! UIButton) == btAplicar {
            usedFilters = self.delegado.getUsedFilters()
            let estilo = usedFilters["estilo"]?[0] as! String
            let cerveceria = usedFilters["cerveceria"]?[0] as! String
            let origen = usedFilters["origen"]?[0] as! String
            let abvIdx = usedFilters["abv"]?[1] as! Int
            let ibuIdx = usedFilters["ibu"]?[1] as! Int
            let srmIdx = usedFilters["srm"]?[1] as! Int
            self.delegado.filter(estilo: estilo, cerveceria: cerveceria, origen: origen, abvIndex: abvIdx, ibuIndex: ibuIdx, srmIndex: srmIdx)
            vista.verFavoritos = false
            vista.btFavorites.image = UIImage(named: "star-small")
        } else {
            limpiarFiltros(btCancelar)
            vista.searchActive = false
            vista.searchBar.text = ""
        }
    }
    
    //MARK - Autorotate
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
