//
//  SettingsViewController.swift
//  Code Master
//
//  Created by Justin Bush on 1/1/16.
//  Copyright (c) 2016 Justin Bush. All rights reserved.
//

import UIKit
protocol SettingViewControllerDelegate{
    func didClickDone()
}

class SettingsViewController: FXFormViewController, ThemeViewControllerDelegate {
    var themeController : ThemeViewController!
    var delegate:SettingViewControllerDelegate?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Settings", comment: "")
        self.formController.form = SettingsForm.sharedForm
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneItemDidTap:")
        self.navigationItem.rightBarButtonItem = doneItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    func fontDidTap(sender: AnyObject) {
        let fontController = EDHFontSelector.sharedSelector().settingsViewController()
        self.navigationController?.pushViewController(fontController, animated: true)
    }

    func acknowledgementsDidTap(sender: AnyObject) {
        let acknowledgementsController = VTAcknowledgementsViewController(acknowledgementsPlistPath: NSBundle.mainBundle().pathForResource("Pods-acknowledgements", ofType: "plist"))
        //let acknowledgementsController = VTAcknowledgementsViewController() // Doesn't work
        self.navigationController?.pushViewController(acknowledgementsController, animated: true)
    }

    func doneItemDidTap(sender: AnyObject) {
        self.close()
    }
    
    func themeDidTap(sender: AnyObject) {
        self.themeController = ThemeViewController()
        self.themeController.selectedThemes = NSUserDefaults.standardUserDefaults().objectForKey(Defaults.themeKey) as? String
        self.themeController.delegate = self
        self.navigationController?.pushViewController(self.themeController, animated: true)
    }
    
    // MARK: - ThemeViewControllerDelegate
    
    func didClickTheme(theme: String) {

    }
    
    // MARK: - Utilities
    
    func close() {
        self.delegate?.didClickDone()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}
