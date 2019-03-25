//
//  Cerveza.swift
//  
//
//  Created by Diego Martinez on 3/25/19.
//

import UIKit

class Cerveza: NSObject {
    
    var nombre : String
    var estilo : String
    var cerveceria : String
    var origen : String
    var abv : Int
    var ibu : Int
    var srm : Int
    var foto : UIImage!
    
    init(nombre : String, estilo : String, cerveceria : String, origen : String, abv : Int, ibu : Int, srm : Int, foto : UIImage!) {
        self.nombre = nombre
        self.estilo = estilo
        self.cerveceria = cerveceria
        self.origen = origen
        self.abv = abv
        self.ibu = ibu
        self.srm = srm
        self.foto = foto
    }

}
