//
//  SPAAppUtilies.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/10/13.
//
//

#import <Foundation/Foundation.h>

@interface SPAAppUtilies : NSObject

+(NSColor*) lightGray;
+(NSColor*) darkGray;
+(NSColor*) borderWhite;
+(NSColor*) borderMedium;

+(NSColor*) stockEditDarkGrayStart;
+(NSColor*) stockEditDarkGrayEnd;
+(NSColor*) stockEditGradientStart;
+(NSColor*) stockEditGradientEnd;


+(NSArray*) parseDownloadedDataForSearchResults:(NSData*) theData;


@end
