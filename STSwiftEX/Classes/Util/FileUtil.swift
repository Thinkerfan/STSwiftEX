//
//  SCFile.swift
//  AliSC
//
//  Created by cfans on 2018/9/18.
//  Copyright © 2018年 cfans. All rights reserved.
//

import Foundation

public struct CFFile {
    let name:String
    let path:String
    let createdTime:TimeInterval
    
    public init(name:String,path:String,createdTime:TimeInterval){
        self.name = name
        self.path = path
        self.createdTime = createdTime
    }
}

extension CFFile:Equatable{
    public static func ==  (lhs: CFFile, rhs: CFFile) -> Bool {
        return lhs.name == rhs.name
    }
}

public class FileUtil {

    private static let YYYY_MM_dd_HH_mm_ss = "yyyyMMdd_HH:mm:ss"

    /// 删除多个文件
    public static func deleteFiles(files:[CFFile]){
        let manager = FileManager.default
        for file in files{
           try? manager.removeItem(atPath: file.path)
        }
    }
    
    /// 根据文件名来删除单个文件
    public static func deleteFile(fileName:String){
        let path = urlFromFile(file: fileName)
        deleteFile(filePath: path!.path)
    }

    /// 根据路径来删除单个文件
    public static func deleteFile(filePath:String){
        let manager = FileManager.default
        try? manager.removeItem(atPath: filePath)
    }

    /// 以当前时间来创建文件名
    public static func mkFileNameWithTime(suffix:String)->String{
        let format = DateFormatter()
        format.dateFormat = YYYY_MM_dd_HH_mm_ss
        return "\(format.string(from: Date())).\(suffix)"
    }

    /// 创建文件路径
    public static func createFilePath(dirName:String, fileName:String) ->String{
        let manager = FileManager.default
        let fullDir = getAbsoluteDir(dir: dirName)
        if !manager.fileExists(atPath: fullDir) {
            mkFileDir(dir: fullDir)
        }
        return "\(fullDir)/\(fileName)"
    }

    /// 获取文件路径下的所有文件
    public static func getFilesAtDir(dirName:String)->[CFFile]{
        let manager = FileManager.default
        let fullDir = getAbsoluteDir(dir: dirName)
        var files = [CFFile]()
        if let arr = manager.subpaths(atPath:fullDir){
            for file in arr {
                let path = "\(fullDir)/\(file)"
                let attr = try? manager.attributesOfItem(atPath: path)
                let date = attr?[FileAttributeKey.modificationDate] as? Date
                files.append(CFFile(name: file, path: path, creationTime:(date?.timeIntervalSince1970)!))
            }
        }

        files.sort { (first, second) -> Bool in
            return first.createdTime > second.createdTime
        }
        return files
    }
    
    private static func urlFromFile(file:String) ->URL?{
        let manager = FileManager.default
        return manager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(file)
    }

    private static func mkFileDir(dir:String){
        let manager = FileManager.default
        try? manager.createDirectory(atPath: dir, withIntermediateDirectories: true)
    }

    private static func getAbsoluteDir(dir:String)->String{
        let home = NSHomeDirectory()
        return "\(home)/Documents/\(dir)"
    }
}


