

#import "UIFont+adapt.h"
#import "UIDevice+Type.h"
#import <objc/message.h>

@implementation UIFont (adapt)

+ (UIFont *)boldFontOfAutoSize:(CGFloat)fontSize {
    return [UIFont boldSystemFontOfSize:[UIFont fontSizeWithSize:fontSize]];
}

+ (UIFont *)systemFontOfAutoSize:(CGFloat)fontSize {

    return [UIFont systemFontOfSize:[UIFont fontSizeWithSize:fontSize]];
}

+ (UIFont *)fontWithName:(NSString *)fontName autoSize:(CGFloat)size {
    return [UIFont fontWithName:fontName size:[UIFont fontSizeWithSize:size]];
}

+ (CGFloat)fontSizeWithSize:(CGFloat)fontSize {
    PhoneType type = [UIDevice phoneTypeWithDevice];
    switch (type) {
        case PhoneTypeDefualt:
            return fontSize;
        case PhoneTypeSE:
            return fontSize - 2;
        case PhoneTypeX:
        case PhoneTypePlus:
            return fontSize + 2;
    }
}


@end
