//
//  ExTableViewHeaderView.swift
//  CMAccordionTableView_Example
//
//  Created by Junghoon on 2018. 2. 9..
//  Copyright © 2018년 CocoaPods. All rights reserved.
//

import UIKit
import CMAccordionTableView

class ExTableViewHeaderView: CMTableViewHeaderView {

    
    @IBOutlet weak var arrowLabel: UILabel!
    
    override func openHeaderViewStatus() {
        self.arrowLabel.text = "Open Status"
    }
    
    override func closeHeaderViewStatus() {
        self.arrowLabel.text = "Close Status"        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

}
