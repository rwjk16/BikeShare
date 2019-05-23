//
//  FavoritesCell.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-23.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

  let nameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(nameLabel)
  
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
