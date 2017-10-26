//
//  YJUserModel.m
//  CreditPlatform
//
//  Created by yj on 16/8/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJUserModel.h"

@implementation YJUserModel
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.userPwd = [aDecoder decodeObjectForKey:@"userPwd"];
        self.picture = [aDecoder decodeObjectForKey:@"picture"];
        self.login = [aDecoder decodeBoolForKey:@"login"];
        self.authQualifyFlag = [aDecoder decodeObjectForKey:@"authQualifyFlag"];
        self.authStatus = [aDecoder decodeObjectForKey:@"authStatus"];
        self.masterStatus = [aDecoder decodeObjectForKey:@"masterStatus"];
        self.apiKey = [aDecoder decodeObjectForKey:@"apiKey"];
//        self.aesKey = [aDecoder decodeObjectForKey:@"aesKey"];
        self.companyName = [aDecoder decodeObjectForKey:@"companyName"];

    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.userPwd forKey:@"userPwd"];
    [aCoder encodeObject:self.picture forKey:@"picture"];
    [aCoder encodeBool:self.login forKey:@"login"];
    [aCoder encodeObject:self.authQualifyFlag forKey:@"authQualifyFlag"];
    
    [aCoder encodeObject:self.authStatus forKey:@"authStatus"];
    [aCoder encodeObject:self.masterStatus forKey:@"masterStatus"];
    [aCoder encodeObject:self.apiKey forKey:@"apiKey"];
    [aCoder encodeObject:self.companyName forKey:@"companyName"];

//    [aCoder encodeObject:self.aesKey forKey:@"aesKey"];
}





- (UIImage *)iconImage {
    if (_picture) {
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:_picture options:(NSDataBase64DecodingIgnoreUnknownCharacters)] ;
        return [UIImage imageWithData:imageData];
    }
    return [UIImage imageNamed:@"me_head_icon"];
}

@end
