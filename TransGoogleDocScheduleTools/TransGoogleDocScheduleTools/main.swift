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
//let srcURL:String! = "https://docs.google.com/spreadsheets/d/1IDwIdGm9hBOLFWQ2JV39BJD3DwcODdhFHlf5RMU9itw/edit#gid=0"
//let srcPageName:String! = "2018"
//let srcColumnName:String! = "E"
//let fromNum:Int = 428
//let dealCount:Int = 100
//let accumulateNum:Int = 3
//let outputFileName:String! = "Desktop/tempTransFile.txt"
//let extraEmptyRowNum:Int = 0

// 暫時寫死，之後可能改成讀取檔案方式.
let srcURL:String! = "https://docs.google.com/spreadsheets/d/1EqJiTQy-6VSTkfuSAzJqK1hrx8WAnegj-FnejNEIamI/edit?pli=1#gid=713291970"
let srcPageName:String! = "工作排程"
let srcColumnName:String! = "S"
let fromNum:Int = 3
let dealCount:Int = 100
let accumulateNum:Int = 1
let outputFileName:String! = "Desktop/tempTransFile_mou.txt"
let extraEmptyRowNum:Int = 2

print("create TransDataInfo")
var dataInfo:TransDataInfo = TransDataInfo(srcURL, srcPageName, srcColumnName,
                                           fromNum, dealCount, accumulateNum, extraEmptyRowNum)

print("deal TransDataInfo trans log")

var outputLogs:NSArray! = dataInfo.excuteTransInfo()

let homeDirURL:URL = URL(fileURLWithPath: NSHomeDirectory())

let pathURL:URL = homeDirURL.appendingPathComponent(outputFileName)
let path = homeDirURL.absoluteString + outputFileName

// 處理寫檔.
let arrayToSave = NSArray(array: outputLogs)

let outputLog:String = outputLogs.componentsJoined(by: "\r\n")


print("write outputLog to file: ", pathURL)
try outputLog.write(to: pathURL, atomically: true, encoding: String.Encoding.utf8)

print("TransGoogleDocScheduleTools excute finish")
