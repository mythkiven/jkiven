//
//  String+extension.swift
//  LMZX_SDKDemo_Swift
//
//  Created by yj on 2017/4/6.
//  Copyright © 2017年 99baozi. All rights reserved.
//

import Foundation


extension String {
    
    func SHA1() -> String {

        var data = self.data(using: String.Encoding.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        let digestString = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        
        data?.withUnsafeBytes { (u8Ptr: UnsafePointer<UInt8>) in
            let rawPtr = UnsafeRawPointer(u8Ptr)
            if (CC_SHA1(rawPtr, CC_LONG((data?.count)!), &digest) != nil) {
                for item in digest {
                    digestString.append(String(format: "%02X", item))
                }
            }
        }
        return digestString.lowercased
    }
}
