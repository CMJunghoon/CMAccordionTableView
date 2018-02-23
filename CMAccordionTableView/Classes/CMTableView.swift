//
//  CMTableView.swift
//  Pods
//
//  Created by Junghoon on 2018. 1. 30..
//


import UIKit



public class SectionInfo: NSObject {
    
    public var isOpen: Bool!
    public var rowOfNumber : Int = 0
    
}

public class CMTableView : UITableView {
    
    public var completionBlock: (() -> Void)?
    
    /**
     The object that acts as the delegate of the table view.
     The delegate must adopt the CMTableViewDataSource protocol.
     */
    public var cmDataSource : CMTableViewDataSource? {
        didSet {
            self.dataSource = self
        }
        
    }
    
    /**
     The object that acts as the delegate of the table view.
     The delegate must adopt the CMTableViewDelegate protocol.
     */
    public var cmDelegate : CMTableViewDelegate? {
        didSet {
            self.delegate = self
        }
    }
    
    /** Section and Row count */
    public static var sectionInfo =  [SectionInfo]()
    
    public static var expandedSectionHeaderNumber  = -1
    public var isFoldingPreviousCell = true
    
    
    public func cmRegister(_ nib: UINib?, forHeaderFooterViewReuseIdentifier identifier: String) {
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

/** TableView HeaderView Touch Event */
public extension CMTableView {
    
    /** All open of cell */
    func expandableAllCell()  {
        guard self.isFoldingPreviousCell == false  else { return }
        guard let sectionCount = self.cmDataSource?.numberOfSections(in: self) else { return }
        
        for i in 0..<sectionCount {
            let info = CMTableView.sectionInfo[i]
            let headerView = self.cmDelegate?.tableView!(self, viewForHeaderInSection: i) as? CMTableViewHeaderView
            if info.isOpen == false {
                openHeader(headerView: headerView!, section: i)
            }
        }
        
    }
    
    /** All close of cell */
    func collapsibleAllCell()  {
        guard let sectionCount = self.cmDataSource?.numberOfSections(in: self) else { return }
        
        for i in 0..<sectionCount {
            
            let info = CMTableView.sectionInfo[i]
            let headerView = self.cmDelegate?.tableView!(self, viewForHeaderInSection: i) as? CMTableViewHeaderView
            if info.isOpen == true {
                closeHeader(headerView: headerView!, section: i)
            }
        }
    }
    
}


extension CMTableView : CMTableViewHeaderViewDelegate {
    
    func headerView(sectionOpened: CMTableViewHeaderView, section: NSInteger) {
        openHeader(headerView: sectionOpened, section: section)
    }
    
    
    func headerView(sectionClosed: CMTableViewHeaderView, section: NSInteger) {
        closeHeader(headerView: sectionClosed, section: section)
    }
    
    
    
    
    
    func openHeader(headerView: CMTableViewHeaderView, section: NSInteger ) {
        var arrayOfIndexPaths = [IndexPath]()
        let rowIndexCount = self.cmDataSource!.tableView(self, numberOfRowsInSection: section)
        
        if rowIndexCount == 0 {
            CMTableView.expandedSectionHeaderNumber = -1
            return
        }
        
        for i in 0..<rowIndexCount {
            let indexPath = IndexPath(row: i, section: section)
            arrayOfIndexPaths.append(indexPath)
        }
        
        CMTableView.sectionInfo[section].isOpen = true
        CMTableView.expandedSectionHeaderNumber = section
        
//        for info in 0..<CMTableView.sectionInfo.count {
//            if info == section {
//                //                self.cmDelegate?.tableView!(self, headerView: headerView, openForHeaderInSection: section)
//            } else {
//
//            }
//
//            if CMTableView.sectionInfo[info].isOpen {
//                self.cmDelegate?.tableView!(self, headerView: headerView, openForHeaderInSection: section)
//            } else {
//                let headerView = self.cmDelegate?.tableView!(self, viewForHeaderInSection: info, isOpen: false) as? CMTableViewHeaderView
//
//            }
//        }
        
        
        
        self.beginUpdates()
        self.cmDelegate?.tableView!(self, headerView: headerView, openForHeaderInSection: section)
//        self.reloadSections(IndexSet(integersIn: section...section ), with: .none)
        self.insertRows(at: arrayOfIndexPaths, with: .automatic)
        self.endUpdates()
        headerView.openHeaderViewStatus()
    }
    
    func closeHeader(headerView: CMTableViewHeaderView, section: NSInteger) {
        
        CMTableView.expandedSectionHeaderNumber = -1
        
        let rowindexCount = self.cmDataSource!.tableView(self, numberOfRowsInSection: section)
        var arrayOfIndexPaths = [IndexPath]()
        
        for i in 0..<rowindexCount {
            let indexPath = IndexPath(row: i, section: section)
            arrayOfIndexPaths.append(indexPath)
        }
        
        CMTableView.sectionInfo[section].isOpen = false
        self.beginUpdates()
        
//        for info in 0..<CMTableView.sectionInfo.count {
//
//            if CMTableView.sectionInfo[info].isOpen {
//                self.cmDelegate?.tableView!(self, headerView: headerView, openForHeaderInSection: info)
//            } else {
//                let headerView = self.cmDelegate?.tableView!(self, viewForHeaderInSection: info, isOpen: false) as? CMTableViewHeaderView
//                self.cmDelegate?.tableView!(self, headerView: headerView!, closeForHeaderInSection: info)
//            }
//
//            if info == section {
//
//            } else {
//
//            }
//        }
        
        self.cmDelegate?.tableView!(self, headerView: headerView, closeForHeaderInSection: section)
        self.deleteRows(at: arrayOfIndexPaths, with: .automatic)
        self.endUpdates()
        headerView.closeHeaderViewStatus()
        
    }
    
    
}


extension CMTableView : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: true)
        self.cmDelegate?.tableView(self, didSelectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //        let headerView = self.cmDelegate?.tableView!(self, viewForHeaderInSection: section) as? CMTableViewHeaderView
        let headerView : CMTableViewHeaderView?
        let sectionInfo = CMTableView.sectionInfo[section]
        
        
        if sectionInfo.isOpen {
            headerView = self.cmDelegate?.tableView!(self, viewForHeaderInSection: section, isOpen: true) as? CMTableViewHeaderView
        } else {
            headerView = self.cmDelegate?.tableView!(self, viewForHeaderInSection: section, isOpen: false) as? CMTableViewHeaderView
        }
        headerView?.tag = section
        headerView?.isFoldingPreviousCell = isFoldingPreviousCell
        headerView?.delegateHV = self
        
        return headerView
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cmDelegate!.tableView(self, heightForRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionInfo = CMTableView.sectionInfo[section]
        
        if sectionInfo.isOpen {
            return (self.cmDelegate?.tableView!(self, heightForHeaderInSection: section, openStatus: true))!
        } else {
            return (self.cmDelegate?.tableView!(self, heightForHeaderInSection: section, openStatus: false))!
        }
        
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.cmDelegate!.tableView(self, heightForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.cmDelegate!.tableView(self, viewForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.cmDelegate!.tableView(self, didDeselectRowAt: indexPath)
    }
    
    
}

extension CMTableView : UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        let sections = self.cmDataSource!.numberOfSections(in: self)
        
        if CMTableView.sectionInfo.count == 0 {
            
            for section in 0..<sections {
                let initRowOfNumber = self.cmDataSource!.tableView(self, numberOfRowsInSection: section)
                let info = SectionInfo()
                
                info.isOpen = false
                info.rowOfNumber = initRowOfNumber
                
                CMTableView.sectionInfo.append(info)
            }
            
        }
        return sections
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cmDataSource!.tableView(self, cellForRowAt: indexPath)
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = CMTableView.sectionInfo[section]
        let expandedSectionHeaderNumber = CMTableView.expandedSectionHeaderNumber
        if expandedSectionHeaderNumber == section || sectionInfo.isOpen {
            return sectionInfo.rowOfNumber
        } else {
            return 0
        }
        
    }
    
}

extension UIAlertController {
    
    class func showJustAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert )
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        let uia = UIAlertController()
        uia.getTopViewController().present(alert, animated: true, completion: nil)
    }
    
    private func getTopViewController() -> UIViewController {
        
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        
        return topController!
        
    }
    
}

extension UIColor {
    
    public func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let bule = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: bule, alpha: 1)
    }
    
    
    
}
