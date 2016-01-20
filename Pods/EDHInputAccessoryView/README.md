# EDHInputAccessoryView

[![Version](https://img.shields.io/cocoapods/v/EDHInputAccessoryView.svg?style=flat)](http://cocoadocs.org/docsets/EDHInputAccessoryView)
[![License](https://img.shields.io/cocoapods/l/EDHInputAccessoryView.svg?style=flat)](http://cocoadocs.org/docsets/EDHInputAccessoryView)
[![Platform](https://img.shields.io/cocoapods/p/EDHInputAccessoryView.svg?style=flat)](http://cocoadocs.org/docsets/EDHInputAccessoryView)

Simple input accessory view, developed for [Edhita](https://github.com/tnantoka/edhita).  
EDHInputAccessoryView is available through [CocoaPods](http://cocoapods.org).

![](/screenshot.png)

## Requirements

* iOS 8.0

## Demo

```
pod try EDHInputAccessoryView
```

## Installation

```
# Podfile
pod 'EDHInputAccessoryView', '~> 0.1'
```

```
$ pod install
```

## Usage

```
#import "EDHInputAccessoryView.h"

UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
textView.inputAccessoryView = [[EDHInputAccessoryView alloc] initWithTextView:textView];
```

See also [Example](/Example).

## Author

[tnantoka](https://twitter.com/tnantoka)

## License

The MIT license

