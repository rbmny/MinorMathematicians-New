//
//  LaunchVC.swift
//  Minor Mathematicians New
//
//  Created by Ricardo Aguiar Bomeny on 03/03/20.
//  Copyright © 2020 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    let developedLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.text = "Developed by Ricardo Bomeny"
        lbl.isHidden = true
        lbl.textColor = .white
        lbl.font = UIFont(name: "Avenir-Book", size: 22)
        lbl.textAlignment = .center
        lbl.backgroundColor = .clear
        
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.view.addSubview(developedLbl)
        
        developedLbl.translatesAutoresizingMaskIntoConstraints = false
        developedLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        developedLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100).isActive = true
        
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(showLbl), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextSegue), userInfo: nil, repeats: false)
        
        
    }
    @objc func showLbl() {
        developedLbl.isHidden = false
    }
    @objc func nextSegue() {
        performSegue(withIdentifier: "MainSegue", sender: nil)
    }
    
}
