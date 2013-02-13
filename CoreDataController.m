//
//  CoreDataController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/12/13.
//
//

#import "CoreDataController.h"
#import "AppDelegate.h"

@implementation CoreDataController
@synthesize managedObjectContext;

-(void) addStockEnitiy{
        NSManagedObject *stock = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Stock"
                                  inManagedObjectContext:nil];
}
@end
