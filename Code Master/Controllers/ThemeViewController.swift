//
//  ThemeViewController.swift
//  Code Master
//
//  Created by Hoang on 1/22/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import Foundation

protocol ThemeViewControllerDelegate{
    func didClickTheme(theme:String)
}

class ThemeViewController: UITableViewController {
    
    var themes: NSMutableArray!
    var delegate:ThemeViewControllerDelegate?
    var selectedThemes:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Themes", comment: "")
        
        let URLBundle : NSURL = NSBundle.mainBundle().URLForResource("tmThemes", withExtension: "bundle")!
        NSFileManager.defaultManager().fileExistsAtPath(URLBundle.path!)
        
        let fileManager = NSFileManager.defaultManager()
        let enumerator : NSDirectoryEnumerator = fileManager.enumeratorAtPath(URLBundle.path!)!
        
        themes = NSMutableArray()
        while let element = enumerator.nextObject() as? String {
            let fileName = (element as NSString).stringByDeletingPathExtension
            themes.addObject(fileName)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView datasource, delegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.themes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        let theme = self.themes[indexPath.row] as? String
        cell!.textLabel?.text  = theme
        if theme == self.selectedThemes {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let theme:String = (self.themes[indexPath.row] as? String)!
        NSUserDefaults.standardUserDefaults().setObject(theme, forKey: Defaults.themeKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        self.delegate?.didClickTheme(theme)
        self.navigationController?.popViewControllerAnimated(true)
    }
}
