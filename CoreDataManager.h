//
//  CoreDataController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/12/13.
//
//

@class Stock;
#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

+ (id)sharedManager;

-(Stock*) getStockObjectWithEmptyData;
-(void) saveStockUsingManagedObject:(Stock*)stockObject;
-(NSInteger*)stockEntityCount;
@end
