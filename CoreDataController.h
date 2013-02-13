//
//  CoreDataController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/12/13.
//
//

#import <Foundation/Foundation.h>

@interface CoreDataController : NSObject
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

-(void)addStockEnitiy;
@end
