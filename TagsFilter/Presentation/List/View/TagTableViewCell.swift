//
//  TagTableViewCell.swift
//  TagsFilter
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import UIKit

class TagTableViewCell: UITableViewCell {
    static let identifier = "TagTableViewCell"
    
    @IBOutlet weak var answersCountLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var userNameLabelLabel: UILabel!
    @IBOutlet weak var reputationCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with tag: TagItemViewModel) {
        self.answersCountLabel.text = tag.answersCount
        self.viewsCountLabel.text = tag.viewsCount
        self.questionTitleLabel.text = tag.questionTitle
        self.userNameLabelLabel.text = tag.username
        self.reputationCountLabel.text = tag.reputation
    }
}
