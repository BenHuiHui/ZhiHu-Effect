//
//  ZhiViewController.swift
//  ZhiHu
//
//  Created by Hui Hui on 3/9/15.
//  Copyright (c) 2015 Hui Hui. All rights reserved.
//

import UIKit

class ZhiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!

    private let RefreshOffset: CGFloat = -100.0
    private let HeaderHeight: CGFloat = 300
    //private let MaxScrollHeight: CGFloat = HeaderHeight + 75
    private let ParallexFactor: CGFloat = 3
    
    var headerView: UIView!
    //Navigation bar is currently implemented using UIView.
    var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    //MARK: Scroll
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        println("Scroll offset is \(scrollView.contentOffset.y)")
        //Header
        updateHeaderView()
        
        //Navigation bar
    }
    
    //MARK: Layout
    private func layoutInitialView(){
        //Set up the header view
        headerView = tableView.headerViewForSection(0)
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.sendSubviewToBack(headerView)
        
        //Set up the size
        tableView.contentInset = UIEdgeInsets(top: HeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -HeaderHeight)
        updateHeaderView()
        
        //Navigation bar
        //addNavigationBar()
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

}
