//
//  HMAISKit.swift
//  How Much Am I Spending
//
//  Created by Shayne on 7/31/16.
//  Copyright (c) 2016 Sptorres. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class HMAISKit : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfCurrentSpendingsTabBarIcon: UIImage?
        static var currentSpendingsTabBarIconTargets: [AnyObject]?
        static var imageOfCurrentSpendingsSelectedIcon: UIImage?
        static var currentSpendingsSelectedIconTargets: [AnyObject]?
        static var imageOfShoppingListIcon: UIImage?
        static var shoppingListIconTargets: [AnyObject]?
        static var imageOfShoppingListSelectedIcon: UIImage?
        static var shoppingListSelectedIconTargets: [AnyObject]?
        static var imageOfSettingsIcon: UIImage?
        static var settingsIconTargets: [AnyObject]?
        static var imageOfSettingsSelectedIcon: UIImage?
        static var settingsSelectedIconTargets: [AnyObject]?
    }

    //// Drawing Methods

    public class func drawCurrentSpendingsTabBarIcon() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Text Drawing
        let textRect = CGRectMake(7, 1, 8, 18)
        let textTextContent = NSString(string: "$")
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Left

        let textFontAttributes = [NSFontAttributeName: UIFont(name: "ArialMT", size: 12)!, NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)


        //// Text 2 Drawing
        let text2Rect = CGRectMake(20, 4, 8, 18)
        let text2TextContent = NSString(string: "$")
        let text2Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text2Style.alignment = .Left

        let text2FontAttributes = [NSFontAttributeName: UIFont(name: "ArialMT", size: 12)!, NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: text2Style]

        let text2TextHeight: CGFloat = text2TextContent.boundingRectWithSize(CGSizeMake(text2Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text2Rect);
        text2TextContent.drawInRect(CGRectMake(text2Rect.minX, text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, text2Rect.width, text2TextHeight), withAttributes: text2FontAttributes)
        CGContextRestoreGState(context)


        //// Text 3 Drawing
        let text3Rect = CGRectMake(13, 15, 8, 18)
        let text3TextContent = NSString(string: "$")
        let text3Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text3Style.alignment = .Left

        let text3FontAttributes = [NSFontAttributeName: UIFont(name: "ArialMT", size: 12)!, NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: text3Style]

        let text3TextHeight: CGFloat = text3TextContent.boundingRectWithSize(CGSizeMake(text3Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text3Rect);
        text3TextContent.drawInRect(CGRectMake(text3Rect.minX, text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, text3Rect.width, text3TextHeight), withAttributes: text3FontAttributes)
        CGContextRestoreGState(context)
    }

    public class func drawCurrentSpendingsSelectedIcon() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()


        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.68)
        shadow.shadowOffset = CGSizeMake(0.1, -0.1)
        shadow.shadowBlurRadius = 3

        //// Text Drawing
        let textRect = CGRectMake(7, 1, 8, 18)
        let textTextContent = NSString(string: "$")
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Left

        let textFontAttributes = [NSFontAttributeName: UIFont(name: "ArialMT", size: 12)!, NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        CGContextRestoreGState(context)



        //// Text 2 Drawing
        let text2Rect = CGRectMake(20, 4, 8, 18)
        let text2TextContent = NSString(string: "$")
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        let text2Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text2Style.alignment = .Left

        let text2FontAttributes = [NSFontAttributeName: UIFont(name: "ArialMT", size: 12)!, NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: text2Style]

        let text2TextHeight: CGFloat = text2TextContent.boundingRectWithSize(CGSizeMake(text2Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text2Rect);
        text2TextContent.drawInRect(CGRectMake(text2Rect.minX, text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, text2Rect.width, text2TextHeight), withAttributes: text2FontAttributes)
        CGContextRestoreGState(context)
        CGContextRestoreGState(context)



        //// Text 3 Drawing
        let text3Rect = CGRectMake(13, 15, 8, 18)
        let text3TextContent = NSString(string: "$")
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        let text3Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text3Style.alignment = .Left

        let text3FontAttributes = [NSFontAttributeName: UIFont(name: "ArialMT", size: 12)!, NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: text3Style]

        let text3TextHeight: CGFloat = text3TextContent.boundingRectWithSize(CGSizeMake(text3Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text3Rect);
        text3TextContent.drawInRect(CGRectMake(text3Rect.minX, text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, text3Rect.width, text3TextHeight), withAttributes: text3FontAttributes)
        CGContextRestoreGState(context)
        CGContextRestoreGState(context)
    }

    public class func drawShoppingListIcon() {
        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(8.22, 23.35))
        bezierPath.addCurveToPoint(CGPointMake(8.56, 23.73), controlPoint1: CGPointMake(8.22, 23.35), controlPoint2: CGPointMake(8.34, 23.49))
        bezierPath.addCurveToPoint(CGPointMake(8.22, 23.35), controlPoint1: CGPointMake(8.37, 23.53), controlPoint2: CGPointMake(8.22, 23.35))
        bezierPath.addLineToPoint(CGPointMake(8.22, 23.35))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(36.77, 2.38))
        bezierPath.addCurveToPoint(CGPointMake(36.88, 2.45), controlPoint1: CGPointMake(36.88, 2.45), controlPoint2: CGPointMake(36.88, 2.45))
        bezierPath.addLineToPoint(CGPointMake(36.99, 2.52))
        bezierPath.addCurveToPoint(CGPointMake(38.05, 5.05), controlPoint1: CGPointMake(37.86, 3.06), controlPoint2: CGPointMake(38.28, 4.07))
        bezierPath.addCurveToPoint(CGPointMake(36.91, 7.07), controlPoint1: CGPointMake(37.87, 5.66), controlPoint2: CGPointMake(37.55, 6.13))
        bezierPath.addLineToPoint(CGPointMake(18.58, 34.1))
        bezierPath.addCurveToPoint(CGPointMake(16.72, 36.54), controlPoint1: CGPointMake(17.47, 35.73), controlPoint2: CGPointMake(17.15, 36.2))
        bezierPath.addCurveToPoint(CGPointMake(14.52, 37), controlPoint1: CGPointMake(16.02, 37.05), controlPoint2: CGPointMake(15.24, 37.19))
        bezierPath.addCurveToPoint(CGPointMake(13.57, 36.72), controlPoint1: CGPointMake(14.19, 36.97), controlPoint2: CGPointMake(13.87, 36.88))
        bezierPath.addCurveToPoint(CGPointMake(11.85, 35.12), controlPoint1: CGPointMake(13, 36.39), controlPoint2: CGPointMake(12.62, 35.96))
        bezierPath.addLineToPoint(CGPointMake(5.13, 27.71))
        bezierPath.addCurveToPoint(CGPointMake(3.2, 25.32), controlPoint1: CGPointMake(3.8, 26.24), controlPoint2: CGPointMake(3.41, 25.82))
        bezierPath.addCurveToPoint(CGPointMake(3.83, 22.59), controlPoint1: CGPointMake(2.78, 24.3), controlPoint2: CGPointMake(3.05, 23.25))
        bezierPath.addCurveToPoint(CGPointMake(3.93, 22.51), controlPoint1: CGPointMake(3.93, 22.51), controlPoint2: CGPointMake(3.93, 22.51))
        bezierPath.addLineToPoint(CGPointMake(4.03, 22.42))
        bezierPath.addCurveToPoint(CGPointMake(6.85, 22.13), controlPoint1: CGPointMake(4.81, 21.77), controlPoint2: CGPointMake(5.94, 21.65))
        bezierPath.addCurveToPoint(CGPointMake(8.21, 23.35), controlPoint1: CGPointMake(7.32, 22.41), controlPoint2: CGPointMake(7.66, 22.75))
        bezierPath.addCurveToPoint(CGPointMake(8.56, 23.73), controlPoint1: CGPointMake(8.32, 23.47), controlPoint2: CGPointMake(8.44, 23.59))
        bezierPath.addLineToPoint(CGPointMake(9.13, 24.35))
        bezierPath.addCurveToPoint(CGPointMake(14.69, 30.49), controlPoint1: CGPointMake(10.6, 25.98), controlPoint2: CGPointMake(13.46, 29.13))
        bezierPath.addCurveToPoint(CGPointMake(32, 4.97), controlPoint1: CGPointMake(18.94, 24.23), controlPoint2: CGPointMake(32, 4.97))
        bezierPath.addCurveToPoint(CGPointMake(33.86, 2.54), controlPoint1: CGPointMake(33.11, 3.34), controlPoint2: CGPointMake(33.43, 2.87))
        bezierPath.addCurveToPoint(CGPointMake(36.77, 2.38), controlPoint1: CGPointMake(34.77, 1.87), controlPoint2: CGPointMake(35.9, 1.83))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(8.57, 23.74))
        bezierPath.addCurveToPoint(CGPointMake(9.13, 24.35), controlPoint1: CGPointMake(8.82, 24.01), controlPoint2: CGPointMake(9.13, 24.35))
        bezierPath.addCurveToPoint(CGPointMake(8.56, 23.73), controlPoint1: CGPointMake(8.9, 24.11), controlPoint2: CGPointMake(8.71, 23.9))
        bezierPath.addLineToPoint(CGPointMake(8.57, 23.74))
        bezierPath.closePath()
        color.setFill()
        bezierPath.fill()
    }

    public class func drawShoppingListSelectedIcon() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.68)
        shadow.shadowOffset = CGSizeMake(0.1, -0.1)
        shadow.shadowBlurRadius = 3

        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(8.22, 23.35))
        bezier2Path.addCurveToPoint(CGPointMake(8.56, 23.73), controlPoint1: CGPointMake(8.22, 23.35), controlPoint2: CGPointMake(8.34, 23.49))
        bezier2Path.addCurveToPoint(CGPointMake(8.22, 23.35), controlPoint1: CGPointMake(8.37, 23.53), controlPoint2: CGPointMake(8.22, 23.35))
        bezier2Path.addLineToPoint(CGPointMake(8.22, 23.35))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(36.77, 2.38))
        bezier2Path.addCurveToPoint(CGPointMake(36.88, 2.45), controlPoint1: CGPointMake(36.88, 2.45), controlPoint2: CGPointMake(36.88, 2.45))
        bezier2Path.addLineToPoint(CGPointMake(36.99, 2.52))
        bezier2Path.addCurveToPoint(CGPointMake(38.05, 5.05), controlPoint1: CGPointMake(37.86, 3.06), controlPoint2: CGPointMake(38.28, 4.07))
        bezier2Path.addCurveToPoint(CGPointMake(36.91, 7.07), controlPoint1: CGPointMake(37.87, 5.66), controlPoint2: CGPointMake(37.55, 6.13))
        bezier2Path.addLineToPoint(CGPointMake(18.58, 34.1))
        bezier2Path.addCurveToPoint(CGPointMake(16.72, 36.54), controlPoint1: CGPointMake(17.47, 35.73), controlPoint2: CGPointMake(17.15, 36.2))
        bezier2Path.addCurveToPoint(CGPointMake(14.52, 37), controlPoint1: CGPointMake(16.02, 37.05), controlPoint2: CGPointMake(15.24, 37.19))
        bezier2Path.addCurveToPoint(CGPointMake(13.57, 36.72), controlPoint1: CGPointMake(14.19, 36.97), controlPoint2: CGPointMake(13.87, 36.88))
        bezier2Path.addCurveToPoint(CGPointMake(11.85, 35.12), controlPoint1: CGPointMake(13, 36.39), controlPoint2: CGPointMake(12.62, 35.96))
        bezier2Path.addLineToPoint(CGPointMake(5.13, 27.71))
        bezier2Path.addCurveToPoint(CGPointMake(3.2, 25.32), controlPoint1: CGPointMake(3.8, 26.24), controlPoint2: CGPointMake(3.41, 25.82))
        bezier2Path.addCurveToPoint(CGPointMake(3.83, 22.59), controlPoint1: CGPointMake(2.78, 24.3), controlPoint2: CGPointMake(3.05, 23.25))
        bezier2Path.addCurveToPoint(CGPointMake(3.93, 22.51), controlPoint1: CGPointMake(3.93, 22.51), controlPoint2: CGPointMake(3.93, 22.51))
        bezier2Path.addLineToPoint(CGPointMake(4.03, 22.42))
        bezier2Path.addCurveToPoint(CGPointMake(6.85, 22.13), controlPoint1: CGPointMake(4.81, 21.77), controlPoint2: CGPointMake(5.94, 21.65))
        bezier2Path.addCurveToPoint(CGPointMake(8.21, 23.35), controlPoint1: CGPointMake(7.32, 22.41), controlPoint2: CGPointMake(7.66, 22.75))
        bezier2Path.addCurveToPoint(CGPointMake(8.56, 23.73), controlPoint1: CGPointMake(8.32, 23.47), controlPoint2: CGPointMake(8.44, 23.59))
        bezier2Path.addLineToPoint(CGPointMake(9.13, 24.35))
        bezier2Path.addCurveToPoint(CGPointMake(14.69, 30.49), controlPoint1: CGPointMake(10.6, 25.98), controlPoint2: CGPointMake(13.46, 29.13))
        bezier2Path.addCurveToPoint(CGPointMake(32, 4.97), controlPoint1: CGPointMake(18.94, 24.23), controlPoint2: CGPointMake(32, 4.97))
        bezier2Path.addCurveToPoint(CGPointMake(33.86, 2.54), controlPoint1: CGPointMake(33.11, 3.34), controlPoint2: CGPointMake(33.43, 2.87))
        bezier2Path.addCurveToPoint(CGPointMake(36.77, 2.38), controlPoint1: CGPointMake(34.77, 1.87), controlPoint2: CGPointMake(35.9, 1.83))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(8.57, 23.74))
        bezier2Path.addCurveToPoint(CGPointMake(9.13, 24.35), controlPoint1: CGPointMake(8.82, 24.01), controlPoint2: CGPointMake(9.13, 24.35))
        bezier2Path.addCurveToPoint(CGPointMake(8.56, 23.73), controlPoint1: CGPointMake(8.9, 24.11), controlPoint2: CGPointMake(8.71, 23.9))
        bezier2Path.addLineToPoint(CGPointMake(8.57, 23.74))
        bezier2Path.closePath()
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        color.setFill()
        bezier2Path.fill()
        CGContextRestoreGState(context)
    }

    public class func drawSettingsIcon() {

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(14.28, 2))
        bezierPath.addCurveToPoint(CGPointMake(16.11, 5.81), controlPoint1: CGPointMake(14.92, 3.32), controlPoint2: CGPointMake(16.08, 5.75))
        bezierPath.addCurveToPoint(CGPointMake(19.9, 5.37), controlPoint1: CGPointMake(16.11, 5.81), controlPoint2: CGPointMake(18, 5.37))
        bezierPath.addCurveToPoint(CGPointMake(23.69, 5.81), controlPoint1: CGPointMake(21.79, 5.37), controlPoint2: CGPointMake(23.69, 5.81))
        bezierPath.addCurveToPoint(CGPointMake(25.51, 2), controlPoint1: CGPointMake(23.69, 5.81), controlPoint2: CGPointMake(24.87, 3.34))
        bezierPath.addCurveToPoint(CGPointMake(28.83, 3.38), controlPoint1: CGPointMake(26.67, 2.36), controlPoint2: CGPointMake(27.78, 2.82))
        bezierPath.addCurveToPoint(CGPointMake(27.47, 7.14), controlPoint1: CGPointMake(28.31, 4.82), controlPoint2: CGPointMake(27.47, 7.14))
        bezierPath.addCurveToPoint(CGPointMake(30.67, 9.43), controlPoint1: CGPointMake(27.47, 7.14), controlPoint2: CGPointMake(29.33, 8.1))
        bezierPath.addCurveToPoint(CGPointMake(32.83, 12.47), controlPoint1: CGPointMake(32.01, 10.76), controlPoint2: CGPointMake(32.83, 12.47))
        bezierPath.addCurveToPoint(CGPointMake(36.62, 11.12), controlPoint1: CGPointMake(32.83, 12.47), controlPoint2: CGPointMake(35.17, 11.64))
        bezierPath.addCurveToPoint(CGPointMake(38, 14.42), controlPoint1: CGPointMake(37.18, 12.17), controlPoint2: CGPointMake(37.64, 13.27))
        bezierPath.addCurveToPoint(CGPointMake(34.16, 16.23), controlPoint1: CGPointMake(36.65, 15.05), controlPoint2: CGPointMake(34.16, 16.23))
        bezierPath.addCurveToPoint(CGPointMake(34.61, 20.22), controlPoint1: CGPointMake(34.16, 16.23), controlPoint2: CGPointMake(34.61, 18.34))
        bezierPath.addCurveToPoint(CGPointMake(34.16, 23.77), controlPoint1: CGPointMake(34.61, 22.11), controlPoint2: CGPointMake(34.16, 23.77))
        bezierPath.addCurveToPoint(CGPointMake(38, 25.58), controlPoint1: CGPointMake(34.16, 23.77), controlPoint2: CGPointMake(36.65, 24.95))
        bezierPath.addCurveToPoint(CGPointMake(36.62, 28.87), controlPoint1: CGPointMake(37.64, 26.73), controlPoint2: CGPointMake(37.18, 27.83))
        bezierPath.addCurveToPoint(CGPointMake(32.85, 27.54), controlPoint1: CGPointMake(35.17, 28.36), controlPoint2: CGPointMake(32.85, 27.54))
        bezierPath.addCurveToPoint(CGPointMake(30.66, 30.61), controlPoint1: CGPointMake(32.85, 27.54), controlPoint2: CGPointMake(32, 29.28))
        bezierPath.addCurveToPoint(CGPointMake(27.49, 32.87), controlPoint1: CGPointMake(29.32, 31.94), controlPoint2: CGPointMake(27.49, 32.87))
        bezierPath.addCurveToPoint(CGPointMake(28.83, 36.62), controlPoint1: CGPointMake(27.49, 32.87), controlPoint2: CGPointMake(28.32, 35.19))
        bezierPath.addCurveToPoint(CGPointMake(25.51, 38), controlPoint1: CGPointMake(27.78, 37.18), controlPoint2: CGPointMake(26.67, 37.64))
        bezierPath.addCurveToPoint(CGPointMake(23.69, 34.19), controlPoint1: CGPointMake(24.87, 36.66), controlPoint2: CGPointMake(23.69, 34.19))
        bezierPath.addCurveToPoint(CGPointMake(19.85, 34.63), controlPoint1: CGPointMake(23.69, 34.19), controlPoint2: CGPointMake(21.74, 34.63))
        bezierPath.addCurveToPoint(CGPointMake(16.11, 34.19), controlPoint1: CGPointMake(17.95, 34.63), controlPoint2: CGPointMake(16.11, 34.19))
        bezierPath.addCurveToPoint(CGPointMake(14.28, 38), controlPoint1: CGPointMake(16.11, 34.19), controlPoint2: CGPointMake(14.92, 36.66))
        bezierPath.addCurveToPoint(CGPointMake(10.97, 36.62), controlPoint1: CGPointMake(13.13, 37.64), controlPoint2: CGPointMake(12.02, 37.18))
        bezierPath.addCurveToPoint(CGPointMake(12.31, 32.87), controlPoint1: CGPointMake(11.48, 35.19), controlPoint2: CGPointMake(12.31, 32.87))
        bezierPath.addCurveToPoint(CGPointMake(9.2, 30.67), controlPoint1: CGPointMake(12.31, 32.87), controlPoint2: CGPointMake(10.54, 32))
        bezierPath.addCurveToPoint(CGPointMake(6.95, 27.54), controlPoint1: CGPointMake(7.86, 29.34), controlPoint2: CGPointMake(6.95, 27.54))
        bezierPath.addCurveToPoint(CGPointMake(3.18, 28.88), controlPoint1: CGPointMake(6.95, 27.54), controlPoint2: CGPointMake(4.62, 28.37))
        bezierPath.addCurveToPoint(CGPointMake(1.8, 25.58), controlPoint1: CGPointMake(2.62, 27.83), controlPoint2: CGPointMake(2.15, 26.73))
        bezierPath.addCurveToPoint(CGPointMake(5.63, 23.77), controlPoint1: CGPointMake(3.14, 24.95), controlPoint2: CGPointMake(5.63, 23.77))
        bezierPath.addCurveToPoint(CGPointMake(5.18, 20), controlPoint1: CGPointMake(5.63, 23.77), controlPoint2: CGPointMake(5.18, 21.88))
        bezierPath.addCurveToPoint(CGPointMake(5.63, 16.23), controlPoint1: CGPointMake(5.18, 18.12), controlPoint2: CGPointMake(5.63, 16.23))
        bezierPath.addCurveToPoint(CGPointMake(3.12, 15.04), controlPoint1: CGPointMake(5.63, 16.23), controlPoint2: CGPointMake(4.35, 15.62))
        bezierPath.addCurveToPoint(CGPointMake(1.8, 14.42), controlPoint1: CGPointMake(2.65, 14.82), controlPoint2: CGPointMake(2.18, 14.6))
        bezierPath.addCurveToPoint(CGPointMake(3.18, 11.12), controlPoint1: CGPointMake(2.15, 13.27), controlPoint2: CGPointMake(2.62, 12.16))
        bezierPath.addCurveToPoint(CGPointMake(6.95, 12.45), controlPoint1: CGPointMake(4.63, 11.63), controlPoint2: CGPointMake(6.95, 12.45))
        bezierPath.addCurveToPoint(CGPointMake(9.28, 9.25), controlPoint1: CGPointMake(6.95, 12.45), controlPoint2: CGPointMake(7.94, 10.58))
        bezierPath.addCurveToPoint(CGPointMake(12.31, 7.12), controlPoint1: CGPointMake(10.62, 7.92), controlPoint2: CGPointMake(12.31, 7.12))
        bezierPath.addCurveToPoint(CGPointMake(10.97, 3.37), controlPoint1: CGPointMake(12.31, 7.12), controlPoint2: CGPointMake(11.49, 4.81))
        bezierPath.addCurveToPoint(CGPointMake(14.19, 2.03), controlPoint1: CGPointMake(11.99, 2.83), controlPoint2: CGPointMake(13.07, 2.38))
        bezierPath.addLineToPoint(CGPointMake(14.28, 2))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(19.9, 11.58))
        bezierPath.addCurveToPoint(CGPointMake(17.39, 11.95), controlPoint1: CGPointMake(19.02, 11.58), controlPoint2: CGPointMake(18.18, 11.71))
        bezierPath.addCurveToPoint(CGPointMake(11.43, 20), controlPoint1: CGPointMake(13.94, 13.02), controlPoint2: CGPointMake(11.43, 16.22))
        bezierPath.addCurveToPoint(CGPointMake(19.9, 28.42), controlPoint1: CGPointMake(11.43, 24.65), controlPoint2: CGPointMake(15.22, 28.42))
        bezierPath.addCurveToPoint(CGPointMake(28.37, 20), controlPoint1: CGPointMake(24.58, 28.42), controlPoint2: CGPointMake(28.37, 24.65))
        bezierPath.addCurveToPoint(CGPointMake(19.9, 11.58), controlPoint1: CGPointMake(28.37, 15.35), controlPoint2: CGPointMake(24.58, 11.58))
        bezierPath.closePath()
        UIColor.grayColor().setFill()
        bezierPath.fill()
    }

    public class func drawSettingsSelectedIcon() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()


        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.68)
        shadow.shadowOffset = CGSizeMake(0.1, -0.1)
        shadow.shadowBlurRadius = 3

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(14.28, 2))
        bezierPath.addCurveToPoint(CGPointMake(16.11, 5.81), controlPoint1: CGPointMake(14.92, 3.32), controlPoint2: CGPointMake(16.08, 5.75))
        bezierPath.addCurveToPoint(CGPointMake(19.9, 5.37), controlPoint1: CGPointMake(16.11, 5.81), controlPoint2: CGPointMake(18, 5.37))
        bezierPath.addCurveToPoint(CGPointMake(23.69, 5.81), controlPoint1: CGPointMake(21.79, 5.37), controlPoint2: CGPointMake(23.69, 5.81))
        bezierPath.addCurveToPoint(CGPointMake(25.51, 2), controlPoint1: CGPointMake(23.69, 5.81), controlPoint2: CGPointMake(24.87, 3.34))
        bezierPath.addCurveToPoint(CGPointMake(28.83, 3.38), controlPoint1: CGPointMake(26.67, 2.36), controlPoint2: CGPointMake(27.78, 2.82))
        bezierPath.addCurveToPoint(CGPointMake(27.47, 7.14), controlPoint1: CGPointMake(28.31, 4.82), controlPoint2: CGPointMake(27.47, 7.14))
        bezierPath.addCurveToPoint(CGPointMake(30.67, 9.43), controlPoint1: CGPointMake(27.47, 7.14), controlPoint2: CGPointMake(29.33, 8.1))
        bezierPath.addCurveToPoint(CGPointMake(32.83, 12.47), controlPoint1: CGPointMake(32.01, 10.76), controlPoint2: CGPointMake(32.83, 12.47))
        bezierPath.addCurveToPoint(CGPointMake(36.62, 11.12), controlPoint1: CGPointMake(32.83, 12.47), controlPoint2: CGPointMake(35.17, 11.64))
        bezierPath.addCurveToPoint(CGPointMake(38, 14.42), controlPoint1: CGPointMake(37.18, 12.17), controlPoint2: CGPointMake(37.64, 13.27))
        bezierPath.addCurveToPoint(CGPointMake(34.16, 16.23), controlPoint1: CGPointMake(36.65, 15.05), controlPoint2: CGPointMake(34.16, 16.23))
        bezierPath.addCurveToPoint(CGPointMake(34.61, 20.22), controlPoint1: CGPointMake(34.16, 16.23), controlPoint2: CGPointMake(34.61, 18.34))
        bezierPath.addCurveToPoint(CGPointMake(34.16, 23.77), controlPoint1: CGPointMake(34.61, 22.11), controlPoint2: CGPointMake(34.16, 23.77))
        bezierPath.addCurveToPoint(CGPointMake(38, 25.58), controlPoint1: CGPointMake(34.16, 23.77), controlPoint2: CGPointMake(36.65, 24.95))
        bezierPath.addCurveToPoint(CGPointMake(36.62, 28.87), controlPoint1: CGPointMake(37.64, 26.73), controlPoint2: CGPointMake(37.18, 27.83))
        bezierPath.addCurveToPoint(CGPointMake(32.85, 27.54), controlPoint1: CGPointMake(35.17, 28.36), controlPoint2: CGPointMake(32.85, 27.54))
        bezierPath.addCurveToPoint(CGPointMake(30.66, 30.61), controlPoint1: CGPointMake(32.85, 27.54), controlPoint2: CGPointMake(32, 29.28))
        bezierPath.addCurveToPoint(CGPointMake(27.49, 32.87), controlPoint1: CGPointMake(29.32, 31.94), controlPoint2: CGPointMake(27.49, 32.87))
        bezierPath.addCurveToPoint(CGPointMake(28.83, 36.62), controlPoint1: CGPointMake(27.49, 32.87), controlPoint2: CGPointMake(28.32, 35.19))
        bezierPath.addCurveToPoint(CGPointMake(25.51, 38), controlPoint1: CGPointMake(27.78, 37.18), controlPoint2: CGPointMake(26.67, 37.64))
        bezierPath.addCurveToPoint(CGPointMake(23.69, 34.19), controlPoint1: CGPointMake(24.87, 36.66), controlPoint2: CGPointMake(23.69, 34.19))
        bezierPath.addCurveToPoint(CGPointMake(19.85, 34.63), controlPoint1: CGPointMake(23.69, 34.19), controlPoint2: CGPointMake(21.74, 34.63))
        bezierPath.addCurveToPoint(CGPointMake(16.11, 34.19), controlPoint1: CGPointMake(17.95, 34.63), controlPoint2: CGPointMake(16.11, 34.19))
        bezierPath.addCurveToPoint(CGPointMake(14.28, 38), controlPoint1: CGPointMake(16.11, 34.19), controlPoint2: CGPointMake(14.92, 36.66))
        bezierPath.addCurveToPoint(CGPointMake(10.97, 36.62), controlPoint1: CGPointMake(13.13, 37.64), controlPoint2: CGPointMake(12.02, 37.18))
        bezierPath.addCurveToPoint(CGPointMake(12.31, 32.87), controlPoint1: CGPointMake(11.48, 35.19), controlPoint2: CGPointMake(12.31, 32.87))
        bezierPath.addCurveToPoint(CGPointMake(9.2, 30.67), controlPoint1: CGPointMake(12.31, 32.87), controlPoint2: CGPointMake(10.54, 32))
        bezierPath.addCurveToPoint(CGPointMake(6.95, 27.54), controlPoint1: CGPointMake(7.86, 29.34), controlPoint2: CGPointMake(6.95, 27.54))
        bezierPath.addCurveToPoint(CGPointMake(3.18, 28.88), controlPoint1: CGPointMake(6.95, 27.54), controlPoint2: CGPointMake(4.62, 28.37))
        bezierPath.addCurveToPoint(CGPointMake(1.8, 25.58), controlPoint1: CGPointMake(2.62, 27.83), controlPoint2: CGPointMake(2.15, 26.73))
        bezierPath.addCurveToPoint(CGPointMake(5.63, 23.77), controlPoint1: CGPointMake(3.14, 24.95), controlPoint2: CGPointMake(5.63, 23.77))
        bezierPath.addCurveToPoint(CGPointMake(5.18, 20), controlPoint1: CGPointMake(5.63, 23.77), controlPoint2: CGPointMake(5.18, 21.88))
        bezierPath.addCurveToPoint(CGPointMake(5.63, 16.23), controlPoint1: CGPointMake(5.18, 18.12), controlPoint2: CGPointMake(5.63, 16.23))
        bezierPath.addCurveToPoint(CGPointMake(3.12, 15.04), controlPoint1: CGPointMake(5.63, 16.23), controlPoint2: CGPointMake(4.35, 15.62))
        bezierPath.addCurveToPoint(CGPointMake(1.8, 14.42), controlPoint1: CGPointMake(2.65, 14.82), controlPoint2: CGPointMake(2.18, 14.6))
        bezierPath.addCurveToPoint(CGPointMake(3.18, 11.12), controlPoint1: CGPointMake(2.15, 13.27), controlPoint2: CGPointMake(2.62, 12.16))
        bezierPath.addCurveToPoint(CGPointMake(6.95, 12.45), controlPoint1: CGPointMake(4.63, 11.63), controlPoint2: CGPointMake(6.95, 12.45))
        bezierPath.addCurveToPoint(CGPointMake(9.28, 9.25), controlPoint1: CGPointMake(6.95, 12.45), controlPoint2: CGPointMake(7.94, 10.58))
        bezierPath.addCurveToPoint(CGPointMake(12.31, 7.12), controlPoint1: CGPointMake(10.62, 7.92), controlPoint2: CGPointMake(12.31, 7.12))
        bezierPath.addCurveToPoint(CGPointMake(10.97, 3.37), controlPoint1: CGPointMake(12.31, 7.12), controlPoint2: CGPointMake(11.49, 4.81))
        bezierPath.addCurveToPoint(CGPointMake(14.19, 2.03), controlPoint1: CGPointMake(11.99, 2.83), controlPoint2: CGPointMake(13.07, 2.38))
        bezierPath.addLineToPoint(CGPointMake(14.28, 2))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(19.9, 11.58))
        bezierPath.addCurveToPoint(CGPointMake(17.39, 11.95), controlPoint1: CGPointMake(19.02, 11.58), controlPoint2: CGPointMake(18.18, 11.71))
        bezierPath.addCurveToPoint(CGPointMake(11.43, 20), controlPoint1: CGPointMake(13.94, 13.02), controlPoint2: CGPointMake(11.43, 16.22))
        bezierPath.addCurveToPoint(CGPointMake(19.9, 28.42), controlPoint1: CGPointMake(11.43, 24.65), controlPoint2: CGPointMake(15.22, 28.42))
        bezierPath.addCurveToPoint(CGPointMake(28.37, 20), controlPoint1: CGPointMake(24.58, 28.42), controlPoint2: CGPointMake(28.37, 24.65))
        bezierPath.addCurveToPoint(CGPointMake(19.9, 11.58), controlPoint1: CGPointMake(28.37, 15.35), controlPoint2: CGPointMake(24.58, 11.58))
        bezierPath.closePath()
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        UIColor.grayColor().setFill()
        bezierPath.fill()
        CGContextRestoreGState(context)
    }

    //// Generated Images

    public class var imageOfCurrentSpendingsTabBarIcon: UIImage {
        if Cache.imageOfCurrentSpendingsTabBarIcon != nil {
            return Cache.imageOfCurrentSpendingsTabBarIcon!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(35, 35), false, 0)
            HMAISKit.drawCurrentSpendingsTabBarIcon()

        Cache.imageOfCurrentSpendingsTabBarIcon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfCurrentSpendingsTabBarIcon!
    }

    public class var imageOfCurrentSpendingsSelectedIcon: UIImage {
        if Cache.imageOfCurrentSpendingsSelectedIcon != nil {
            return Cache.imageOfCurrentSpendingsSelectedIcon!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(35, 35), false, 0)
            HMAISKit.drawCurrentSpendingsSelectedIcon()

        Cache.imageOfCurrentSpendingsSelectedIcon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfCurrentSpendingsSelectedIcon!
    }

    public class var imageOfShoppingListIcon: UIImage {
        if Cache.imageOfShoppingListIcon != nil {
            return Cache.imageOfShoppingListIcon!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(40, 40), false, 0)
            HMAISKit.drawShoppingListIcon()

        Cache.imageOfShoppingListIcon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfShoppingListIcon!
    }

    public class var imageOfShoppingListSelectedIcon: UIImage {
        if Cache.imageOfShoppingListSelectedIcon != nil {
            return Cache.imageOfShoppingListSelectedIcon!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(40, 40), false, 0)
            HMAISKit.drawShoppingListSelectedIcon()

        Cache.imageOfShoppingListSelectedIcon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfShoppingListSelectedIcon!
    }

    public class var imageOfSettingsIcon: UIImage {
        if Cache.imageOfSettingsIcon != nil {
            return Cache.imageOfSettingsIcon!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(40, 40), false, 0)
            HMAISKit.drawSettingsIcon()

        Cache.imageOfSettingsIcon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfSettingsIcon!
    }

    public class var imageOfSettingsSelectedIcon: UIImage {
        if Cache.imageOfSettingsSelectedIcon != nil {
            return Cache.imageOfSettingsSelectedIcon!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(40, 40), false, 0)
            HMAISKit.drawSettingsSelectedIcon()

        Cache.imageOfSettingsSelectedIcon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfSettingsSelectedIcon!
    }

    //// Customization Infrastructure

    @IBOutlet var currentSpendingsTabBarIconTargets: [AnyObject]! {
        get { return Cache.currentSpendingsTabBarIconTargets }
        set {
            Cache.currentSpendingsTabBarIconTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector("setImage:", withObject: HMAISKit.imageOfCurrentSpendingsTabBarIcon)
            }
        }
    }

    @IBOutlet var currentSpendingsSelectedIconTargets: [AnyObject]! {
        get { return Cache.currentSpendingsSelectedIconTargets }
        set {
            Cache.currentSpendingsSelectedIconTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector("setImage:", withObject: HMAISKit.imageOfCurrentSpendingsSelectedIcon)
            }
        }
    }

    @IBOutlet var shoppingListIconTargets: [AnyObject]! {
        get { return Cache.shoppingListIconTargets }
        set {
            Cache.shoppingListIconTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector("setImage:", withObject: HMAISKit.imageOfShoppingListIcon)
            }
        }
    }

    @IBOutlet var shoppingListSelectedIconTargets: [AnyObject]! {
        get { return Cache.shoppingListSelectedIconTargets }
        set {
            Cache.shoppingListSelectedIconTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector("setImage:", withObject: HMAISKit.imageOfShoppingListSelectedIcon)
            }
        }
    }

    @IBOutlet var settingsIconTargets: [AnyObject]! {
        get { return Cache.settingsIconTargets }
        set {
            Cache.settingsIconTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector("setImage:", withObject: HMAISKit.imageOfSettingsIcon)
            }
        }
    }

    @IBOutlet var settingsSelectedIconTargets: [AnyObject]! {
        get { return Cache.settingsSelectedIconTargets }
        set {
            Cache.settingsSelectedIconTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector("setImage:", withObject: HMAISKit.imageOfSettingsSelectedIcon)
            }
        }
    }

}
