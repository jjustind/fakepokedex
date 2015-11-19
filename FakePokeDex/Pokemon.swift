//
//  Pokemon.swift
//  FakePokeDex
//
//  Created by Justin on 11/18/15.
//  Copyright © 2015 Justin. All rights reserved.
//

import Foundation


class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int){
        _name = name
        _pokedexId = pokedexId
    }
    
    
}