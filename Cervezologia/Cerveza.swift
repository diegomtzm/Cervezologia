//
//  Cerveza.swift
//  Cervezologia
//
//  Created by Linetes on 3/25/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit

class Cerveza : Codable {
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("listaFavoritos.plist")
    
    var nombre : String = ""
    var estilo : String = ""
    var cerveceria : String = ""
    var origen : String = ""
    var abv : String = ""
    var ibu : String = ""
    var srm : String = ""
    var fotoURL : String = ""
    var isFavorite : Bool = false
    var inDiary : Bool = false
    
    init(nombre : String, estilo : String, cerveceria : String, origen : String, abv : String, ibu : String, srm : String, fotoURL : String) {
        self.nombre = nombre
        self.estilo = estilo
        self.cerveceria = cerveceria
        self.origen = origen
        self.abv = abv
        self.ibu = ibu
        self.srm = srm
        self.fotoURL = fotoURL
    }
    
    enum CodingKeys: String, CodingKey {
        case nombre
        case estilo
        case cerveceria
        case origen
        case abv
        case ibu
        case srm
        case fotoURL
        case isFavorite
        case inDiary
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
        try container.encode(fotoURL, forKey: .fotoURL)
        try container.encode(isFavorite, forKey: .isFavorite)
        try container.encode(inDiary, forKey: .inDiary)
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
        fotoURL = try container.decode(String.self, forKey: .fotoURL)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        inDiary = try container.decode(Bool.self, forKey: .inDiary)
    }
}

