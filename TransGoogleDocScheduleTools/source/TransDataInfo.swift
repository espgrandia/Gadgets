//
//  TransDataInfo.swift
//  TransGoogleDocScheduleTools
//
//  Created by esp on 2018/10/2.
//  Copyright © 2018年 esp. All rights reserved.
//

import Cocoa

/**
 * @brief 轉換google execl 的資訊.
 * @details - 目前是很特例化的應用情境，只是想先減少人為的工。
 */
class TransDataInfo: NSObject {
    
    /** google doc url */
    let srcURL:String!
    
    /** google doc page name */
    let srcPageName:String!
    
    /** google doc column name */
    let srcColumnName:String!
    
    /** 起始的數字 */
    let fromNum:Int
    
    /** for 迴圈處理次數 */
    let dealCount:Int
    
    /** 每次需疊加的數字 */
    let accumulateNum:Int
    
    /** 需額外增加的空白行 */
    let extraEmptyRowNum:Int
    
    init(_ srcURL:String, _ srcPageName:String, _ srcColumnName:String,
         _ fromNum:Int, _ dealCount:Int, _ accumulateNum:Int, _ extraEmptyRowNum:Int)
    {
        self.srcURL = srcURL
        self.srcPageName = srcPageName
        self.srcColumnName = srcColumnName
        self.fromNum = fromNum
        self.dealCount = dealCount
        self.accumulateNum = accumulateNum
        self.extraEmptyRowNum = extraEmptyRowNum
    }
    
    func excuteTransInfo() -> NSArray! {
        
        let outputLogs:NSMutableArray! = NSMutableArray()
        
        // 處理轉換字串的輸出內容.
        for count in 0 ..< self.dealCount
        {
            let tempLog:NSString = NSString.init(format:"=IMPORTRANGE(\"%@\", \"%@!%@%d\")",
                                                 self.srcURL, self.srcPageName, self.srcColumnName,
                                                 self.fromNum + count * self.accumulateNum)
            
            outputLogs.add(tempLog)
            
            if self.extraEmptyRowNum > 0
            {
                for _ in 0 ..< self.extraEmptyRowNum
                {
                    outputLogs.add("")
                }
            }
        }
        
        return outputLogs.copy() as? NSArray
    }
}
