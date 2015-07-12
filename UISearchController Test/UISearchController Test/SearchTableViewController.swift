//
//  SearchTableViewController.swift
//  UISearchController Test
//
//  Created by Ömer Emre Aslan on 12/07/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let countries = ["Turkey","Turkish Republic of Northern Cyprus","Azerbaijan","USA"]
    var filteredCountries = [String]()
    var resultSearchController:UISearchController!
    @IBOutlet var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.filteredCountries = countries
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            if self.resultSearchController.searchBar.text != "" {
                return self.filteredCountries.count
            } else {
                return self.countries.count
            }
        } else {
            return self.countries.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if (self.resultSearchController.active)
        {
            self.tblView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.85)
            let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath) as UITableViewCell?
            
            if self.resultSearchController.searchBar.text != "" {
                cell!.textLabel?.text = self.filteredCountries[indexPath.row]
            } else {
                cell!.textLabel?.text = self.countries[indexPath.row]
            }
            
            return cell!
        }
        else
        {
            self.tblView.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell?
            cell!.textLabel?.text = self.countries[indexPath.row]
            
            return cell!
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredCountries.removeAll()
        let searching:String = searchController.searchBar.text!
        if searching != "" {
            for text in countries {
                if text.containsIgnoreCase(searching){
                    filteredCountries.append(text as String)
                }
            }
        }
        self.tableView.reloadData()
    }
}

extension String {
    func containsIgnoreCase(otherString: String) -> Bool {
        //creation NSString from String to use containsString method
        let firstString:NSString = self.lowercaseString as NSString
        //changing capitalization status
        let secondString = otherString.lowercaseString
        
        return firstString.containsString(secondString)
    }
    
    func containsSensetiveCase(otherString: String) -> Bool {
        //creation NSString from String to use containsString method
        let firstString:NSString = self as NSString
        //changing capitalization status
        let secondString = otherString
        return firstString.containsString(secondString)
    }
}
