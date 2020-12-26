//
//  NewsTableViewCell.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 26.12.20.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    private var isOpened = false
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
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
        detailsLabel.textColor = .label
        return detailsLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .label
        dateLabel.textAlignment = .right
        return dateLabel
    }()
    
    private lazy var isReadLabel: UILabel = {
        let isReadLabel = UILabel()
        return isReadLabel
    }()
    
    private enum CellConstants {
        static let imageViewSide = 40
        static let standartOffset: CGFloat = 5
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(isReadLabel)
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
        
        let sourceHeight = dateLabel.sizeThatFits(labelsCalcSize).height
        var sourceLabelY = max(newsImageView.frame.maxY - sourceHeight,
                               titleLabel.frame.maxY + CellConstants.standartOffset)
        
        if isOpened {
            detailsLabel.isHidden = false
            let detailsSize = detailsLabel.sizeThatFits(labelsCalcSize)
            detailsLabel.frame = CGRect(x: titleLabel.frame.minX,
                                        y: detailsLabel.frame.maxY + CellConstants.standartOffset,
                                        width: labelsWidh,
                                        height: detailsSize.height)
            
            sourceLabelY = detailsLabel.frame.maxY + CellConstants.standartOffset
        } else {
            detailsLabel.isHidden = true
        }
        
        dateLabel.frame = CGRect(x: titleLabel.frame.minX,
                                 y: sourceLabelY,
                                 width: labelsWidh,
                                 height: sourceHeight)
        
        isReadLabel.frame = CGRect(x: dateLabel.frame.minX,
                                   y: dateLabel.frame.maxY + CellConstants.standartOffset,
                                   width: labelsWidh,
                                   height: isReadLabel.sizeThatFits(labelsCalcSize).height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.bounds = CGRect(origin: .zero, size: size)
        layoutIfNeeded()
        
        return CGSize(width: size.width,
                      height: isReadLabel.frame.maxY + CellConstants.standartOffset)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        titleLabel.text = nil
        detailsLabel.text = nil
        dateLabel.text = nil
        isReadLabel.text = nil
    }
    
    func fill(with newsItem: NewsItem) {
        titleLabel.text = newsItem.title
        detailsLabel.text = newsItem.description
    }
}
