//
//  LanguageViewController.swift
//  Code Master
//
//  Created by Hoang on 1/21/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import Foundation

protocol LanguageViewControllerDelegate{
    func didClickLanguage(language:String)
}

class LanguageViewController: UITableViewController {
    
    var languages: NSMutableArray!
    var delegate:LanguageViewControllerDelegate?
    var selectedLanguage:String?
    
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
        let language = self.languages[indexPath.row] as? String
        cell!.textLabel?.text  = language
        if language == self.selectedLanguage {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let language:String = (self.languages[indexPath.row] as? String)!
        NSUserDefaults.standardUserDefaults().setObject(language, forKey: Defaults.languageKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        self.delegate?.didClickLanguage(language)
        self.navigationController?.popViewControllerAnimated(true)
    }
}
