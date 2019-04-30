//
//  DiaryDetailViewController.swift
//  Cervezologia
//
//  Created by Diego Martinez on 4/24/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit
import iOSDropDown

class DiaryDetailViewController: UIViewController {
    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfEstilo: UITextField!
    @IBOutlet weak var tfOrigen: UITextField!
    @IBOutlet weak var tfCerveceria: UITextField!
    @IBOutlet weak var tfSRM: UITextField!
    @IBOutlet weak var tfIBU: UITextField!
    @IBOutlet weak var tfABV: UITextField!
    @IBOutlet weak var tfLugar: UITextField!
    @IBOutlet weak var ddAlmacenamiento: DropDown!
    @IBOutlet weak var tvNotas: UITextView!
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vista: UIView!
    
    var cervezaActual : CervezaDiario!
    
    var nombre : String = ""
    var estilo : String = ""
    var cerveceria : String = ""
    var origen : String = ""
    var abv : String = ""
    var ibu : String = ""
    var srm : String = ""
    var lugar : String = ""
    var almacenamiento : String = ""
    var notas : String = ""
    var fotourl : String = ""
    var foto : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        cervezaActual = CervezaDiario(nombre: nombre, estilo: estilo, cerveceria: cerveceria, origen: origen, abv: abv, ibu: ibu, srm: srm, lugar: lugar, almacenamiento: almacenamiento, notas: notas, fotoURL: fotourl)
        
        scrollView.contentSize = vista.frame.size
        
        ddAlmacenamiento.optionArray = ["", "Botella", "Lata", "Barril"]
        ddAlmacenamiento.selectedRowColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        ddAlmacenamiento.arrowSize = 12
        ddAlmacenamiento.isSearchEnable = false
        
        tfNombre.text = nombre
        tfEstilo.text = estilo
        tfCerveceria.text = cerveceria
        tfOrigen.text = origen
        tfABV.text = abv
        tfIBU.text = ibu
        tfSRM.text = srm
        tfLugar.text = lugar
        ddAlmacenamiento.text = almacenamiento
        tvNotas.text = notas
        imgFoto.image = foto
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vistaAnt = segue.destination as! DiarioTableViewController
        let nom = tfNombre.text!
        let est = tfEstilo.text!
        let cerv = tfCerveceria.text!
        let orig = tfOrigen.text!
        let ABV = tfABV.text!
        let IBU = tfIBU.text!
        let SRM = tfSRM.text!
        let lug = tfLugar.text!
        let alm = ddAlmacenamiento.text!
        let not = tvNotas.text!
        let cerveza = CervezaDiario(nombre: nom, estilo: est, cerveceria: cerv, origen: orig, abv: ABV, ibu: IBU, srm: SRM, lugar: lug, almacenamiento: alm, notas: not, fotoURL: fotourl)
        vistaAnt.cervezasDiario[vistaAnt.celdaActiva] = cerveza
        vistaAnt.storeBeerDiary()
    }
    

}
