//
//  ViewController.swift
//  Cervezologia
//
//  Created by Linetes on 3/25/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbEstilo: UILabel!
    @IBOutlet weak var lbCerveceria: UILabel!
    @IBOutlet weak var lbOrigen: UILabel!
    @IBOutlet weak var lbAbv: UILabel!
    @IBOutlet weak var lbIbu: UILabel!
    @IBOutlet weak var lbSrm: UILabel!
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var btFavorito: UIButton!
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btDiary: UIButton!
    
    var cervezaActual : Cerveza!
    
    var nombre : String = ""
    var estilo : String = ""
    var cerveceria : String = ""
    var origen : String = ""
    var abv : String = ""
    var ibu : String = ""
    var srm : String = ""
    var fotourl : String = ""
    var foto : UIImage?
    var isFavorite : Bool = false
    var inDiary : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        cervezaActual = Cerveza(nombre: nombre, estilo: estilo, cerveceria: cerveceria, origen: origen, abv: abv, ibu: ibu, srm: srm, fotoURL: fotourl)
        
        scrollView.contentSize = vista.frame.size
        
        lbNombre.text = nombre
        lbEstilo.text = estilo
        lbCerveceria.text = cerveceria
        lbOrigen.text = origen
        lbAbv.text = abv
        lbIbu.text = ibu
        lbSrm.text = srm
        imgFoto.image = foto
        
        if isFavorite {
            UIView.animate(withDuration: 0.25) { self.btFavorito.setImage(UIImage(named: "starFilled"), for: .normal) }
        } else {
            UIView.animate(withDuration: 0.25) { self.btFavorito.setImage(UIImage(named: "star"), for: .normal) }
        }
        
        if inDiary {
            btDiary.isEnabled = false
            btDiary.isHidden = true
        } else {
            btDiary.isEnabled = true
            btDiary.isHidden = false
        }
        
    }
    
    @IBAction func btListaDeInteres(_ sender: UIButton) {
        let count = (self.navigationController?.viewControllers.count)!
        let tableViewCtrl = self.navigationController?.viewControllers[count - 2] as! TableViewController
        
        let index = tableViewCtrl.cervezas.firstIndex { (cerveza) -> Bool in
            cerveza.nombre == cervezaActual.nombre
        }
        
        if sender.image(for: .normal) == UIImage(named: "star") {
            sender.setImage(UIImage(named: "starFilled"), for: .normal)
            cervezaActual.isFavorite = true
            tableViewCtrl.favoriteCervezas.append(cervezaActual)
            tableViewCtrl.cervezas[index!].isFavorite = true
            tableViewCtrl.storeFavorites()
        } else {
            sender.setImage(UIImage(named: "star"), for: .normal)
            tableViewCtrl.favoriteCervezas = tableViewCtrl.favoriteCervezas.filter({ (cerveza) -> Bool in
                cerveza.nombre != cervezaActual.nombre
            })
            tableViewCtrl.cervezas[index!].isFavorite = false
            tableViewCtrl.tableView.reloadData()
            if tableViewCtrl.favoriteCervezas.count > 0 {
                tableViewCtrl.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            tableViewCtrl.storeFavorites()
        }
    }
    
    @IBAction func btAddToDiary(_ sender: UIButton) {
        btDiary.isHidden = true
        btDiary.isEnabled = false
        
        let count = (self.navigationController?.viewControllers.count)!
        let tableViewCtrl = self.navigationController?.viewControllers[count - 2] as! TableViewController
        
        let index = tableViewCtrl.cervezas.firstIndex { (cerveza) -> Bool in
            cerveza.nombre == cervezaActual.nombre
        }
        
        tableViewCtrl.cervezas[index!].inDiary = true
        cervezaActual.inDiary = true
        tableViewCtrl.diarioVC.addToDiary(cerv: cervezaActual)
        tableViewCtrl.diarioVC.selectLastRow()
        navigationController?.popViewController(animated: true)
        self.tabBarController?.selectedIndex = 2
    }
    
    //MARK - Autorotate
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
