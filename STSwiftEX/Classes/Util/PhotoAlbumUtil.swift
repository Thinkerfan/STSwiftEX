//
//  CFPhotoUtil.swift
//  QRCode
//
//  Created by cfans on 2018/12/19.
//  Copyright © 2018 cfans. All rights reserved.
//

import Photos

//操作结果枚举
public enum PhotoExportResult {
    case success, error, denied
}

//相册操作工具类
public class PhotoAlbumUtil: NSObject {

    /// 判断是否授权
    public static func isAuthorized() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == .authorized ||
            PHPhotoLibrary.authorizationStatus() == .notDetermined
    }

    /// 保存到相册
    public static func saveVideoInAlbum(url:URL, albumName: String = "Default",
                                   completion: ((_ result: PhotoExportResult) -> ())?=nil){
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
        }) { completed, error in
            if completed {
                completion?(.success)
            } else{
                completion?(.error)
            }
        }
    }

    /// 保存图片到相册
    public static func saveImageInAlbum(image: UIImage, albumName: String = "Default",
                                completion: ((_ result: PhotoExportResult) -> ())?=nil) {

        //权限验证
        if !isAuthorized() {
            completion?(.denied)
            return
        }
        var assetAlbum: PHAssetCollection?

        //如果指定的相册名称为空，则保存到相机胶卷。（否则保存到指定相册）
        if albumName.isEmpty {
            let list = PHAssetCollection
                .fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary,
                                       options: nil)
            assetAlbum = list[0]
        } else {
            //看保存的指定相册是否存在
            let list = PHAssetCollection
                .fetchAssetCollections(with: .album, subtype: .any, options: nil)
            list.enumerateObjects({ (album, index, stop) in
                let assetCollection = album
                if albumName == assetCollection.localizedTitle {
                    assetAlbum = assetCollection
                    stop.initialize(to: true)
                }
            })
            //不存在的话则创建该相册
            if assetAlbum == nil {
                PHPhotoLibrary.shared().performChanges({
                    PHAssetCollectionChangeRequest
                        .creationRequestForAssetCollection(withTitle: albumName)
                }, completionHandler: { (isSuccess, error) in
                    self.saveImageInAlbum(image: image, albumName: albumName,
                                          completion: completion)
                })
                return
            }
        }

        //保存图片
        PHPhotoLibrary.shared().performChanges({
            //添加的相机胶卷
            let result = PHAssetChangeRequest.creationRequestForAsset(from: image)
            //是否要添加到相簿
            if !albumName.isEmpty {
                let assetPlaceholder = result.placeholderForCreatedAsset
                let albumChangeRequset = PHAssetCollectionChangeRequest(for:
                    assetAlbum!)
                albumChangeRequset!.addAssets([assetPlaceholder!]  as NSArray)
            }
        }) { (isSuccess: Bool, error: Error?) in
            if isSuccess {
                completion?(.success)
            } else{
                print(error!.localizedDescription)
                completion?(.error)
            }
        }
    }
    
    /// 获取最新的图片
    public static func fetchLatestPhotos(forCount count: Int?) -> PHFetchResult<PHAsset> {
        let options = PHFetchOptions()
        if let count = count { options.fetchLimit = count }
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        options.sortDescriptors = [sortDescriptor]
        return PHAsset.fetchAssets(with: .image, options: options)
        
    }
}
