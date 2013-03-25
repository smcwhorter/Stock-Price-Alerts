//
//  PriceHistory.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/16/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PriceHistory : NSManagedObject

@property (nonatomic) NSTimeInterval logDate;
@property (nonatomic, retain) NSString * percentChanged;
@property (nonatomic) double price;
@property (nonatomic, retain) NSString * symbol;

@end
