//
//  SpeciesCell.swift
//  StarWarsSearch
//
//  Created by Zach Cervi on 2/9/19.
//  Copyright © 2019 Zach Cervi. All rights reserved.
//

import UIKit

class SpeciesCell: UITableViewCell {


    @IBOutlet weak var speciesLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(text: String) {
        self.speciesLbl.text = text
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
