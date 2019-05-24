//
//  EXFileManager.swift
//  文件管理扩展类
//
//  Created by cfans on 2018/10/22.
//  Copyright © 2018年 cfans. All rights reserved.
//

import Foundation
extension FileManager {

    /// copy file from resource to documentDirectory
    public func copyfileToUserDocumentDirectory(forResource name: String,
                                         ofType ext: String) throws
    {
        let fileName = "\(name).\(ext)"
        if let bundlePath = Bundle.main.path(forResource: name, ofType: ext),
            let destPath = getFileFullPath(fileName: fileName) {
            if !self.fileExists(atPath: destPath) {
                print("copy")
                try self.copyItem(atPath: bundlePath, toPath: destPath)
            }else{
                print("copy OK ")
            }
        }
    }
    /// Return  url base on documentDirectory
    public func getFileFullPath(fileName:String)->String?{
        if let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true).first{
            return URL(fileURLWithPath: destPath)
                .appendingPathComponent(fileName).path
        }
        return nil
    }

}

extension FileManager {
    /// remove file if existed
    public func removeIfExisted(_ url:URL) -> Void {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(atPath: url.path)
            }
            catch {
                print("Failed to delete file")
            }
        }
    }
    /// Return temp url base on NSTemporaryDirectory
    public func tempFileUrl(_ outputName:String) ->URL{
        let path = NSTemporaryDirectory().appending(outputName)
        let exportURL = URL.init(fileURLWithPath: path)
        removeIfExisted(exportURL)
        return exportURL
    }
}
