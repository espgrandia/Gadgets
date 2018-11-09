//
//  TransDataInfo.swift
//  TransGoogleDocScheduleTools
//
//  Created by esp on 2018/10/2.
//  Copyright © 2018年 esp. All rights reserved.
//

import Cocoa

/**
 * @brief google execl 自動 mapping 另一個 doc 欄位的資訊。
 * @details - 目前是很特例化的應用情境，只是想先減少人為的工。
 *            並無加上太多防呆，請謹慎使用。
 *            此為從某個 google excel 連結到另一個 google excel 欄位。
 */
class TransDataInfo: Decodable {
    /** google doc url */
    let srcURL: String!

    /** google doc page name */
    let srcPageName: String!

    /** google doc column name */
    let srcColumnName: String!

    /** 起始的數字 */
    let fromNum: Int

    /** for 迴圈處理次數 */
    let dealCount: Int

    /** 每次需疊加的數字 */
    let accumulateNum: Int

    /** 需額外增加的空白行 */
    let extraEmptyRowNum: Int

    /** 輸出的檔案名稱(含路徑) */
    let outputFileName: String!

    init(_ srcURL: String, _ srcPageName: String, _ srcColumnName: String,
         _ fromNum: Int, _ dealCount: Int, _ accumulateNum: Int, _ extraEmptyRowNum: Int,
         _ outputFileName: String) {
        self.srcURL = srcURL
        self.srcPageName = srcPageName
        self.srcColumnName = srcColumnName
        self.fromNum = fromNum
        self.dealCount = dealCount
        self.accumulateNum = accumulateNum
        self.extraEmptyRowNum = extraEmptyRowNum
        self.outputFileName = outputFileName
    }

    /**   */
    class func crateWithJSON(_ data: Data) -> TransDataInfo? {
        var jsonResult: TransDataInfo?

        do {
            jsonResult = try JSONDecoder().decode(TransDataInfo.self, from: data)

            print(jsonResult!)

        } catch {
            print(error)
        }

        return jsonResult
    }

    /** 自動產生 mapping google excel 欄位資料 */
    func generatorTransInfo() -> NSArray! {
        let outputLogs: NSMutableArray! = NSMutableArray()

        // 處理轉換字串的輸出內容.
        for count in 0 ..< dealCount {
            // sample code
            // =IMPORTRANGE("https://docs.google.com/spreadsheets/d/1IDwIdGm9hBOLFWQ2JV39BJD3DwcODdhFHlf5RMU9itw/edit#gid=0","2018!E410")

            // 處理通用規則.
            let tempLog: NSString = NSString(format: "=IMPORTRANGE(\"%@\", \"%@!%@%d\")",
                                             srcURL, srcPageName, srcColumnName,
                                             fromNum + count * accumulateNum)

            outputLogs.add(tempLog)

            // 額外處理是否需新增空白行.
            if extraEmptyRowNum > 0 {
                for _ in 0 ..< extraEmptyRowNum {
                    outputLogs.add("")
                }
            }
        }

        return outputLogs.copy() as? NSArray
    }
}
