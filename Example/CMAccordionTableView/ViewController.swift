//
//  ViewController.swift
//  CMAccordionTableView
//
//  Created by CMJunghoon on 01/30/2018.
//  Copyright (c) 2018 CMJunghoon. All rights reserved.
//

import UIKit
import CMAccordionTableView


class ViewController: UIViewController {
    

    var cmTableView : CMTableView!
    var expandedButton : UIButton = UIButton(type: UIButtonType.system)
    var collapsedButton : UIButton = UIButton(type: UIButtonType.system)
    var foldingSwitch : UISwitch = UISwitch(frame: CGRect(x: UIScreen.main.bounds.size.width/2 - 20, y: 10, width: 40, height: 40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let cgf = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height - 50)
        cmTableView = CMTableView(frame: cgf, style: .grouped)
        self.view.addSubview(cmTableView)
        
        cmTableView.cmDelegate = self
        cmTableView.cmDataSource = self
        
        
        foldingSwitch.isOn = true
        self.view.addSubview(foldingSwitch)
        foldingSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        self.expandedButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        self.expandedButton.backgroundColor = .blue
        self.expandedButton.setTitle("Open", for: .normal)
        self.expandedButton.setTitleColor(.red , for: .normal)
        
        self.expandedButton.addTarget(self, action: #selector(allOpen(sender:)), for: .touchUpInside)
        self.view.addSubview(expandedButton)
        
        
        self.collapsedButton.frame = CGRect(x: UIScreen.main.bounds.size.width - 100, y: 0 , width: 100, height: 50)
        self.collapsedButton.backgroundColor = .blue
        self.collapsedButton.setTitle("Close", for: .normal)
        self.collapsedButton.setTitleColor(.red , for: .normal)
        
        self.collapsedButton.addTarget(self, action: #selector(allClose(sender:)), for: .touchUpInside)
        self.view.addSubview(collapsedButton)
        
        let headerNib = UINib(nibName: "ExTableViewHeaderView", bundle: nil)
        cmTableView.cmRegister(headerNib, forHeaderFooterViewReuseIdentifier: "ExTableViewHeaderView")

    }
    
    func switchChanged()  {
        
        if foldingSwitch.isOn {
            cmTableView.isFoldingPreviousCell = true
        } else {
            cmTableView.isFoldingPreviousCell = false
        }        
        cmTableView.collapsibleAllCell()
    }
    
    
    func allOpen(sender : UIButton)  {
        cmTableView.expandableAllCell()
    }
    
    
    func allClose(sender : UIButton)  {
        cmTableView.collapsibleAllCell()
    }

}

extension ViewController : CMTableViewDataSource {
    
    func tableView(_ tableView: CMTableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: CMTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: CMTableView) -> Int {
        return 3
    }
}


extension ViewController : CMTableViewDelegate {
 
    func tableView(_ tableView: CMTableView, viewForHeaderInSection section: Int, isOpen open: Bool) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExTableViewHeaderView") as? ExTableViewHeaderView
        let headerView = UIView(frame: (header?.bounds)!)
        headerView.backgroundColor = UIColor().randomColor()
        header?.backgroundView = headerView
        
        if open {
            header?.openHeaderViewStatus()
        } else {
            header?.closeHeaderViewStatus()
        }
        
        return header
        
    }
    
//    func tableView(_ tableView: CMTableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExTableViewHeaderView") as? ExTableViewHeaderView
//        let headerView = UIView(frame: (header?.bounds)!)
//        headerView.backgroundColor = UIColor().randomColor()
//        header?.backgroundView = headerView
//
//        return header
//
//    }
    
    func tableView(_ tableView: CMTableView, headerView: CMTableViewHeaderView, openForHeaderInSection section: Int) {
        
        let header = headerView as? ExTableViewHeaderView
        header?.openHeaderViewStatus()
        
    }
    
    func tableView(_ tableView: CMTableView, headerView: CMTableViewHeaderView, closeForHeaderInSection section: Int) {
        
        let header = headerView as? ExTableViewHeaderView
        header?.closeHeaderViewStatus()
    }
    
    
    func tableView(_ tableView: CMTableView, heightForHeaderInSection section: Int, openStatus open: Bool) -> CGFloat {
        
        if open {
            return 200
        } else {
            return 44
        }
        
    }

}
