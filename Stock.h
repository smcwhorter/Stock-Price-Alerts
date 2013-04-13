//
//  Stock.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/16/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PriceHistory;

@interface Stock : NSManagedObject

@property (nonatomic, retain) NSString * symbol;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSDecimalNumber * currentPrice;
@property (nonatomic, retain) NSDecimalNumber * highPriceAlert;
@property (nonatomic, retain) NSDecimalNumber * lowPriceAlert;
@property (nonatomic) int32_t numberOfOwnedShares;
@property (nonatomic, retain) NSString * percentChange;
@property (nonatomic, retain) NSString * priceRange;
@property (nonatomic, retain) NSString *targetPrice;
@property (nonatomic, retain) PriceHistory *stocksPriceHistory;

@end
