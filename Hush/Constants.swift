//
//  Constants.swift
//  Hush
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

//View Dimensions
let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let w = screenSize.width
let h = screenSize.height

//Custom Colors
struct HSColor{
    static let primary = UIColorFromRGB(0xFF6D91)
    static let primaryDark = UIColorFromRGB(0xF64B77)
    static let secondary = UIColorFromRGB(0x0EADFF)
    static let tertiary = UIColorFromRGB(0xE5CEF8)
    static let tertiaryDark = UIColorFromRGB(0xC18BEE)
    static let quaternary = UIColorFromRGB(0xFFC5D9)
    static let facebookBlue = UIColorFromRGB(0x3B5998)
    static let faintGray = UIColor(white: 0.95, alpha: 1)
}

public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//Database Constants
var userDatabase = "User"
var productDatabase = "Product"
var feedItemDatabase = "FeedItem"
var paginationLimit = UInt(15)
var paginationUpperLimit = 150

//Arrays
let feedSegmentedTitles = ["friends".localized(), "trending".localized()]
let searchSectionTitles = ["people", "products"]
let searchSectionImages = [UIImage(named: "peopleFilled"), UIImage(named: "browseFilled")]
let browseSegmentedTitles = ["bronzerPlusContour".localized(), "brushes".localized(), "faceCleansers".localized(), "tonersPlusSerums".localized(), "faceCreams".localized(), "faceMasks".localized(), "sheetMasks".localized(), "eyeCare".localized(), "bodyCare".localized(), "hair".localized(), "nails".localized(), "accessories".localized(), "justForYou".localized(), "featured".localized(), "sale".localized(), "newArrivals".localized(),"trendingNow".localized(), "bestSellers".localized(), "lipColor".localized(), "lipCare".localized(), "eyeShadow".localized(), "eyes".localized(), "eyebrows".localized(), "eyelashes".localized(), "primePlusSet".localized(), "face".localized(), "blushPlusHighlight".localized()]
let accountSectionTitles = ["account", "support"]
let accountTitles = ["loginOrSignup"]
let supportTitles = ["faq", "customerSupport", "privacyPolicy", "endUserAgreement"]
let positiveAffirmations = ["positiveAffirmation1", "positiveAffirmation2", "positiveAffirmation3", "positiveAffirmation4", "positiveAffirmation5", "positiveAffirmation6", "positiveAffirmation7", "positiveAffirmation8", "positiveAffirmation9", "positiveAffirmation10"]

//Feature Not Available
public func featureUnavailableAlert() -> UIAlertController{
    //Show Alert that this feature is not available
    let alert = UIAlertController(title: "sorry".localized(), message: "featureUnavailableMessage".localized(), preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
    return alert
}

//Other Functions
public func currentTimestamp() -> Double{
    let timestamp = Date().timeIntervalSince1970*1000
    return Double(timestamp)
}

extension NSNumber{
    func currencyString(maxFractionDigits: Int) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = maxFractionDigits
        let currencyString = formatter.string(from: self)
        
        return currencyString!
    }
    
    func shortNumberString(style: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        
        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (1_000_000.0, 1_000_000.0, "M"),
                                           (1_000_000_000.0, 1_000_000_000.0, "B")]
        
        let startValue = abs(self.doubleValue)
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()
        
        let value = self.doubleValue / abbreviation.divisor
        formatter.positiveSuffix = abbreviation.suffix
        formatter.negativeSuffix = abbreviation.suffix
        formatter.allowsFloats = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.numberStyle = style
        
        return formatter.string(from: NSNumber(value: value))!
    }
    
    func dateValue() -> Date {
        let timeInterval: TimeInterval = self.doubleValue
        let date = Date.init(timeIntervalSince1970: timeInterval/1000)
        
        return date
    }
}
