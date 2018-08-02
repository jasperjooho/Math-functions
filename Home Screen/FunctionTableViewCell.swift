//
//  FunctionTableViewCell.swift
//  Math functions
//
//  Created by user on 18/11/17.
//  Copyright © 2017 Obsearch Applications. All rights reserved.
//

import UIKit

class FunctionTableViewCell: UITableViewCell {

    var label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        self.backgroundColor = .black
        self.contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
    
    func createLabel() {
        
        // Set up contraints and fonts for the label
        
        let height = self.contentView.frame.height
        let width = self.contentView.frame.width

        label.font = UIFont.boldSystemFont(ofSize: height / 4)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        let labelHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height / 2)
        let labelWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width - width / 4)
        let labelTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: height / 4)
        let labelLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: width / 10)
        self.contentView.addConstraints([labelTopConstraint, labelLeftConstraint])
        label.addConstraints([labelWidthConstraint, labelHeightConstraint])
        
    }

}
