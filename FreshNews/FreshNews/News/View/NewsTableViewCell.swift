//
//  NewsTableViewCell.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 26.12.20.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var isOpened = false
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.font = UIFont.systemFont(ofSize: 14)
        detailsLabel.textColor = .label
        detailsLabel.numberOfLines = 0
        return detailsLabel
    }()
    
    private lazy var additionalInfoLabel: UILabel = {
        let additionalInfoLabel = UILabel()
        additionalInfoLabel.font = UIFont.systemFont(ofSize: 12)
        additionalInfoLabel.textColor = .systemGray
        additionalInfoLabel.textAlignment = .right
        return additionalInfoLabel
    }()
    
    private enum CellConstants {
        static let imageViewSide = 60
        static let standartOffset: CGFloat = 5
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(additionalInfoLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let xOffset: CGFloat = layoutMargins.left
        let vOffset: CGFloat = layoutMargins.top
        
        
        newsImageView.frame = CGRect(origin: CGPoint(x: xOffset, y: vOffset),
                                     size: CGSize(width: CellConstants.imageViewSide, height: CellConstants.imageViewSide))
        
        
        let labelsWidh: CGFloat = contentView.bounds.width - xOffset*3 - newsImageView.frame.width
        let labelsCalcSize = CGSize(width: labelsWidh,
                                    height: CGFloat.greatestFiniteMagnitude)
        
        let titleSize = titleLabel.sizeThatFits(labelsCalcSize)
        titleLabel.frame = CGRect(x: newsImageView.frame.maxX + xOffset,
                                  y: vOffset,
                                  width: labelsWidh,
                                  height: titleSize.height)
        
        let sourceHeight = additionalInfoLabel.sizeThatFits(labelsCalcSize).height
        var sourceLabelY = max(newsImageView.frame.maxY - sourceHeight,
                               titleLabel.frame.maxY + CellConstants.standartOffset)
        
        if isOpened {
            detailsLabel.isHidden = false
            let detailsSize = detailsLabel.sizeThatFits(labelsCalcSize)
            detailsLabel.frame = CGRect(x: titleLabel.frame.minX,
                                        y: titleLabel.frame.maxY + CellConstants.standartOffset,
                                        width: labelsWidh,
                                        height: detailsSize.height)
            
            sourceLabelY = detailsLabel.frame.maxY + CellConstants.standartOffset
        } else {
            detailsLabel.isHidden = true
        }
        
        additionalInfoLabel.frame = CGRect(x: titleLabel.frame.minX,
                                 y: sourceLabelY,
                                 width: labelsWidh,
                                 height: sourceHeight)
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.bounds = CGRect(origin: .zero, size: size)
        layoutIfNeeded()
        
        return CGSize(width: size.width,
                      height: additionalInfoLabel.frame.maxY + CellConstants.standartOffset)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        titleLabel.text = nil
        detailsLabel.text = nil
        additionalInfoLabel.text = nil
    }
    
    func fill(with newsItem: NewsItem) {
        titleLabel.text = newsItem.title
        detailsLabel.text = newsItem.description
        additionalInfoLabel.text = "\(newsItem.sourceName)  \(newsItem.date.newsFormat) "
        if newsItem.isRead {
            additionalInfoLabel.text?.append("✓")
        }
        if let imageURL = newsItem.imageURL {
            DispatchQueue.global().async {
                self.getImage(at: imageURL) { (image) in
                    DispatchQueue.main.async {
                        self.newsImageView.image = image
                    }
                }
            }

        }
    }
    
    func getImage(at url: URL, completion: (UIImage?) -> Void) {
        guard let data = try? Data(contentsOf: url),
              let image = UIImage(data: data)
        else {
            completion(nil)
            return
        }
        completion(image)
    }
}
