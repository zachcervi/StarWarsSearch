//
//  PeopleVC.swift
//  StarWarsSearch
//
//  Created by Zach Cervi on 2/8/19.
//  Copyright © 2019 Zach Cervi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PeopleVC: UITableViewController {

    var rowCount: Int = 0
    var names = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PEOPLE_URL)
        getPeople(url: PEOPLE_URL)
        
    }

  
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "peopleCell") as? PeopleCell else {
            return UITableViewCell()
        }
      cell.configureCell(name: names[indexPath.item])
        return cell
    }
    
    let minHeight: CGFloat = 100.0
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tHeight = self.tableView.bounds.height
        let temp = tHeight/CGFloat(rowCount)
        
        return temp > minHeight ? temp: minHeight
    }
    
    func getPeople(url: String){
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                let peopleJSON: JSON = JSON(response.result.value!)
                self.updatePeople(json: peopleJSON)
            } else {
                print("ERROR \(String(describing: response.result.error))")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //JSON parsing
    func updatePeople(json: JSON){
        rowCount = json["results"].count
        for item in json["results"].arrayValue{
            let name = item["name"].stringValue
            names.append(name)
          
        }
        
    }
 }
