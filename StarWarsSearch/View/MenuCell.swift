//
//  MenuCell.swift
//  StarWarsSearch
//
//  Created by Zach Cervi on 2/8/19.
//  Copyright © 2019 Zach Cervi. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuOptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(text: String){
        menuOptionLbl.text = text
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
