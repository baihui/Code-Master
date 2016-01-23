//
//  ContentMode.swift
//  X
//
//  Created by Sam Soffes on 5/8/15.
//  Copyright (c) 2015 Sam Soffes. All rights reserved.
//

#if os(iOS)
	import UIKit.UIView
	public typealias ContentMode = UIViewContentMode
#else
	public enum ContentMode : Int {
		case ScaleToFill
		case ScaleAspectFit
		case ScaleAspectFill
		case Redraw
		case Center
		case Top
		case Bottom
		case Left
		case Right
		case TopLeft
		case TopRight
		case BottomLeft
		case BottomRight
	}
#endif
