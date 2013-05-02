//
//  SPAAppUtilies.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/10/13.
//
//

#import "SPAAppUtilies.h"

@implementation SPAAppUtilies

+(NSDecimalNumber*)convertStringToDecimal:(NSString*)thisStringValue{
    NSDecimalNumber *returnvalue = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    if(![thisStringValue isEqualToString:@""]){
        
        returnvalue = [NSDecimalNumber decimalNumberWithString:[thisStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    
    return returnvalue;
}

+(NSInteger*) convertStringToNumber:(NSString*)thisStringValue{
    
    NSInteger *returnValue = 0;
    thisStringValue = [thisStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(![thisStringValue isEqualToString:@""]){
        returnValue = [thisStringValue integerValue];
    }
    
    return returnValue;
}


@end
