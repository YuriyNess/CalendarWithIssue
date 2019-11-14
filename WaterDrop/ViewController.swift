//
//  ViewController.swift
//  WaterDrop
//
//  Created by YuriyFpc on 11/12/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cv = CalendarView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cv)
        cv.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cv.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 290).isActive = true
    }


}
