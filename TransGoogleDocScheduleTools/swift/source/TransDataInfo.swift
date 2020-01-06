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
    
    /**
     * @brief - 藉由輸入json string產生TransDataInfo instance 的類別方法.
     * @param - data : json string to Data (.utf8 format)
     * @details - 以下為自測時的 sample code
     //     let jsonData = """
     //     {
     //         "srcURL": "https://docs.google.com/spreadsheets/d/1EqJiTQy-6VSTkfuSAzJqK1hrx8WAnegj-FnejNEIamI/edit?pli=1#gid=713291970",
     //         "srcPageName": "工作排程",
     //         "srcColumnName": "S",
     //         "fromNum": 3,
     //         "dealCount": 100,
     //         "accumulateNum": 1,
     //         "extraEmptyRowNum": 2,
     //         "outputFileName": "Desktop/tempTransFile_mou.txt"
     //     }
     //     """.data(using: .utf8)!
     */
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
            
            // 處理通用規則.
            // 判斷 srcURL，srcPageName， srcColumnName 各自是否有包含 $，
            // 有的話表示是需要 mapping 另一個欄位的格式 : 要用到 T
            var tempLog:String
            
            // =IMPORTRANGE($J$2, T($J$3)&T("!")&T($J$4)&T("3"))
            // 需判斷是否需要
            var tempSrcURL:String
            tempSrcURL = self.srcURL.contains("$") ? self.srcURL : String.init(format: "\"%@\"", self.srcURL)
            
            var tempSrcPageName:String
            tempSrcPageName = self.srcPageName.contains("$") ? self.srcPageName : String.init(format: "\"%@\"", self.srcPageName)
            
            var tempSrcColumnName:String
            tempSrcColumnName = self.srcColumnName.contains("$") ? self.srcColumnName : String.init(format: "\"%@\"", self.srcColumnName)
            
            // sample : 只有 srcColumnName 有 $
            //                =IMPORTRANGE("https://docs.google.com/spreadsheets/d/1dUTkFCMOTZ80AegyDYuMNrHyNVyA-dytsPSJvdM9FX8/edit#gid=1638438240", T("每日工作_RD_2019")&T("!")&T($K$4)&T("6"))
            
            // sample :srcURL，srcPageName， srcColumnName 都有 $
            // =IMPORTRANGE($J$2, T($J$3)&T("!")&T($J$4)&T("3"))
            
            tempLog = NSString(format: "=IMPORTRANGE(%@, T(%@)&T(\"!\")&T(%@)&T(\"%d\"))",
                               tempSrcURL, tempSrcPageName, tempSrcColumnName,
                               self.fromNum + count * self.accumulateNum) as String
            
            outputLogs.add(tempLog)
            
            // 額外處理是否需新增空白行.
            if self.extraEmptyRowNum > 0 {
                for _ in 0 ..< self.extraEmptyRowNum {
                    outputLogs.add("")
                }
            }
        }
        
        return outputLogs.copy() as? NSArray
    }
}
