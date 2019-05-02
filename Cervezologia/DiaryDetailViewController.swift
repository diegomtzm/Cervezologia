//
//  DiaryDetailViewController.swift
//  Cervezologia
//
//  Created by Diego Martinez on 4/24/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit
import iOSDropDown

class DiaryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    @IBOutlet weak var btGuardar: UIButton!
    @IBOutlet weak var Guardar: UIButton!
    
    var cervezaActual : CervezaDiario!
    
    var nombre : String = " "
    var estilo : String = ""
    var cerveceria : String = ""
    var origen : String = ""
    var abv : String = ""
    var ibu : String = ""
    var srm : String = ""
    var lugar : String = ""
    var almacenamiento : String = ""
    var notas : String = ""
    var foto : UIImage = UIImage(named: "cerveza")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btGuardar.layer.cornerRadius = 4
        Guardar.layer.cornerRadius = 4

        cervezaActual = CervezaDiario(nombre: nombre, estilo: estilo, cerveceria: cerveceria, origen: origen, abv: abv, ibu: ibu, srm: srm, lugar: lugar, almacenamiento: almacenamiento, notas: notas, foto: foto)
        
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
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    //MARK - Image Picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgFoto.image = selectedImage
        if picker.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(imgFoto.image!, nil, nil, nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loadPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have a camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access photo library.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        let fot = imgFoto.image!
        let cerveza = CervezaDiario(nombre: nom, estilo: est, cerveceria: cerv, origen: orig, abv: ABV, ibu: IBU, srm: SRM, lugar: lug, almacenamiento: alm, notas: not, foto: fot)
        vistaAnt.cervezasDiario[vistaAnt.celdaActiva] = cerveza
        vistaAnt.backTapped = false
        vistaAnt.storeBeerDiary()
    }
    

}
