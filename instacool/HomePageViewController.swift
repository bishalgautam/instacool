//
//  HomePageViewController.swift
//  instacool
//
//  Created by Bishal Gautam on 2/16/16.
//  Copyright © 2016 Bishal Gautam. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //, UITableViewDataSource,UITableViewDelegate
    var vc: UIImagePickerController!
    
    @IBOutlet weak var PosterImageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
         
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            PosterImageView.image = editedImage
            dismissViewControllerAnimated(true, completion: { () -> Void in
            })
    }
    
    @IBAction func onsubmit(sender: AnyObject) {
       let  vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc,animated: true, completion: nil)
    }
//    
//    @IBAction func onLogout(sender: UIButton) {
//        
//    }
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        return 20
//        
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
//        
//        
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
