//
//  PlansCell.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-22.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class PlansCell: UITableViewCell {
  
  lazy var containerView : UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.clipsToBounds = true
    view.layer.cornerRadius = 10
    view.addSubview(stackView)
    view.addSubview(planImageView)
    return view
  }()
  
  let planNameLabel : UILabel = {
    let label = UILabel()
    label.text = "plan1"
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let planDescriptionLabel : UILabel = {
    let label = UILabel()
    label.text = "description"
    label.font = .systemFont(ofSize: 14)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    return label
  }()
  
  let planPriceLabel : UILabel = {
    let label = UILabel()
    label.text = "$5"
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .red
    return label
  }()
  
  lazy var stackView : UIStackView = {
    let sv = UIStackView(arrangedSubviews: [planNameLabel,planDescriptionLabel,planPriceLabel])
    sv.distribution = .fill
    sv.axis = .vertical
    sv.spacing = 8
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  let planImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 30
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    
    self.contentView.addSubview(containerView)
    self.backgroundColor = UIColor(red: 0/255, green: 181.0/255, blue: 204.0/255, alpha: 1.0)
    
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
      containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
      
      planImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0),
      planImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
      planImageView.heightAnchor.constraint(equalToConstant: 60),
      planImageView.widthAnchor.constraint(equalToConstant: 60),
      
      stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: planImageView.leadingAnchor, constant: -8),
      stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
    
      planNameLabel.heightAnchor.constraint(equalToConstant: 30),
      planDescriptionLabel.heightAnchor.constraint(equalToConstant: 40),
      planPriceLabel.heightAnchor.constraint(equalToConstant: 30)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
