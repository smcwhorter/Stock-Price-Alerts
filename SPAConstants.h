//
//  SPAConstants.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/20/13.
//
//

typedef enum {
    noData = 1,
    StockSearchData,
    AdditionalDetailsData
} StockDownloadDataType;

#import <Foundation/Foundation.h>


//Constant strings
extern NSString *const STOCK_DATA_MAIN_URL;
extern NSString *const STOCK_DATA_MAIN_URL_SUFFIX;
extern NSString *const STOCK_SEARCH_MAIN_URL;
extern NSString *const STOCK_SEARCH_MAIN_URL_SUFFIX;

@interface SPAConstants : NSObject

@end
