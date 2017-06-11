//
//  ViewController.swift
//  FuckingBeepYelp
//
//  Created by Taku Tran on 6/7/17.
//  Copyright © 2017 Taku Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterViewControllerDelegate {

    var businesses: [Business]!
    
    var filterbusinesses: [Business]!
    
    var isSearching = false
    
    //@IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    //let searchController = UISearchController(searchResultsController: nil)
    
    func filterContentForSearchText (searchText: String, scope: String = "ALL" ){
        filterbusinesses = businesses.filter{ business in
            return (business.name?.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
    }
    
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterbusinesses = searchText.isEmpty ? businesses : businesses.filter {
            (item: Business) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 120;
        
        let searchBar = UISearchBar()
        searchBar.delegate = self;
        searchBar.sizeToFit()
        
        searchBar.placeholder = "Restaurant"
        
        navigationItem.titleView = searchBar
        
        super.viewDidLoad()
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.filterbusinesses = businesses;
            self.tableView.reloadData()
            /*if let businesses = businesses {
             for business in businesses {
             print(business.name!)
             print(business.address!)
             }
             }*/
            
        }
        )
        
        //searchBar.delegate = self as? UISearchBarDelegate
        //searchBar.returnKeyType = UIReturnKeyType.done
        
        /*searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar*/
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        /*if ((filterbusinesses) != nil) {
         return filterbusinesses.count
         }
         else {
         return 0;
         }*/
        
        /*if searchController.isActive && searchController.searchBar.text != "" {
            return filterbusinesses.count
        } else if ((businesses) != nil) {
            return businesses.count
        } else {
            return 0
        }*/
        if ((filterbusinesses) != nil) {
            return filterbusinesses.count
        }
        else {
            return 0;
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        let business : Business
        business = filterbusinesses[indexPath.row]

        
        //cell = filterbusinesses![indexPath.row]
        
        cell.resName.text = business.name
        cell.resImage.setImageWith(business.imageURL!)
        cell.resAddress.text = business.address
        cell.resRate.setImageWith(business.ratingImageURL!)
        cell.resReviews.text = String(describing: business.reviewCount!) + " reviews"
        cell.resType.text = business.categories
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell;
         
         let business : Business
         if searchController.isActive && searchController.searchBar.text != "" {
         business = filterbusinesses[indexPath.row]
         } else {
         business = businesses[indexPath.row]
         }
         
         cell.resName.text = business.name
         cell.resPic.setImageWith(business.imageURL!)
         cell.resAddress.text = business.address
         cell.resRate.setImageWith(business.ratingImageURL!)
         cell.resReviews.text = String(describing: business.reviewCount!) + " reviews"
         cell.resType.text = business.categories*/
        
        //businesses = businesses[indexPath.row]
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FilterViewController
        
        filtersViewController.delegate = self
     }
    
    func filtersViewController(filersViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        let categories = filters["categories"] as! [String]
        
        /*Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil) { (businesses: [Business]?,error: NSError) in
            self.businesses = businesses
            self.tableView.reloadData()
        }*/
        
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.filterbusinesses = businesses
            self.tableView.reloadData()
        }
    )
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText (searchText: searchController.searchBar.text!)
    }
}


