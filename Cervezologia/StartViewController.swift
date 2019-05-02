//
//  StartViewController.swift
//  Cervezologia
//
//  Created by Linetes on 5/2/19.
//  Copyright © 2019 Diego Martinez. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var transition = SKTransition.fadeWithDuration(5)
        
        self.view?.presentScene(yourScene, transition: transition)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
