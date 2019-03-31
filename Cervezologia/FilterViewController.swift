//
//  FilterViewController.swift
//  Cervezologia
//
//  Created by Diego Martinez on 3/30/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit
import iOSDropDown

protocol poblateFilterDropDowns {
    func getEstilos() -> Set<String>
    func getCervecerias() -> Set<String>
    func getOrigenes() -> Set<String>
}

class FilterViewController: UIViewController {
    
    var delegado : poblateFilterDropDowns!
    
    //determina si los filtros seran aplicados o no
    var limpio = true
    
    @IBOutlet weak var btCancelar: UIButton!
    @IBOutlet weak var btAplicar: UIButton!
    
    @IBOutlet weak var ddEstilo: DropDown!
    @IBOutlet weak var ddCerveceria: DropDown!
    @IBOutlet weak var ddOrigen: DropDown!
    @IBOutlet weak var ddABV: DropDown!
    @IBOutlet weak var ddIBU: DropDown!
    @IBOutlet weak var ddSRM: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDropDowns()
        
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
        ddIBU.optionArray = ["", "0-20", "20-40", "40-60", "60-80", "80-100"]
        ddIBU.selectedRowColor = lightGray
        ddIBU.arrowSize = 12
        ddIBU.isSearchEnable = false
        //SRM
        ddSRM.optionArray = ["", "0-10", "10-20", "20-30", "30-40"]
        ddSRM.selectedRowColor = lightGray
        ddSRM.arrowSize = 12
        ddSRM.isSearchEnable = false
    }
    
    @IBAction func usedFilter(_ sender: DropDown) {
        limpio = false
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
        
        limpio = true
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let vista = segue.destination as!
        TableViewController
        if (sender as! UIButton) == btAplicar {
            if limpio {
                vista.searchActive = false
                vista.searchBar.text = ""
            } else {
                //APLICAR FILTROS
            }
        } else {
            vista.searchActive = false
            vista.searchBar.text = ""
        }
    }
 

}
