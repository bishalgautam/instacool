//
//  UploadViewController.swift
//  instacool
//
//  Created by Bishal Gautam on 2/21/16.
//  Copyright © 2016 Bishal Gautam. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // The onCustomTap: method will be defined in Step 3 below.
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action:Selector("onCustomTap:"))
        var imageView = posterImageView
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 1;
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func onSubmit(sender: AnyObject) {
        UserMedia.postUserImage(posterImageView.image, withCaption: commentTextField.text) { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Posted to Parse")
                self.posterImageView.image = nil
                self.commentTextField.text = " "
                
            }
            else {
                print("Can't post to parse")
            }
        }

        
    }
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func onCustomTap(sender: UITapGestureRecognizer) {
        var point = sender.locationInView(view)
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc,animated: true, completion: nil)

        
        // User tapped at the point above. Do something with that if you want.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            posterImageView.image = editedImage
            dismissViewControllerAnimated(true, completion: { () -> Void in
            })
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
