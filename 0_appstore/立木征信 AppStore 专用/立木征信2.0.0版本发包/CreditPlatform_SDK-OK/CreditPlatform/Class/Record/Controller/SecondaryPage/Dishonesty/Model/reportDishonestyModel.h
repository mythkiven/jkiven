//
//  reportDishonestyModel.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface reportDishonestyModel : NSObject

@property (strong,nonatomic) NSString      *no;
@property (strong,nonatomic) NSString      *name;
@property (strong,nonatomic) NSString      *identityNo;
@property (strong,nonatomic) NSString      *sex;
@property (strong,nonatomic) NSString      *age;
@property (strong,nonatomic) NSString      *executiveCourt;
@property (strong,nonatomic) NSString      *province;
@property (strong,nonatomic) NSString      *executiveBaiscNo;
@property (strong,nonatomic) NSString      *filingTime;
@property (strong,nonatomic) NSString      *caseNo;
@property (strong,nonatomic) NSString      *executiveArm;
@property (strong,nonatomic) NSString      *legalObligation;
@property (strong,nonatomic) NSString      *executiveCase;
@property (strong,nonatomic) NSString      *executed ;
@property (strong,nonatomic) NSString      *unExecuted ;
@property (strong,nonatomic) NSString      *specificSituation;
@property (strong,nonatomic) NSString      *releaseTime;
@property (strong,nonatomic) NSString      *corpLegalPerson;
@property (nonatomic, assign) BOOL isSelected;

@end
