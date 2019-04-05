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
    
    var estilo = ""
    var cerveceria = ""
    var origen = ""
    var abvIdx = 0
    var ibuIdx = 0
    var srmIdx = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDropDowns()
        
        ddEstilo.didSelect { (text, index, id) in
            self.estilo = text
        }
        ddCerveceria.didSelect { (text, index, id) in
            self.cerveceria = text
        }
        ddOrigen.didSelect { (text, index, id) in
            self.origen = text
        }
        ddABV.didSelect { (text, index, id) in
            self.abvIdx = index
        }
        ddIBU.didSelect { (text, index, id) in
            self.ibuIdx = index
        }
        ddSRM.didSelect { (text, index, id) in
            self.srmIdx = index
        }
        
    }
    
    func initDropDowns() {
        
        let lightGray = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        
        //estilo
        ddEstilo.optionArray = [""] + Array(delegado.getEstilos())
        ddEstilo.selectedIndex = 0
        ddEstilo.selectedRowColor = lightGray
        ddEstilo.arrowSize = 12
        //cerveceria
        ddCerveceria.optionArray = [""] + Array(delegado.getCervecerias())
        ddCerveceria.selectedIndex = 0
        ddCerveceria.selectedRowColor = lightGray
        ddCerveceria.arrowSize = 12
        //origen
        ddOrigen.optionArray = [""] + Array(delegado.getOrigenes())
        ddOrigen.selectedIndex = 0
        ddOrigen.selectedRowColor = lightGray
        ddOrigen.arrowSize = 12
        //ABV
        ddABV.optionArray = ["", "0-4", "4-6", "6-8", "8-10", "> 10"]
        ddABV.selectedIndex = 0
        ddABV.selectedRowColor = lightGray
        ddABV.arrowSize = 12
        ddABV.isSearchEnable = false
        //IBU
        ddIBU.optionArray = ["", "0-20", "20-40", "40-60", "60-80", "80-100", "> 100"]
        ddIBU.selectedIndex = 0
        ddIBU.selectedRowColor = lightGray
        ddIBU.arrowSize = 12
        ddIBU.isSearchEnable = false
        //SRM
        ddSRM.optionArray = ["", "0-10", "10-20", "20-30", "30-40"]
        ddSRM.selectedIndex = 0
        ddSRM.selectedRowColor = lightGray
        ddSRM.arrowSize = 12
        ddSRM.isSearchEnable = false
    }
    
    @IBAction func limpiarFiltros(_ sender: UIButton) {
        //estilo
        ddEstilo.selectedIndex = 0
        ddEstilo.text = ""
        //cerveceria
        ddCerveceria.selectedIndex = 0
        ddCerveceria.text = ""
        //origen
        ddOrigen.selectedIndex = 0
        ddOrigen.text = ""
        //ABV
        ddABV.selectedIndex = 0
        ddABV.text = ""
        //IBU
        ddIBU.selectedIndex = 0
        ddIBU.text = ""
        //SRM
        ddSRM.selectedIndex = 0
        ddSRM.text = ""
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let vista = segue.destination as! TableViewController
        
        if (sender as! UIButton) == btAplicar {
            self.delegado.filter(estilo: estilo, cerveceria: cerveceria, origen: origen, abvIndex: abvIdx, ibuIndex: ibuIdx, srmIndex: srmIdx)
        } else {
            vista.searchActive = false
            vista.searchBar.text = ""
        }
    }
}
