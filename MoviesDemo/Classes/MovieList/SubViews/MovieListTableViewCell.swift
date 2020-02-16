//
//  MovieListTableViewCell.swift
//  MoviesDemo
//
//  Created by Prabhu on 15/02/20.
//  Copyright © 2020 tringapps. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    static let reuseID = "MovieListTableViewCell"
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var plotLabel: UILabel!
    @IBOutlet weak private var posterImageView: UIImageView!
    
    private var cellViewModel: MovieListCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setViewModel(_ model: MovieListCellViewModel) {
        cellViewModel = model
        updateImageAfterDownload()
        updateText()
    }
    
    private func updateImageAfterDownload() {
        cellViewModel?.update = { [weak self] image in
            DispatchQueue.main.async {
                self?.posterImageView.image = image
            }
        }
    }
    
    private func updateText() {
        nameLabel.text = cellViewModel?.name
        genreLabel.text = cellViewModel?.genre
        plotLabel.text = cellViewModel?.plot
        posterImageView.image = cellViewModel?.posterImage
    }
    
}
