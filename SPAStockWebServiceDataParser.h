//
//  SPAStockWebServiceDataParser.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 4/27/13.
//
//

#import <Foundation/Foundation.h>

@interface SPAStockWebServiceDataParser : NSObject

+(NSArray*) parseDownloadedDataForSearchResults:(NSData*) theData;
+(NSArray*) parseDownloadedDataForAdditionalData:(NSData *)theData;

@end
