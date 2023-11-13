//
//  BannerTableViewCell.swift
//  CountriesApp-Kyle
//
//  Created by Kyle-Anthony Hay on 11/13/23.
//

import UIKit

protocol BannerTableViewCellDelegate {
    func requestLayoutUpdate()

}

class BannerTableViewCell: UITableViewCell {
    
    var delagate: BannerTableViewCellDelegate?
    
    private var widthConstraint: NSLayoutConstraint {
            bannerImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: imageSize.width)
        }

    private var heightConstraint: NSLayoutConstraint {
        bannerImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: imageSize.height)
    }

    private var imageSize: CGSize {
        bannerImageView.image?.size ?? CGSize(width: 280, height: 160)
    }
    
    init(reuseIdentifier: String?){
        self.bannerImageView = UIImageView()
        self.bannerImageView.contentMode = .scaleAspectFit
        self.bannerImageView.layer.masksToBounds = true
        self.bannerImageView.layer.cornerRadius = 15
        self.bannerImageView.layer.borderWidth = 0.5
        self.bannerImageView.layer.borderColor = UIColor.gray.cgColor
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.layer.masksToBounds = true
        self.contentView.addSubview(self.bannerImageView)
        
        setUpConstraints()
    }
    
    //set up constraints
    func setUpConstraints(){
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heightConstraint,
            widthConstraint
        ])
    }
    
    func loadImage(url: URL){
        bannerImageView.loadImage(url: url) {
            self.widthConstraint.constant = self.imageSize.width
            self.heightConstraint.constant = self.imageSize.height
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.delagate?.requestLayoutUpdate()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let bannerImageView: UIImageView

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
