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
// let elements = CommandLine.arguments

// 使用 json 格式剖析.

#if D_JSON_VER

    print("Initial TransDataInfo!")

    let jsonData = """
    {
      "srcURL": "https://docs.google.com/spreadsheets/d/1EqJiTQy-6VSTkfuSAzJqK1hrx8WAnegj-FnejNEIamI/edit?pli=1#gid=713291970",
      "srcPageName": "工作排程",
      "srcColumnName": "S",
      "fromNum": 3,
      "dealCount": 100,
      "accumulateNum": 1,
      "extraEmptyRowNum": 2,
      "outputFileName": "Desktop/tempTransFile_mou.txt"
    }
    """.data(using: .utf8)!

    print("create TransDataInfo")
    var dataInfo: TransDataInfo = TransDataInfo.crateWithJSON(jsonData)!

#else

    print("Initial TransDataInfo!")

    // 暫時寫死，之後可能改成讀取檔案方式.
    // let srcURL:String! = "https://docs.google.com/spreadsheets/d/1IDwIdGm9hBOLFWQ2JV39BJD3DwcODdhFHlf5RMU9itw/edit#gid=0"
    // let srcPageName:String! = "2018"
    // let srcColumnName:String! = "E"
    // let fromNum:Int = 428
    // let dealCount:Int = 100
    // let accumulateNum:Int = 3
    // let extraEmptyRowNum:Int = 0
    // let outputFileName:String! = "Desktop/tempTransFile.txt"

    // 暫時寫死，之後可能改成讀取檔案方式.
    let srcURL: String! = "https://docs.google.com/spreadsheets/d/1EqJiTQy-6VSTkfuSAzJqK1hrx8WAnegj-FnejNEIamI/edit?pli=1#gid=713291970"
    let srcPageName: String! = "工作排程"
    let srcColumnName: String! = "S"
    let fromNum: Int = 3
    let dealCount: Int = 100
    let accumulateNum: Int = 1
    let extraEmptyRowNum: Int = 2
    let outputFileName: String! = "Desktop/tempTransFile_mou.txt"

    print("create TransDataInfo")

    var dataInfo: TransDataInfo = TransDataInfo(srcURL, srcPageName, srcColumnName,
                                                fromNum, dealCount, accumulateNum, extraEmptyRowNum, outputFileName)

#endif

print("deal TransDataInfo trans log")

var outputLogs: NSArray! = dataInfo.generatorTransInfo()

let homeDirURL: URL = URL(fileURLWithPath: NSHomeDirectory())

let pathURL: URL = homeDirURL.appendingPathComponent(dataInfo.outputFileName)
let path = homeDirURL.absoluteString + dataInfo.outputFileName

// 處理寫檔.
let arrayToSave = NSArray(array: outputLogs)

let outputLog: String = outputLogs.componentsJoined(by: "\r\n")

print("write outputLog to file: ", pathURL)
try outputLog.write(to: pathURL, atomically: true, encoding: String.Encoding.utf8)

print("TransGoogleDocScheduleTools excute finish")
