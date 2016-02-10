//
//  ViewController.swift
//  Instagram
//
//  Created by lesleychai on 2/4/16.
//  Copyright © 2016 lichai. All rights reserved.
//

import UIKit
import AFNetworking


class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var picDict: [NSDictionary]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let clientId = "Put your client id here"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.picDict = (responseDictionary["results"] as! [NSDictionary])
                            self.tableView.re
                            
                    }
                }
        });
        task.resume()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // In case there's network call and movie is nil
        if let picDict = picDict {
            return picDict.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell",forIndexPath: indexPath) as! PhotosViewCell
        
        let pict = picDict![indexPath.row] as NSDictionary
        let images = pict["images"]!["low_resolution"] as! NSDictionary

        let imageUrl = NSURL(string: images["url"] as! String)
        cell.photosView.setImageWithURL(imageUrl!)
        
        print("row \(indexPath.row)")
        return cell
    }


}

