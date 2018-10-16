//
//  main.swift
//  TransGoogleDocScheduleTools
//
//  Created by esp on 2018/10/2.
//  Copyright © 2018年 esp. All rights reserved.
//

import Foundation

// 延伸議題:
// Test Code，之後可以研究 main arguments 使用方式。
//let elements = CommandLine.arguments



/*
 * @brief - google excel 連結欄位產生器.
 * @details - 此為從某個 google excel 連結到另一個 google excel 欄位.
 */
// sample code
//=IMPORTRANGE("https://docs.google.com/spreadsheets/d/1IDwIdGm9hBOLFWQ2JV39BJD3DwcODdhFHlf5RMU9itw/edit#gid=0","2018!E410")

print("Initial TransDataInfo!")

// 暫時寫死，之後可能改成讀取檔案方式.
let srcURL:String! = "https://docs.google.com/spreadsheets/d/1IDwIdGm9hBOLFWQ2JV39BJD3DwcODdhFHlf5RMU9itw/edit#gid=0"
let srcPageName:String! = "2018!E"
let fromNum:Int = 428
let dealCount:Int = 100
let accumulateNub:Int = 3
let outputFileName:String! = "Desktop/tempTransFile.txt"

var dataInfo:TransDataInfo = TransDataInfo(srcURL, srcPageName,
                                           fromNum, dealCount, accumulateNub)

var outputLogs:NSMutableArray! = NSMutableArray()

let homeDirURL:URL = URL(fileURLWithPath: NSHomeDirectory())

let pathURL:URL = homeDirURL.appendingPathComponent(outputFileName)
let path = homeDirURL.absoluteString + outputFileName

// 處理轉換字串的輸出內容.
for count in 1...dataInfo.dealCount
{
    let tempLog:NSString = NSString.init(format: "=IMPORTRANGE(\"%@\", \"%@%d\")", dataInfo.srcURL
        , dataInfo.srcPageName, dataInfo.fromNum + count * accumulateNub)
    
    outputLogs.add(tempLog)
}

// 處理寫檔.
let arrayToSave = NSArray(array: outputLogs)

let outputLog:String = outputLogs.componentsJoined(by: "\r\n")
try outputLog.write(to: pathURL, atomically: true, encoding: String.Encoding.utf8)

