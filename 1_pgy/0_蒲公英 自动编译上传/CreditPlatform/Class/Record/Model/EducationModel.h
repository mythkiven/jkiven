//
//  EducationModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */


#import <Foundation/Foundation.h>
@class StudentStatusInfo,EducationInfo;
@interface EducationModel : NSObject

/** 学籍信息 */
@property (copy,nonatomic) NSDictionary * studentStatusInfo;
/** 学历信息 */
@property (copy,nonatomic) NSDictionary * educationInfo;

@property (strong,nonatomic) StudentStatusInfo *SStudentStatusInfo;
@property (strong,nonatomic) EducationInfo *EEducationInfo;

@end


@interface  StudentStatusInfo: NSObject

/**  姓名 */
@property (copy,nonatomic) NSString  * name;
/**   性别*/
@property (copy,nonatomic) NSString  * sex;
/**身份证号*/
@property (copy,nonatomic) NSString  * identityNo;

/**个人照片*/
@property (copy,nonatomic) NSString  * personalPhotos;
/**民族*/
@property (copy,nonatomic) NSString  * nation;
/**出生日期*/
@property (copy,nonatomic) NSString  * dateBirth;

/**考生号*/
@property (copy,nonatomic) NSString  * stuNumber;
/**学号*/
@property (copy,nonatomic) NSString  * candidateNumber;
/**院校名*/
@property (copy,nonatomic) NSString  * schoolName;

/**分院*/
@property (copy,nonatomic) NSString  * branch;
/**系*/
@property (copy,nonatomic) NSString  * department;
/**专业*/
@property (copy,nonatomic) NSString  * specialitieName;

/**班级*/
@property (copy,nonatomic) NSString  * classes;
/**层*/
@property (copy,nonatomic) NSString  * arrangement;
/**学制*/
@property (copy,nonatomic) NSString  * educationalSystem;

/**学历类别*/
@property (copy,nonatomic) NSString  * educationType;
/**学习形式*/
@property (copy,nonatomic) NSString  * learningForm;
/**入学日期*/
@property (copy,nonatomic) NSString  * timeEnrollment;

/**离校日期*/
@property (copy,nonatomic) NSString  * dateGraduation;
/**学籍状态*/
@property (copy,nonatomic) NSString  * enrollmentStatus;

@end




@interface  EducationInfo: NSObject

/**  姓名 */
@property (copy,nonatomic) NSString  * name;
/**  性别 */
@property (copy,nonatomic) NSString  * sex;
/**身份证号*/
@property (copy,nonatomic) NSString  * identityNo;

/**个人照片*/
@property (copy,nonatomic) NSString  * personalPhotos;
/**出生日期*/
@property (copy,nonatomic) NSString  * dateBirth;
/**入学日期*/
@property (copy,nonatomic) NSString  * timeEnrollment;

/**毕业时间*/
@property (copy,nonatomic) NSString  * dateGraduation;
/**学历类别*/
@property (copy,nonatomic) NSString  * educationType;
/**层次*/
@property (copy,nonatomic) NSString  * arrangement;

/**院校名称*/
@property (copy,nonatomic) NSString  * schoolName;
/**院校所在地*/
@property (copy,nonatomic) NSString  * schoolDistrict;
/**专业名称*/
@property (copy,nonatomic) NSString  * specialitieName;

/**学习形式*/
@property (copy,nonatomic) NSString  * learningForm;
/**证书编号*/
@property (copy,nonatomic) NSString  * certificateNumber;
/**毕结业结论*/
@property (copy,nonatomic) NSString  * graduationStatus;


@end







