//
//  ViewController.swift
//  StarWarsSearch
//
//  Created by Zach Cervi on 2/8/19.
//  Copyright © 2019 Zach Cervi. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var MenuTV: UITableView!
    var resources = Resources.resources
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MenuTV.delegate = self
        self.MenuTV.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Resources.resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.MenuTV.dequeueReusableCell(withIdentifier: "resource") as? MenuCell else {return UITableViewCell()}
        
        cell.configureCell(text: resources[indexPath.item])
        return cell
    }
    let minHeight: CGFloat = 100.0
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tHeight = MenuTV.bounds.height
        let temp = tHeight/CGFloat(resources.count)
        
        return temp > minHeight ? temp: minHeight
    }
   
    
}

