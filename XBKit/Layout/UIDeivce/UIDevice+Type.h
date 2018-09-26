
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PhoneType){
    //iPhone6,6s,7,8
    PhoneTypeDefualt = 1,
    //iPhone6+,6s+,7+,8+
    PhoneTypePlus = 2,
    //iPhone5,5s,5c,se
    PhoneTypeSE = 3,
    //iPhone X
    PhoneTypeX = 4
};

@interface UIDevice (Type)
/**
 是否运行为 iPhone
 */
+ (BOOL)isRunningOniPhone;

+ (NSString *)stringWithDeviceType;

+(PhoneType)phoneTypeWithDevice;
@end
