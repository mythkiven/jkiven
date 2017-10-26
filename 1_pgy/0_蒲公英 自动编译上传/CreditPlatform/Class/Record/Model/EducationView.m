//
//  EducationView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/18.
//  weakright © 2016年 kangcheng. All rights reserved.
//

#import "EducationView.h"

#import "EducationModel.h"

@interface EducationView()
// 学籍
/**个人照片*/
@property (weak,nonatomic) IBOutlet UIImageView  * personalPhotosT;

/**  姓名 */
@property (weak,nonatomic) IBOutlet UILabel  * nameT;
/**   性别*/
@property (weak,nonatomic) IBOutlet UILabel  * sexT;
/**民族*/
@property (weak,nonatomic) IBOutlet UILabel  * nationT;
/**出生日期*/
@property (weak,nonatomic) IBOutlet UILabel  * dateBirthT;
/**身份证号*/
@property (weak,nonatomic) IBOutlet UILabel  * identityNoT;
/**层*/
@property (weak,nonatomic) IBOutlet UILabel  * arrangementT;

/**学制*/
@property (weak,nonatomic) IBOutlet UILabel  * educationalSystemT;
/**学历类别*/
@property (weak,nonatomic) IBOutlet UILabel  * educationTypeT;
/**学习形式*/
@property (weak,nonatomic) IBOutlet UILabel  * learningFormT;
/**学籍状态*/
@property (weak,nonatomic) IBOutlet UILabel  * enrollmentStatusT;
/**院校名*/
@property (weak,nonatomic) IBOutlet UILabel  * schoolNameT;
/**分院*/
@property (weak,nonatomic) IBOutlet UILabel  * branchT;
/**系*/
@property (weak,nonatomic) IBOutlet UILabel  * departmentT;
/**专业*/
@property (weak,nonatomic) IBOutlet UILabel  * specialitieNameT;
/**考生号*/
@property (weak,nonatomic) IBOutlet UILabel  * stuNumberT;
/**学号*/
@property (weak,nonatomic) IBOutlet UILabel  * candidateNumberT;
/**班级*/
@property (weak,nonatomic) IBOutlet UILabel  * classesT;
/**入学日期*/
@property (weak,nonatomic) IBOutlet UILabel  * timeEnrollmentT;
/**离校日期*/
@property (weak,nonatomic) IBOutlet UILabel  * dateGraduationT;








//学历
/**个人照片*/
@property (weak,nonatomic) IBOutlet UIImageView  * personalPhotos;

/**  姓名 */
@property (weak,nonatomic) IBOutlet UILabel  * name;
/**  性别 */
@property (weak,nonatomic) IBOutlet UILabel  * sex;
///**身份证号*/
//@property (weak,nonatomic) IBOutlet UILabel  * identityNo;

/**出生日期*/
@property (weak,nonatomic) IBOutlet UILabel  * dateBirth;
/**入学日期*/
@property (weak,nonatomic) IBOutlet UILabel  * timeEnrollment;
/**毕业时间*/
@property (weak,nonatomic) IBOutlet UILabel  * dateGraduation;
/**院校所在地*/
@property (weak,nonatomic) IBOutlet UILabel  * schoolDistrict;
/**毕结业结论*/
@property (weak,nonatomic) IBOutlet UILabel  * graduationStatus;
/**证书编号*/
@property (weak,nonatomic) IBOutlet UILabel  * certificateNumber;
/**院校名称*/
@property (weak,nonatomic) IBOutlet UILabel  * schoolName;
/**专业名称*/
@property (weak,nonatomic) IBOutlet UILabel  * specialitieName;
/**学习形式*/
@property (weak,nonatomic) IBOutlet UILabel  * learningForm;
/**学历类别*/
@property (weak,nonatomic) IBOutlet UILabel  * educationType;
/**层次*/
@property (weak,nonatomic) IBOutlet UILabel  * arrangement;





@property (weak, nonatomic) IBOutlet UILabel *NoData;



@end
@implementation EducationView

+ (instancetype)educationViewTop {
    return [[[NSBundle mainBundle] loadNibNamed:@"EducationView" owner:self options:nil] firstObject];
}
//+ (instancetype)educationViewDown {
//    return [[[NSBundle mainBundle] loadNibNamed:@"EducationView" owner:nil options:nil] lastObject];
//}

// 学籍
-(void)setXjmodel:(StudentStatusInfo *)xjmodel{
    _xjmodel = xjmodel;
    if (xjmodel.personalPhotos.length>1) {
        NSData *imgData = [[NSData alloc]initWithBase64EncodedString:xjmodel.personalPhotos options:0];
        _personalPhotosT.image = [UIImage imageWithData:imgData];
    }
    
    _nameT.text = [NSString spaceString:xjmodel.name];
    _sexT.text = [NSString spaceString:xjmodel.sex];
    _identityNoT.text = [NSString spaceString:xjmodel.identityNo];
    
//    _personalPhotosT.image = [UIImage imageWithData:imgData];
    _nationT.text = [NSString spaceString:xjmodel.nation];
    _dateBirthT.text = [NSString spaceString:xjmodel.dateBirth];
    
    _stuNumberT.text = [NSString spaceString:xjmodel.stuNumber];
    _candidateNumberT.text = [NSString spaceString:xjmodel.candidateNumber];
    _schoolNameT.text = [NSString spaceString:xjmodel.schoolName];
    
    _branchT.text = [NSString spaceString:xjmodel.branch];
    _departmentT.text =[NSString spaceString:xjmodel.department];
    _specialitieNameT.text = [NSString spaceString:xjmodel.specialitieName];
    
    _classesT.text = [NSString spaceString:xjmodel.classes];
    _arrangementT.text = [NSString spaceString:xjmodel.arrangement];
    _educationalSystemT.text =[NSString spaceString:xjmodel.educationalSystem];
    
    _educationTypeT.text = [NSString spaceString:xjmodel.educationType];
    _learningFormT.text = [NSString spaceString:xjmodel.learningForm];
    _timeEnrollmentT.text = [NSString spaceString:xjmodel.timeEnrollment];
    
    _dateGraduationT.text = [NSString spaceString:xjmodel.dateGraduation];
    _enrollmentStatusT.text = [NSString spaceString:xjmodel.enrollmentStatus];
    
    
}
-(void)setXmodel:(EducationInfo *)xmodel{
    _xmodel = xmodel;
    if (!xmodel |(!xmodel.name && !xmodel.sex && !xmodel.schoolName && !xmodel.schoolName && !xmodel.timeEnrollment)) {
        _NoData.hidden =NO;
        return;
    }else{
        _NoData.hidden =YES;
    }
    
    
    if (xmodel.personalPhotos.length>1) {
        NSData *imgData = [[NSData alloc]initWithBase64EncodedString:xmodel.personalPhotos options:0];
        _personalPhotos.image = [UIImage imageWithData:imgData];
    }
    
    
    _name.text = [NSString spaceString:xmodel.name];
    _sex.text = [NSString spaceString:xmodel.sex];
//    _identityNo.text = xmodel.identityNo;
    
//    _personalPhotos.image = [UIImage imageWithData:imgData];
    _dateBirth.text = [NSString spaceString:xmodel.dateBirth];
    _timeEnrollment.text = [NSString spaceString:xmodel.timeEnrollment];
    
    _dateGraduation.text = [NSString spaceString:xmodel.dateGraduation];
    _educationType.text =[NSString spaceString: xmodel.educationType];
    _arrangement.text = [NSString spaceString:xmodel.arrangement];
    
    _schoolName.text = [NSString spaceString:xmodel.schoolName];
    _schoolDistrict.text =[NSString spaceString: xmodel.schoolDistrict];
    _specialitieName.text = [NSString spaceString:xmodel.specialitieName];
    
    _learningForm.text = [NSString spaceString:xmodel.learningForm];
    _certificateNumber.text = [NSString spaceString:xmodel.certificateNumber];
    _graduationStatus.text = [NSString spaceString:xmodel.graduationStatus];
    
    

}

@end
