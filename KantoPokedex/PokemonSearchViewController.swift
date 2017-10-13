//
//  PokemonSearchViewController.swift
//  KantoPokedex
//
//  Created by Dante  Lacey-Thompson on 10/11/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class PokemonSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var refresher: UIRefreshControl!
    
    var pokemonList = [Pokemon]()
    var filteredPokemonList = [Pokemon]()
    var inSearchMode = false
    
    
//    var data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
//                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
//                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
//                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
//                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
//    
//    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.tintColor = UIColor.blue
        refresher.addTarget(self, action: #selector(refreshPokemonData), for: .valueChanged)
        tableView.addSubview(refresher)
//      filteredData = data
        parsePokeCSV()
        pokemonList.sort(by: {$0.pkname < $1.pkname})
        filteredPokemonList = pokemonList
        self.navigationItem.title = "Kanto Pokemon Search"
    }
    
    func parsePokeCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows{
                let pokeID = Int(row["id"]!)!
                let pokeName = row["identifier"]!
                print(pokeID, pokeName)
                let pokemon = Pokemon(name: pokeName, id: pokeID)
                pokemonList.append(pokemon)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // MARK: - RefresherSelector
    func refreshPokemonData(_ sender: Any?){
        print("getting complete list in refresh")
        self.searchBar.text = ""
        filteredPokemonList = pokemonList.sorted(by: {$0.pkname < $1.pkname})
        self.tableView.reloadData()
        refresher.endRefreshing()
    }
    
    
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        //need searchBar implementation here
//        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
        }
        else{
            inSearchMode = true
            let search = searchBar.text?.lowercased()
            filteredPokemonList = pokemonList.filter({$0.pkname.range(of: search!) != nil
            })
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    //MARK: UItableViewDelegate,UItableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell {
            cell.configCell(pokemon:  inSearchMode ? filteredPokemonList[indexPath.row]: pokemonList[indexPath.row])
            return cell
        }
        else{
            return UITableViewCell()
        }
//        cell.textLabel?.text = filteredPokemonList[indexPath.row].pkname
//        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredPokemonList.count
        return inSearchMode ? filteredPokemonList.count: pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let indexPath = tableView.indexPathForSelectedRow
//        let currentCell = tableView.cellForRow(at: indexPath!)
//        guard let currentCellText = currentCell?.textLabel?.text else{
//            return
//        }
//        print(currentCellText)
        var searchedPokemon: Pokemon!
        searchedPokemon = inSearchMode ? filteredPokemonList[indexPath.row]: pokemonList[indexPath.row]
        performSegue(withIdentifier: "ShowPokemonDetailsSegue", sender: searchedPokemon)
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonDetailsSegue" {
            if let pokeDetailsVC = segue.destination as? PokeDetailsViewController{
                if let searchPoke = sender as? Pokemon{
                    pokeDetailsVC.poke = searchPoke
                }
            }
        }
    }
    
}
