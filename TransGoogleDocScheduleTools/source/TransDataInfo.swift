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
    let srcURL:String!
    let srcPageName:String!
    let fromNum:Int
    let dealCount:Int
    let accumulateNub:Int
    
    init(_ srcURL:String, _ srcPageName:String, _ fromNum:Int,
         _ dealCount:Int, _ accumulateNub:Int)
    {
        self.srcURL = srcURL
        self.srcPageName = srcPageName
        self.fromNum = fromNum
        self.dealCount = dealCount
        self.accumulateNub = accumulateNub
    }
}
