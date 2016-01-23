//
//  EditorView.swift
//  Code Master
//
//  Created by Justin Bush on 1/1/16.
//  Copyright (c) 2016 Justin Bush. All rights reserved.
//

import UIKit
import SyntaxKit

class EditorView: UIView, UITextViewDelegate {
    let kBorderWidth : CGFloat = 1.0
    
    enum EditorViewMode {
        case None, Edit, Preview, Split
    }
    
    var textView: UITextView!
    var webView: UIWebView! // TODO: Use WKWebView
    var finderItem: EDHFinderItem? {
        didSet {
            self.configureView()
        }
    }
    
    var mode: EditorViewMode = .None {
        didSet {
            if oldValue != self.mode {
                self.updateControls()                
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]

        self.textView = UITextView(frame: self.bounds)
        self.textView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.textView.delegate = self
        self.addSubview(self.textView)

        self.webView = UIWebView(frame: self.bounds)
        //self.webView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        //self.webView.scalesPageToFit = true
        self.addSubview(self.webView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame() {
        switch self.mode {
        case .Edit:
            self.textView.frame = self.bounds
            //self.webView.frame = self.bounds
            self.updateWebViewFrame(self.bounds)
        case .Preview:
            self.textView.frame = self.bounds
            // self.webView.frame = self.bounds
            self.updateWebViewFrame(self.bounds)
        case .Split:
            self.textView.frame = CGRect(x: 0.0, y: 0.0, width: CGRectGetMidX(self.bounds), height: CGRectGetHeight(self.bounds))
            //self.webView.frame = CGRect(x: CGRectGetMidX(self.bounds) + kBorderWidth, y: 0.0, width: CGRectGetMidX(self.bounds) - kBorderWidth, height: CGRectGetHeight(self.bounds))
            self.updateWebViewFrame(CGRect(x: CGRectGetMidX(self.bounds) + kBorderWidth, y: 0.0, width: CGRectGetMidX(self.bounds) - kBorderWidth, height: CGRectGetHeight(self.bounds)))
        default:
            break
        }
    }
    
    // Web view gets smaller and smaller with decimal fraction?
    func updateWebViewFrame(var frame: CGRect) {
        frame.size.width = ceil(CGRectGetWidth(frame))
        self.webView.frame = frame
    }
    
    func updateControls() {
        self.updateFrame()
        
        switch self.mode {
        case .Edit:
            self.textView.hidden = false
            self.webView.hidden = true

            //self.textView.becomeFirstResponder()
            self.loadBlank()
        case .Preview:
            self.textView.hidden = true
            self.webView.hidden = false
            
            self.textView.resignFirstResponder()
            self.preview()
        case .Split:
            self.textView.hidden = false
            self.webView.hidden = false
            self.preview()
        default:
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
        self.textView.delegate = self
        
        if self.textView.isFirstResponder() {
            let selectedRange = self.textView.selectedRange
            self.textView.scrollRangeToVisible(selectedRange)
        }
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(textView: UITextView) {
        self.finderItem?.updateContent(textView.text)
        self.preview()
    }
    
    // MARK: - Utilities
    
    func configureView() {
        
        if let item = self.finderItem {
            if item.isEditable() {
                self.textView.editable = true
                
                
                self.textView.text = item.content()
                
                if SettingsForm.sharedForm.accessoryView {
                    self.textView.inputAccessoryView = EDHInputAccessoryView(textView: self.textView)
                } else {
                    self.textView.inputAccessoryView = nil
                }
            } else {
                self.textView.editable = false
                self.textView.text = ""

                self.textView.inputAccessoryView = nil
            }
            self.preview()
        } else {
            self.textView.editable = false
            self.textView.text = ""
            self.loadBlank()
        }
        
        EDHFontSelector.sharedSelector().applyToTextView(self.textView)
        updateSyntaxKit()
    }
    
    func updateSyntaxKit(){
        if self.textView.text != ""{
            var language:String? = NSUserDefaults.standardUserDefaults().objectForKey(Defaults.languageKey) as? String
            if language == "Plain text" {
                language = "Swift"
            }
            let theme:String? = NSUserDefaults.standardUserDefaults().objectForKey(Defaults.themeKey) as? String

            let languageBundlePath = NSBundle.mainBundle().pathForResource("tmLanguages", ofType: "bundle")!
            let languageBundle = NSBundle(path: languageBundlePath)
            let tmlanguage = languageBundle?.pathForResource(language, ofType: "tmLanguage")
            let plist = NSDictionary(contentsOfFile: tmlanguage!)! as [NSObject: AnyObject]
            let yaml = Language(dictionary: plist)
            
            let themeBundlePath = NSBundle.mainBundle().pathForResource("tmThemes", ofType: "bundle")!
            let themeBundle = NSBundle(path: themeBundlePath)
            let tmtheme = themeBundle?.pathForResource(theme, ofType: "tmTheme")
            let plist1 = NSDictionary(contentsOfFile: tmtheme!)! as [NSObject: AnyObject]
            let tomorrow = Theme(dictionary: plist1)
            let attributedParser = AttributedParser(language: yaml!, theme: tomorrow!)
            
            let attributedString = attributedParser.attributedStringForString(self.textView.text)
            self.textView.attributedText = attributedString
        }
    }
    
    func loadBlank() {
        self.loadURL(NSURL(string: "about:blank"))
    }
    
    func preview() {
        if let item = self.finderItem {
            if item.mimeType != nil && item.mimeType == "text/markdown" {
                self.loadHTML(self.renderMarkdown(item.content()) as String, baseURL: item.parent().fileURL())
            } else {
//                let indexPath = item.path.stringByDeletingLastPathComponent.stringByAppendingPathComponent("index.html")
//                let indexItem = EDHFinderItem(path: indexPath)
//                if indexItem.isFile {
//                    self.loadURL(indexItem.fileURL())
//                } else {
//                    self.loadURL(item.fileURL())
//                }
                self.loadURL(item.fileURL())
            }
        }
    }
    
    func loadURL(url: NSURL!) {
        self.webView.loadRequest(NSURLRequest(URL: url, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 0.0))
    }
    
    func loadHTML(html: String!, baseURL: NSURL!) {
        self.webView.loadHTMLString(html, baseURL: baseURL)
    }
    
    func reload() {
        self.webView.reload()
    }
    
    func hideKeyboard() {
        self.textView.endEditing(true)
        textView.resignFirstResponder()
    }
    
    func renderMarkdown(content: NSString) -> NSString {
        let parser = GHMarkdownParser()
        parser.options = kGHMarkdownAutoLink
        parser.githubFlavored = true
        let rendered = parser.HTMLStringFromMarkdownString(content as String)
        let body = "<article class=\"markdown-body\">\(rendered)</article>"
        let path = NSBundle.mainBundle().pathForResource("github-markdown", ofType: "css")
        let url = NSURL.fileURLWithPath(path!)
        let style = "<link rel=\"stylesheet\" href=\"\(url.absoluteString)\">"
        return "\(style)\(body)"
    }
}
