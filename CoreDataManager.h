//
//  CoreDataController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/12/13.
//
//

@class Stock;
@class PriceHistory;
#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

+ (id)sharedManager;

-(NSArray *) stockList;
-(void) saveStockWithDetails:(NSArray *)theStockDetails withUserEnteredValues:(NSArray*)highLowNumOfShares;
-(void) updateStockListWithPriceHistoryData:(NSMutableDictionary*)stockListData;
-(NSInteger*)stockEntityCount;
@end
