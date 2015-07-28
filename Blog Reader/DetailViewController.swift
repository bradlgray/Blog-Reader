//
//  DetailViewController.swift
//  Blog Reader
//
//  Created by Brad Gray on 7/24/15.
//  Copyright (c) 2015 Brad Gray. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  
    @IBOutlet weak var webView: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        if let detail: AnyObject = self.detailItem {
        if let wv = self.webView {
         
            wv.loadHTMLString(detail.valueForKey("content")!.description, baseURL: nil)
        }
        }
        
            }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

