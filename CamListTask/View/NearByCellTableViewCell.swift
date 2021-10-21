//
//  NearByCellTableViewCell.swift
//  CamListTask
//
//  Created by mohamed salah on 10/21/21.
//

import UIKit

class NearByCellTableViewCell: UITableViewCell {
   static let idenetifier = "NearByCellTableViewCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.black
        label.text = ""
        label.textAlignment = .justified
     
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.gray
        label.text = ""
        label.textAlignment = .justified
     
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    func buildUI(){
        self.backgroundColor  = UIColor.white
        self.selectionStyle = .none
        self.addSubview(nameLabel)
        self.addSubview(addressLabel)
        nameLabel.setConstraints(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor , paddingTop: 10, paddingLeading: 16,paddingTrailing: 16)
        addressLabel.setConstraints(top: nameLabel.bottomAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor , paddingTop: 10, paddingBottom: 10, paddingLeading: 16,paddingTrailing: 16)
    }

    func setupData(model: Item){
        nameLabel.text = model.venue?.name
        addressLabel.text = model.venue?.location?.address
    }

}
