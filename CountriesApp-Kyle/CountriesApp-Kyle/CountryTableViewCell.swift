//
//  CountryTableViewCell.swift
//  CountriesApp-Kyle
//
//  Created by Kyle-Anthony Hay on 10/25/23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var thumbnailView: UIImageView
    var titleLabel: UILabel
    var subtitleLabel: UILabel
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        self.thumbnailView = UIImageView()
        self.titleLabel = UILabel()
        self.subtitleLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(self.thumbnailView)
        contentView.addSubview(self.titleLabel)
        contentView.addSubview(self.subtitleLabel)
        
        self.setUpConstraints()
    }
    
    // function for setting up constraints
    
    private func setUpConstraints(){
        let topPadding = 5.0
                let bottomPadding = 5.0
                let leadingPadding = 15.0
                let trailingPadding = 15.0
                let spacingBetweenLabelsAndThumbnail = 10.0

                // [H: --- 15 --- thumbnailView --- 10 --- titleLabel ---- ]
                // [H: --- 15 --- thumbnailView --- 10 --- subtitleLabel ---- ]
                // [V: --- 5 --- thumbnailView --- 5 ---]
                // [V: --- 5 --- titleLabel (3/4 contentView size) --- subtitleLabel --- 5 ---]

                thumbnailView.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

                thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingPadding).isActive = true
                thumbnailView.heightAnchor.constraint(equalTo: contentView.heightAnchor,
                                                      constant: -(topPadding + bottomPadding)).isActive = true
                thumbnailView.widthAnchor.constraint(equalTo: thumbnailView.heightAnchor).isActive = true

                titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor,
                                                    constant: spacingBetweenLabelsAndThumbnail).isActive = true
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -trailingPadding).isActive = true
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding).isActive = true
                let remainingHeight = contentView.frame.height - (topPadding + bottomPadding)
                titleLabel.heightAnchor.constraint(equalToConstant: remainingHeight * 3.0 / 4.0).isActive = true


                subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -trailingPadding).isActive = true
                subtitleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor,
                                                       constant: spacingBetweenLabelsAndThumbnail).isActive = true
                subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomPadding).isActive = true
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
