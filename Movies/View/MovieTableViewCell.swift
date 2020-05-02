//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {

@IBOutlet weak var bannerImageView: UIImageView!
@IBOutlet weak var nameLabel: UILabel!
@IBOutlet weak var dateLabel: UILabel!
  
override func awakeFromNib() {
  super.awakeFromNib()
  bannerImageView.layer.cornerRadius = 10
}
}
