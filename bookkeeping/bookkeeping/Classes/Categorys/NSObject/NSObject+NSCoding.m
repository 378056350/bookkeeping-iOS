/**
 * 归档
 * @author 郑业强 2019-01-04 创建文件
 */

#import "NSObject+NSCoding.h"
#import <objc/runtime.h>

@implementation NSObject (NSCoding)

+ (id)decodeClass:(id)object decoder:(NSCoder *)aDecoder {
    if (!object) {
        return nil;
    }
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    for (NSInteger i = 0 ; i < count; i ++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *attribute = [NSString stringWithUTF8String:property_getAttributes(property)];
        
        if ([attribute hasPrefix:@"TB"] || [attribute hasPrefix:@"Tc"]) {        // BOOL
            NSNumber *CXLBool_Number = @([aDecoder decodeBoolForKey:key]);
            [object setValue:CXLBool_Number forKey:key];
        } else if ([attribute hasPrefix:@"Tq"]) {                                //int64
            NSNumber *CXLInt64_Number = @([aDecoder decodeInt64ForKey:key]);
            [object setValue:CXLInt64_Number forKey:key];
        } else if ([attribute hasPrefix:@"Ti"]) {                                //int32
            NSNumber *CXLInt32_Nubmer = @([aDecoder decodeInt32ForKey:key]);
            [object setValue:CXLInt32_Nubmer forKey:key];
        } else if ([attribute hasPrefix:@"TQ"] || [attribute hasPrefix:@"TI"]) { //unInteger
            NSNumber *CXLUnInteger_Number = @([aDecoder decodeInt64ForKey:key]);
            [object setValue:CXLUnInteger_Number forKey:key];
        } else if ([attribute hasPrefix:@"Td"]) {                                //double
            NSNumber *CXLDouble_Number = @([aDecoder decodeDoubleForKey:key]);
            [object setValue:CXLDouble_Number forKey:key];
        } else if ([attribute hasPrefix:@"Tf"]) {                                //float
            NSNumber *CXLFloat_Number = @([aDecoder decodeFloatForKey:key]);
            [object setValue:CXLFloat_Number forKey:key];
        } else if ([attribute hasPrefix:@"T@"]) {                                //object
            [object setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        } else {
            [object setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    free(properties);
    
    return object;
}

+ (void)encodeClass:(id)object encoder:(NSCoder *)aCoder {
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    for (NSInteger i = 0 ; i < count; i ++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *attribute = [NSString stringWithUTF8String:property_getAttributes(property)];
        
        if ([attribute hasPrefix:@"TB"] || [attribute hasPrefix:@"Tc"]) {        // BOOL
            NSNumber *CXLBOOL_Number = [object valueForKey:key];
            [aCoder encodeBool:CXLBOOL_Number.boolValue forKey:key];
        } else if ([attribute hasPrefix:@"Tq"]) {                                //int64
            NSNumber *CXLInt64_Number = [object valueForKey:key];
            [aCoder encodeInt64:CXLInt64_Number.integerValue forKey:key];
        } else if ([attribute hasPrefix:@"Ti"]) {                                //int32
            NSNumber *CXLInt32_Number = [object valueForKey:key];
            [aCoder encodeInt32:CXLInt32_Number.intValue forKey:key];
        } else if ([attribute hasPrefix:@"TQ"] || [attribute hasPrefix:@"TI"]) { //unInteger
            NSNumber *CXLUninteger_Number = [object valueForKey:key];
            [aCoder encodeInt64:CXLUninteger_Number.integerValue forKey:key];
        } else if ([attribute hasPrefix:@"Td"]) {                                //double
            NSNumber *CXLDouble_Number = [object valueForKey:key];
            [aCoder encodeDouble:CXLDouble_Number.doubleValue forKey:key];
        } else if ([attribute hasPrefix:@"Tf"]) {                                //float
            NSNumber *CXLFloat_Number = [object valueForKey:key];
            [aCoder encodeFloat:CXLFloat_Number.floatValue forKey:key];
        } else if ([attribute hasPrefix:@"T@"]) {                                //object
            [aCoder encodeObject:[object valueForKey:key] forKey:key];
        } else {
            [aCoder encodeObject:[object valueForKey:key] forKey:key];
        }
        
    }
    free(properties);
}

@end
