//
//  MasterViewController.swift
//  Blog Reader
//
//  Created by Brad Gray on 7/24/15.
//  Copyright (c) 2015 Brad Gray. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

   
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        let url = NSURL(string: "https://www.googleapis.com/blogger/v3/blogs/10861780/posts?key=AIzaSyCWHQIxPFhF5hG-UIppwBB1zl2BBeRO4zg")
        let session =  NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: { (data , response, error) -> Void in
            if error != nil {
                println(error)
            } else {
                //println(NSString(data: data, encoding: NSUTF8StringEncoding))
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                if jsonResult.count > 0 {
                
                    if let items = jsonResult["items"] as? NSArray {
                        for item in items {
                            println(item)
                            
                            if let title = item["title"] as? String {
                                if let content = item["content"] as? String {
                                    var newPost = NSEntityDescription.insertNewObjectForEntityForName("Posts", inManagedObjectContext: context) as! NSManagedObject
                                    newPost.setValue(title, forKey: "title")
                                    newPost.setValue(content, forKey: "content")
                                    context.save(nil)
                                }

                            }
                            
                            
                        }
                    }
                }
                var request = NSFetchRequest(entityName: "Posts")
                request.returnsObjectsAsFaults = false
                var results = context.executeFetchRequest(request, error: nil)!
                println(results)
                
               self.tableView.reloadData()
                
                
            }
            
            
            
        })
        task.resume()
        
                   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            println("show Detail")
            
            }
        }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
       cell.textLabel?.text = "test"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

   
}

