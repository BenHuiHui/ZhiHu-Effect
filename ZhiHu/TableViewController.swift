//
//  TableViewController.swift
//  ZhiHu
//
//  Created by Hui Hui on 3/9/15.
//  Copyright (c) 2015 Hui Hui. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //private let RefreshOffset: CGFloat = -100.0
    private let HeaderHeight: CGFloat = 300
    private let ParallexFactor: CGFloat = 3
    private let ProgressMaxHeight: CGFloat = 75
    
    private let StatusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
    
    var headerView: UIView!
    //Navigation bar is currently implemented using UIView.
    var navigationBar: HUINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutInitialView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = "\(indexPath.row)"

        return cell
    }


    //MARK: Scroll

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        println("Scroll offset is \(scrollView.contentOffset.y)")
        //Header
        updateHeaderView()
        
        //Navigation bar
        updateNavigationBar()
    }
    
    //Use this method to determine if refresh is required
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        var contentOffset = scrollView.contentOffset
        var yOffset = contentOffset.y + HeaderHeight
        
        //Animate Refresh
        if yOffset < -ProgressMaxHeight {
            navigationBar.animate()
            
            //Demo purpose - Hide animation after 3 secs
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                
                //TODO: use unowned to avoid leakage
                self.navigationBar.endAnimation()
            }
        }
        
    }
    
    //MARK: Layout
    private func layoutInitialView(){
        //Set up the header view
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.sendSubviewToBack(headerView)
        
        //Set up the size
        tableView.contentInset = UIEdgeInsets(top: HeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -HeaderHeight)
        updateHeaderView()
        
        //Navigation bar
        addNavigationBar()
    }
    
    private func updateHeaderView(){
        
        var headerRect = CGRect(x: 0, y: -HeaderHeight, width: tableView.bounds.size.width, height: HeaderHeight)
        
        //Stretch effect
        if tableView.contentOffset.y < -HeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y 
        }
        
        //Parallex effect
        else{
            var offset = tableView.contentOffset.y - (HeaderHeight + tableView.contentOffset.y) / ParallexFactor
            headerRect.origin.y = offset
        }
        
        headerView.frame = headerRect
    }
    
    //MARK: Navigation Bar
    private func addNavigationBar(){
        if navigationBar == nil {
            navigationBar = HUINavigationBar(frame: CGRect(x: 0, y: -HeaderHeight, width: UIScreen.mainScreen().bounds.size.width, height: 44 + StatusBarHeight))
            
            navigationBar.setBackgroundAlpha(0)
            navigationBar.setTitle("Home")
            
            view.addSubview(navigationBar)
        }
    }
    
    private func updateNavigationBar(){
        
        if navigationBar == nil {
            return
        }
        
        //Position
        var navFrame = navigationBar.frame
        navFrame.origin.y = tableView.contentOffset.y
        navigationBar.frame = navFrame
        
        //Color - Alpha
        var headerActualHeight = HeaderHeight - 44 - StatusBarHeight
        var alpha: CGFloat = 0
        var diff = HeaderHeight + tableView.contentOffset.y
        
        if diff > 0 {
            alpha = diff / headerActualHeight > 1 ? 1 : diff / headerActualHeight
        }
        navigationBar.setBackgroundAlpha(alpha)
        
        //Animation Progress
        if diff < 0 {
            var ratio = -diff / ProgressMaxHeight
            
            if ratio > 1 {
                ratio = 1
            }
            
            navigationBar.animateProgress(ratio)
        }
    }
    
    //MARK: Status bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
