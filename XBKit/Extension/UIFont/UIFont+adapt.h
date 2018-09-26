

#import <UIKit/UIKit.h>

@interface UIFont (adapt)

/**
 自适应标准字体

 @param fontSize 字体大小
 @return 标准字体
 */
+ (__kindof UIFont *)systemFontOfAutoSize:(CGFloat)fontSize;


/**
 自适应粗体

 @param fontSize 字体大小
 @return 粗字体
 */
+ (__kindof UIFont *)boldFontOfAutoSize:(CGFloat)fontSize;

/**
 自适应字体
 
 @param fontName 字体名称
 @param size 字体大小
 @return 字体
 */
+ (__kindof UIFont *)fontWithName:(NSString *)fontName autoSize:(CGFloat)size;


/**
 根据机型调整数值(±2)

 @param fontSize 数值
 @return 调整后的数值
 */
+ (CGFloat)fontSizeWithSize:(CGFloat)fontSize;

@end
