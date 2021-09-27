//
//  CustomTableViewCell.swift
//  customTableViewCell
//
//  Created by Shashwat on 27/09/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "customTableViewCell"
    
    var label:UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style:UITableViewCell.CellStyle,reuseIdentifier reuseidentifier:String?){
        super.init(style: style, reuseIdentifier: reuseidentifier)
        contentView.addSubview(label)
        contentView.backgroundColor = .systemGreen
    }
    
    override func layoutSubviews() {
        label.frame = CGRect(x: 5, y: 5, width: contentView.frame.width-20, height: contentView.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
