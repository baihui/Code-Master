//
//  LanguageViewController.swift
//  Code Master
//
//  Created by Hoang on 1/21/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import Foundation

class LanguageViewController: UITableViewController {
    
    var languages: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Languages", comment: "")
        
        let URLBundle : NSURL = NSBundle.mainBundle().URLForResource("tmLanguages", withExtension: "bundle")!
        NSFileManager.defaultManager().fileExistsAtPath(URLBundle.path!)
        
        let fileManager = NSFileManager.defaultManager()
        let enumerator : NSDirectoryEnumerator = fileManager.enumeratorAtPath(URLBundle.path!)!
        
        languages = NSMutableArray()
        while let element = enumerator.nextObject() as? String {
            let fileName = (element as NSString).stringByDeletingPathExtension
            languages.addObject(fileName)
        }
        
        self.tableView.reloadData()
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneItemDidTap:")
        self.navigationItem.rightBarButtonItem = doneItem

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView datasource, delegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.languages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        print(self.languages[indexPath.row])
        cell!.textLabel?.text  = self.languages[indexPath.row] as? String
//        cell!.backgroundColor = workout?.color
//        cell!.countLabel.text = "\(indexPath.row+1)"
//        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    func doneItemDidTap(sender: AnyObject) {
        self.close()
    }
    
    // MARK: - Utilities
    
    func close() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
