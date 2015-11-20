//
//  ViewController.swift
//  FakePokeDex
//
//  Created by Justin on 11/18/15.
//  Copyright © 2015 Justin. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    var pokemon = [Pokemon]()
    var inSearchMode = false
    var filteredPokemon = [Pokemon]()

    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        parsePokemonCSV()
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        
    }


    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows

            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    //MARK: Collection view protocol methods
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            
            var poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            }else{
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            return cell
            
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return filteredPokemon.count
        }
        
        return pokemon.count
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    //MARK: Search View protocol methods
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        
        }else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
            
            
            
        }

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
  

}