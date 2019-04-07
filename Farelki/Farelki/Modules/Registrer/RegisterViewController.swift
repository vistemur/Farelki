//
//  RegisterViewController.swift
//  Farelki
//
//  Created by роман поздняков on 07/04/2019.
//  Copyright © 2019 romchick. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PersistanceService.firstEntry = true
    }
}
