//
//  CMTableViewDataSource.swift
//  Pods
//
//  Created by Junghoon on 2018. 1. 30..
//
//

import UIKit

public protocol CMTableViewDataSource : NSObjectProtocol {
    
    /**
     number of rows in a given section of a table view
     - Parameter tableView: tableView
     - Parameter section: number identifying a section

     - Returns : The number of rows in section. The default value is 1
     */
    func tableView(_ tableView: CMTableView, numberOfRowsInSection section: Int) -> Int
    
    /**
     Asks the data source for a cell to insert in a particular location of the table view.
     - Parameter tableView: An object representing the table view requesting this information.
     - Returns : An object inheriting from UITableViewCell that the table view can use for the specified row. An assertion is raised if you return nil.
     */
    func tableView(_ tableView: CMTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    /**
     numberOfSection in tableView.
     - Parameter tableView: tableView
     - Returns : The number of sections in tableView. The default value is 1.
     */
    func numberOfSections(in tableView: CMTableView) -> Int
    

//    @objc optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
//    @objc optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    
//    @objc optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//    @objc optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
//    
//    @objc optional func sectionIndexTitles(for tableView: UITableView) -> [String]?
    
//    @objc optional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
//    @objc optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    @objc optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)

}

public extension CMTableViewDataSource {
    
    func numberOfSections(in tableView: CMTableView) -> Int {
        return 1
    }

    func tableView(_ tableView: CMTableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
