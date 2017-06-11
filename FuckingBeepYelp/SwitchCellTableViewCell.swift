//
//  SwitchCellTableViewCell.swift
//  FuckingBeepYelp
//
//  Created by Taku Tran on 6/8/17.
//  Copyright © 2017 Taku Tran. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwitchCellTableViewCell, didChangeValue value: Bool)
}

class SwitchCellTableViewCell: UITableViewCell {

    @IBOutlet var switcher: UISwitch!
    
    @IBOutlet var switcherLabel: UILabel!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        switcher.addTarget(self, action: #selector(SwitchCellTableViewCell.switchValueChanged), for: UIControlEvents.valueChanged)
        
        // Initialization code
    }

    func switchValueChanged() {
        print("test")
        delegate?.switchCell!(switchCell: self, didChangeValue: switcher.isOn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
