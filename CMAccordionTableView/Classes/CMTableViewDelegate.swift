//
//  CMTableViewDelegate.swift
//  Pods
//
//  Created by Junghoon on 2018. 1. 30..
//
//

import UIKit

@objc public protocol CMTableViewDelegate: NSObjectProtocol {
    
    
//    @objc optional func tableView(_ tableView: CMTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    @objc optional func tableView(_ tableView: CMTableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    @objc optional func tableView(_ tableView: CMTableView, willDisplayFooterView view: UIView, forSection section: Int)
//    @objc optional func tableView(_ tableView: CMTableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    @objc optional func tableView(_ tableView: CMTableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
//    @objc optional func tableView(_ tableView: CMTableView, didEndDisplayingFooterView view: UIView, forSection section: Int)

    @objc optional func tableView(_ tableView: CMTableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    @objc optional func tableView(_ tableView: CMTableView, heightForHeaderInSection section: Int, openStatus open: Bool) -> CGFloat
    
    @objc optional func tableView(_ tableView: CMTableView, heightForFooterInSection section: Int) -> CGFloat
    
//    @objc optional func tableView(_ tableView: CMTableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
//    @objc optional func tableView(_ tableView: CMTableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
//    @objc optional func tableView(_ tableView: CMTableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    
    @objc optional func tableView(_ tableView: CMTableView, viewForHeaderInSection section: Int) -> UIView?
    
    @objc optional func tableView(_ tableView: CMTableView, viewForHeaderInSection section: Int, isOpen open: Bool) -> UIView?

    @objc optional func tableView(_ tableView: CMTableView, headerView: CMTableViewHeaderView, openForHeaderInSection section: Int)
    @objc optional func tableView(_ tableView: CMTableView, headerView: CMTableViewHeaderView, closeForHeaderInSection section: Int)
    
    @objc optional func tableView(_ tableView: CMTableView, viewForFooterInSection section: Int) -> UIView? // custom view for footer. will be adjusted to default or
//    @objc optional func tableView(_ tableView: CMTableView, accessoryButtonTappedForRowWith indexPath: IndexPath)

//    @objc optional func tableView(_ tableView: CMTableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
//    @objc optional func tableView(_ tableView: CMTableView, didHighlightRowAt indexPath: IndexPath)
//    @objc optional func tableView(_ tableView: CMTableView, didUnhighlightRowAt indexPath: IndexPath)
//    
//    @objc optional func tableView(_ tableView: CMTableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
//    @objc optional func tableView(_ tableView: CMTableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    
    @objc optional func tableView(_ tableView: CMTableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: CMTableView, didDeselectRowAt indexPath: IndexPath)
    
//    @objc optional func tableView(_ tableView: CMTableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
//    @objc optional func tableView(_ tableView: CMTableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
//    @objc optional func tableView(_ tableView: CMTableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
//    @objc optional func tableView(_ tableView: CMTableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    
//    @objc optional func tableView(_ tableView: CMTableView, willBeginEditingRowAt indexPath: IndexPath)
//    @objc optional func tableView(_ tableView: CMTableView, didEndEditingRowAt indexPath: IndexPath?)
    
//    @objc optional func tableView(_ tableView: CMTableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
//    @objc optional func tableView(_ tableView: CMTableView, indentationLevelForRowAt indexPath: IndexPath) -> Int // return 'depth' of row for hierarchies
//    @objc optional func tableView(_ tableView: CMTableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
//    @objc optional func tableView(_ tableView: CMTableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
//    @objc optional func tableView(_ tableView: CMTableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)

    
}

extension CMTableViewDelegate {
    
    
    
    func tableView(_ tableView: CMTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: CMTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: CMTableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
//    func tableView(_ tableView: CMTableView, heightForHeaderInSection section: Int, openStatus open: Bool) -> CGFloat {
//        return 0
//    }
    
    func tableView(_ tableView: CMTableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: CMTableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: CMTableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    

    
    
}
