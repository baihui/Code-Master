# EDHFontSelector

[![Version](https://img.shields.io/cocoapods/v/EDHFontSelector.svg?style=flat)](http://cocoadocs.org/docsets/EDHFontSelector)
[![License](https://img.shields.io/cocoapods/l/EDHFontSelector.svg?style=flat)](http://cocoadocs.org/docsets/EDHFontSelector)
[![Platform](https://img.shields.io/cocoapods/p/EDHFontSelector.svg?style=flat)](http://cocoadocs.org/docsets/EDHFontSelector)

Font settings interface for iOS, developed for [Edhita](https://github.com/tnantoka/edhita).  
EDHFontSelector is available through [CocoaPods](http://cocoapods.org).

![](/screenshot.png)

## Requirements

* iOS 8.0

## Demo

```
pod try EDHFontSelector
```

## Installation

```
# Podfile
pod 'EDHFontSelector', '~> 0.1'
```

```
$ pod install
```

## Usage

```
#import "EDHFontSelector.h"

UINavigationController *navController = [EDHFontSelector sharedSelector] settingsNavigationController];
```

See also [Example](/Example).

## Author

[tnantoka](https://twitter.com/tnantoka)

## License

The MIT license

