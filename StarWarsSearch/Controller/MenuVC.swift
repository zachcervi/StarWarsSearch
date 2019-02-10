//
//  MenuVC.swift
//  
//
//  Created by Zach Cervi on 2/9/19.
//

import UIKit

class MenuVC: UITableViewController {

    
    var resources = Resources.resources
    var names = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Resources.resources.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "menuCell") as? MenuCell else {return UITableViewCell()}
       cell.configureCell(text: resources[indexPath.item])
        return cell
    }
    
    let minHeight: CGFloat = 100.0
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tHeight = self.tableView.bounds.height
        let temp = tHeight/CGFloat(resources.count)
        
        return temp > minHeight ? temp: minHeight
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            performSegue(withIdentifier: TO_PEOPLE, sender: nil)
        }else if (indexPath.row == 4){
            performSegue(withIdentifier: TO_SPECIES, sender: nil)
        }
    }

}
