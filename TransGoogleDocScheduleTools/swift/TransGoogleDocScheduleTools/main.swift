//
//  main.swift
//  TransGoogleDocScheduleTools
//
//  Created by esp on 2018/10/2.
//  Copyright © 2018年 esp. All rights reserved.
//

import Foundation

#if D_JSON_VER

    // parse main arguments
    print("Parse command arguments")

    print("CommandLine.argc : \(CommandLine.argc)")
    print("CommandLine.arguments : \(CommandLine.arguments)")

    var srcConfigFileURL: URL?

    // 判斷是否有帶入參數，第一個為 file path.
    if CommandLine.argc > 1 {
        srcConfigFileURL = URL(fileURLWithPath: CommandLine.arguments[1])
    }

    print("Initial TransDataInfo!")

    // 讀取設定檔，需為 json 格式，之前作法，之後可以移除.
    if srcConfigFileURL == nil {
        srcConfigFileURL = URL(fileURLWithPath: NSHomeDirectory() + "/Desktop/temp/TransGoogleDocTest/catTest.json")
    }

    let jsonData: Data = try Data(contentsOf: srcConfigFileURL!)

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
