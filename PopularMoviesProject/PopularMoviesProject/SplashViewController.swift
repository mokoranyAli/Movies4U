//
//  SplashViewController.swift
//  PopularMoviesProject
//
//  Created by jets on 7/26/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        perform(#selector(go), with: self, afterDelay: 3)
    }

  
    

    func go(){
    performSegue(withIdentifier: "splashID", sender: self)
    }
}
