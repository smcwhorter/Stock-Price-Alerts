//
//  SPAAppUtilies.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/10/13.
//
//

#import <Foundation/Foundation.h>

@interface SPAAppUtilies : NSObject

+(NSDecimalNumber*)convertStringToDecimal:(NSString*)thisStringValue;
+(NSInteger*) convertStringToNumber:(NSString*)thisStringValue;
@end
