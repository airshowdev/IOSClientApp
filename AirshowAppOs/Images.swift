//
//  Images.swift
//  AirshowAppOs
//
//  Created by Dev Lab Mac 2 on 6/1/18.
//  Copyright © 2018 Dev Lab Mac 2. All rights reserved.
//
import Foundation
import UIKit

class AirshowImages{
    public static let SavedImageCache = AirshowImages()
    private var imageCache = NSCache<NSString, AnyObject>()
    
    func saveAllAirshowImages(selectedIndex: Int){
        for performers in (InfoStore.getDatabase().airshows[selectedIndex]?.performers)!{
            downloadImageFrom(urlString: (performers?.image)!)
        }
        for staticDisplaySources in (InfoStore.getDatabase().airshows[selectedIndex]?.statics)!{
            downloadImageFrom(urlString: (staticDisplaySources?.image)!)
        }
    }
    
    func downloadImageFrom(urlString: String){
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url)
    }
    
    func downloadImageFrom(url: URL){
       
        
        if imageCache.object(forKey: url.absoluteString as NSString) != nil{
        return
        } else {
            let imgData = try! Data(contentsOf: url)
            let AirshowImage = UIImage(data: imgData)
            self.cacheImage(image: AirshowImage!, forKey: url.absoluteString as NSString)
        }
    }
    
    func cacheImage(image: UIImage, forKey key: NSString) {
        imageCache.setObject(image, forKey: key)
    }
    func fetchPerformerImageByAirshowIndex(staticIndex: Int, airshowIndex: Int) -> UIImage{
        return fetchImageWithKey(key: InfoStore.getDatabase().airshows[airshowIndex]?.performers[staticIndex]!.image as! NSString)!
    }
    func fetchStaticImageByAirshowIndex(staticIndex: Int, airshowIndex: Int) -> UIImage{
        return fetchImageWithKey(key: InfoStore.getDatabase().airshows[airshowIndex]?.statics[staticIndex]!.image as! NSString)!
    }
    func fetchImageWithKey(key: NSString) -> UIImage? {
        if let returnObj = imageCache.object(forKey: key){
            return (returnObj as! UIImage)
        } else {
            downloadImageFrom(urlString: key as String)
            if let dlReturn = imageCache.object(forKey: key){
                return (dlReturn as! UIImage)
            } else {
                return nil
            }
        }
    }
}

