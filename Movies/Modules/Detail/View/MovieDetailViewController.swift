//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {

@IBOutlet weak var bannerImageView: UIImageView!
@IBOutlet weak var titleLabel: UILabel!
@IBOutlet weak var dateLabel: UILabel!
@IBOutlet weak var detailTextView: UITextView!
var movieDetailViewOutput: MovieDetailViewOutput?
private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMM yyyy"
  return formatter
}()
  
override func viewDidLoad() {
  super.viewDidLoad()
  movieDetailViewOutput?.didTriggerViewReadyEvent()
}

}

extension MovieDetailViewController: MovieDetailViewInput {
func showErrorMessage(errorMessage: String) {
  
}
func showMovie(movie: Movie) {
  titleLabel.text = movie.title
  if let releaseDate = movie.releaseDate {
    dateLabel.text = dateFormatter.string(from: releaseDate)
  }
  detailTextView.text = movie.overview
  movieDetailViewOutput?.loadMovieImage(movie: movie) { data in
    guard let data = data,
      let image = UIImage(data: data) else { return }
    DispatchQueue.main.async {
      self.bannerImageView.contentMode = .scaleAspectFill
      self.bannerImageView.image = image
    }
  }
}
}
