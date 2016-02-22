//
//  HomePageViewController.swift
//  instacool
//
//  Created by Bishal Gautam on 2/16/16.
//  Copyright © 2016 Bishal Gautam. All rights reserved.
//
import Parse
import UIKit

class HomePageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var mediarray: [PFObject]?
    var refreshControl : UIRefreshControl!
    
    @IBOutlet weak var PosterImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        // construct PFQuery
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                // do something with the data fetched
                self.mediarray = media
                self.tableView.reloadData()
                
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        }

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if mediarray != nil{
            return mediarray!.count
        }else{
            return 0
        }
           }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("contentViewCell", forIndexPath: indexPath) as! ContentViewCell
        let media = mediarray![indexPath.row]
        cell.myCaptionLabel.text = media["caption"] as? String
        let userImageFile = media["media"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.posterView.image = image
                }
            }
        }
        
        return cell
    }
    
    
    func refresh(sender: AnyObject) {
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.mediarray = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.refreshControl.endRefreshing()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
