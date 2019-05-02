//
//  CervezaDiario.swift
//  Cervezologia
//
//  Created by Diego Martinez on 4/24/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit

class CervezaDiario: Codable {
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("diarioCervecero.plist")
    
    var nombre : String = ""
    var estilo : String = ""
    var cerveceria : String = ""
    var origen : String = ""
    var abv : String = ""
    var ibu : String = ""
    var srm : String = ""
    var lugar: String = ""
    var almacenamiento: String = ""
    var notas: String = ""
    var foto : UIImage
    
    init() {
        self.nombre = ""
        self.estilo = ""
        self.cerveceria = ""
        self.origen = ""
        self.abv = ""
        self.ibu = ""
        self.srm = ""
        self.lugar = ""
        self.almacenamiento = ""
        self.notas = ""
        self.foto = UIImage(named: "cerveza")!
    }
    
    init(nombre : String, estilo : String, cerveceria : String, origen : String, abv : String, ibu : String, srm : String, lugar : String, almacenamiento : String, notas : String, foto : UIImage) {
        self.nombre = nombre
        self.estilo = estilo
        self.cerveceria = cerveceria
        self.origen = origen
        self.abv = abv
        self.ibu = ibu
        self.srm = srm
        self.lugar = lugar
        self.almacenamiento = almacenamiento
        self.notas = notas
        self.foto = foto
    }
    
    enum CodingKeys: String, CodingKey {
        case nombre
        case estilo
        case cerveceria
        case origen
        case abv
        case ibu
        case srm
        case lugar
        case almacenamiento
        case notas
        case foto
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nombre, forKey: .nombre)
        try container.encode(estilo, forKey: .estilo)
        try container.encode(cerveceria, forKey: .cerveceria)
        try container.encode(origen, forKey: .origen)
        try container.encode(abv, forKey: .abv)
        try container.encode(ibu, forKey: .ibu)
        try container.encode(srm, forKey: .srm)
        try container.encode(lugar, forKey: .lugar)
        try container.encode(almacenamiento, forKey: .almacenamiento)
        try container.encode(notas, forKey: .notas)
        let dataDeFoto = foto.jpegData(compressionQuality: 0.8)
        try container.encode(dataDeFoto, forKey: .foto)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nombre = try container.decode(String.self, forKey: .nombre)
        estilo = try container.decode(String.self, forKey: .estilo)
        cerveceria = try container.decode(String.self, forKey: .cerveceria)
        origen = try container.decode(String.self, forKey: .origen)
        abv = try container.decode(String.self, forKey: .abv)
        ibu = try container.decode(String.self, forKey: .ibu)
        srm = try container.decode(String.self, forKey: .srm)
        lugar = try container.decode(String.self, forKey: .lugar)
        almacenamiento = try container.decode(String.self, forKey: .almacenamiento)
        notas = try container.decode(String.self, forKey: .notas)
       
        let dataDeFoto = try container.decode(Data.self, forKey: .foto)
        foto = UIImage(data: dataDeFoto)!
    }
}
