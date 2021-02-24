//
//  TokenMemoTableViewCell.swift
//  TokenMemo
//
//  Created by 이현호 on 2020/12/03.
//

import UIKit

class TokenMemoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .darkText
        cellContentView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(for item: MemoItem) {
        iconImageView.image = UIImage(named: "mappin.and.ellipse")
        iconImageView.tintColor = .secondaryLabel
        
        titleLabel.text = item.title
    }
    
}
