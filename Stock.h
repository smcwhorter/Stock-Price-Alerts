//
//  Stock.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Stock : NSManagedObject

@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSDecimalNumber * currentPrice;
@property (nonatomic, retain) NSDecimalNumber * highPriceAlerts;
@property (nonatomic, retain) NSDecimalNumber * lowPriceAlert;
@property (nonatomic, retain) NSNumber * numberOfOwnedShares;
@property (nonatomic, retain) NSString * percentChange;
@property (nonatomic, retain) NSString * priceRange;
@property (nonatomic, retain) NSString * symbol;

@end
