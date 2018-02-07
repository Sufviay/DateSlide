//
//  DateTool.swift
//  XYCharts
//
//  Created by 岁变 on 2018/2/3.
//  Copyright © 2018年 岁变. All rights reserved.
//

import UIKit

class DateTool: NSObject {
    
    //当前时间
    class func getMidTimeText(_ dateCompentCount: Int) -> String {
        let currentDate = getTimeDateWith(dateCompentCount)
        return dateTurnString(date: currentDate)
    }
    
    //左侧时间
    class func getLeftTimeText(_ dateCompentCount: Int) -> String {
        let leftDate: Date = getTimeDateWith(dateCompentCount)
        return dateTurnString(date: leftDate)
    }
    
    //右侧时间
    class func getRightTimeText(_ dateCompentCount: Int) -> String {
        let rightDate: Date = getTimeDateWith(dateCompentCount)
        return dateTurnString(date: rightDate)
    }
    
    
    
    //data转时间
    class func dateTurnString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        let dateStr = formatter.string(from:date)
        let returnStr = cleanString(dateStr: dateStr)
        return returnStr
    }
    
    //获取距离当前时间指定天数的时间
    class func getTimeDateWith(_ dateCompentCount: Int) -> Date {
        let currentDate = Date()
        var newcomponent = DateComponents()
        newcomponent.day = dateCompentCount
        let date = Calendar.current.date(byAdding: newcomponent, to: currentDate) ?? currentDate
        return date
    }

    
    //时间字符串清零
    class func cleanString(dateStr: String) -> String {
        let strArr = dateStr.components(separatedBy: ".")
        let monthStr: String = strArr.first ?? "0"
        let dayStr: String = strArr.last ?? "0"
        let monCount: Int = Int(monthStr) ?? 0
        let dayCount: Int = Int(dayStr) ?? 0
        let newMonStr = String(monCount)
        let newDayStr = String(dayCount)
        let returnStr = newMonStr + "." + newDayStr
        return returnStr
    }
    
    
}
