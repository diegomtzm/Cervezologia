//
//  Cerveza.swift
//  Cervezologia
//
//  Created by Linetes on 3/25/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit

class Cerveza : NSObject {
    
    var nombre : String = ""
    var estilo : String = ""
    var cerveceria : String = ""
    var origen : String = ""
    var abv : String = ""
    var ibu : String = ""
    var srm : String = ""
    var foto : UIImage?
    
    init(nombre : String, estilo : String, cerveceria : String, origen : String, abv : String, ibu : String, srm : String, foto : UIImage?) {
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

