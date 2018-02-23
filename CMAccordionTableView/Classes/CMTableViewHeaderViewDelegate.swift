//
//  CMTableVieHeaderViewDelegate.swift
//  Pods
//
//  Created by Junghoon on 2018. 1. 30..
//
//

import UIKit



protocol CMTableViewHeaderViewDelegate : NSObjectProtocol{
    
    func headerView(sectionOpened: CMTableViewHeaderView,section : Int)
    func headerView(sectionClosed: CMTableViewHeaderView,section : Int)
    
}

open class CMTableViewHeaderView: UITableViewHeaderFooterView {
    

    var tapGesture : UITapGestureRecognizer?
    var sectionInfo : SectionInfo!
    var section : Int!
    weak var delegateHV : CMTableViewHeaderViewDelegate?
    
    /**
     How to previousCell ( close or open )
     * True : Frist tap is cell open / second tap is open after frist cell.
     * False : Frist tap is cell open / second tap is open ( frist cell open status )
     */
    public var isFoldingPreviousCell = true
    
    
    
    open override func awakeFromNib() {
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    func commonInit()  {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        self.addGestureRecognizer(tapGesture!)
    }
    
    
    open func openHeaderViewStatus() {
        
    }
    
    open func closeHeaderViewStatus() {
        
    }
    
    /**
     UITapGestureRecognizer Event
     
     * If it is folded, you can open it by touching on the tab.
     * And it can reverse.
     
     - Parameter gesture: TapGesture
     
     */
    func headerTapped(_ sender : UITapGestureRecognizer) {
        
        let selectedSection = sender.view?.tag
        let sectionBool = CMTableView.sectionInfo[selectedSection!]
        var expandedSectionHeaderNumber = CMTableView.expandedSectionHeaderNumber
        
        if  self.isFoldingPreviousCell {
        
            if expandedSectionHeaderNumber == -1 {
                expandedSectionHeaderNumber = selectedSection!
                self.delegateHV?.headerView(sectionOpened: self, section: selectedSection!)
            
            } else {
                
                if expandedSectionHeaderNumber == selectedSection {
                    self.delegateHV?.headerView(sectionClosed: self, section: selectedSection!)
                    
                } else {
                    self.delegateHV?.headerView(sectionClosed: self, section: expandedSectionHeaderNumber)
                    self.delegateHV?.headerView(sectionOpened: self, section: selectedSection!)
                }
            }
            
        } else {
            if sectionBool.isOpen {
                self.delegateHV?.headerView(sectionClosed: self, section: selectedSection!)
            } else {
                self.delegateHV?.headerView(sectionOpened: self, section: selectedSection!)
            }
            
        }
        
    }

}

