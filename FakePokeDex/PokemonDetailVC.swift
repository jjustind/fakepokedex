//
//  PokemonDetailVC.swift
//  FakePokeDex
//
//  Created by Justin on 11/21/15.
//  Copyright © 2015 Justin. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
        
    }

}
