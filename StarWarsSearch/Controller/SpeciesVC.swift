//
//  SpeciesVC.swift
//  StarWarsSearch
//
//  Created by Zach Cervi on 2/9/19.
//  Copyright © 2019 Zach Cervi. All rights reserved.
//

import UIKit

class SpeciesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    //variables
    var species: [Species]?
    var speciesWrapper: SpeciesWrapper?
    var isLoading = false
    
    
    //outlets
    @IBOutlet weak var speciesTableView: UITableView!
    @IBOutlet weak var speciesText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        speciesTableView.delegate = self
        speciesTableView.dataSource = self
        
        loadSpecies()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.species == nil {
            
            return 0
        }
        return self.species!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = speciesTableView.dequeueReusableCell(withIdentifier: "speciesCell") as? SpeciesCell else {return UITableViewCell()}
        
        if let species = species, species.count >= indexPath.row {
            if species.count > 0 {
             let speciesToShow = species[indexPath.row]
               cell.configureCell(text: speciesToShow.name!)
                
            }
        }
        
        return cell
    }
    
    let minHeight: CGFloat = 100.0
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var temp: CGFloat = 0.0
        let tHeight = speciesTableView.bounds.height
        if(species!.count > 0){
             temp = tHeight/CGFloat((species?.count)!)
        }
        return temp > minHeight ? temp: minHeight
    }
    
    func loadSpecies(){
        isLoading = true
        Species.getSpecies { (result) in
            if let error = result.error {
                self.isLoading = false
                print("Could not load species. Error \(error)")
            }
            let speciesWrapper = result.value
            self.addSpeciesFromWrapper(speciesWrapper)
            self.isLoading = false
            self.speciesTableView?.reloadData()
        }
    }
    
    func addSpeciesFromWrapper(_ wrapper: SpeciesWrapper?) {
        self.speciesWrapper = wrapper
        if self.species == nil {
            self.species = self.speciesWrapper?.species
        } else if self.speciesWrapper != nil && self.speciesWrapper!.species != nil {
            self.species = self.species! + self.speciesWrapper!.species!
        }
    }
    
}
