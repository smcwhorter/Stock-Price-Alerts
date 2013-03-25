//
//  CoreDataController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/12/13.
//
//

#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "Stock.h"
#import "AppDelegate.h"

@implementation CoreDataManager
@synthesize managedObjectContext;

+ (id)sharedManager{
    static CoreDataManager *shareCoreDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCoreDataManager = [[self alloc] init];
    });
    return shareCoreDataManager;
}
-(id) init{
    AppDelegate *appDelegate = [[NSApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    return  self;
}

//Returns an empty stock object
-(Stock*) getStockObjectWithEmptyData{
    Stock *newStock = (Stock *)[NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:managedObjectContext];
    return newStock;
}

-(Stock*) getStockObjectWithDataForSymbol:(NSString*)theSymbol{
    //TODO: Need to query the stock object
    Stock *newStock = (Stock *)[NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:managedObjectContext];
    return newStock;
}

-(void) saveStockUsingManagedObject:(Stock*)stockObject{
    Stock *newStock = (Stock *)[NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:managedObjectContext];
   
    newStock.companyName = @"Compant Name";
    newStock.currentPrice = [NSDecimalNumber decimalNumberWithString:@"10.00"];
    newStock.companyName = @"Company Name";
    newStock.highPriceAlert = [NSDecimalNumber decimalNumberWithString:@"15.00"];
    newStock.lowPriceAlert = [NSDecimalNumber decimalNumberWithString:@"5.00"];
    newStock.numberOfOwnedShares = 10;
    newStock.percentChange = @"10%";
    newStock.priceRange = @"5.00 - 15.00";
    newStock.symbol = @"C";
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"Error: %@",error);
    }
    
}


//Gets the current stock list from core data
-(NSArray *) stockList{
    //NSManagedObjectContext *moc = [self managedObjectContext];
    Stock *newStock = (Stock *) [NSEntityDescription entityForName:@"Stock" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:newStock];
    
    NSError *error;
    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }else{
        return array;
    }
    return nil;
    
}

-(NSInteger*) stockEntityCount{
    //NSManagedObjectContext *moc = [self managedObjectContext];
    Stock *newStock = (Stock *) [NSEntityDescription entityForName:@"Stock" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:newStock];
    
    NSError *error;
    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }else{
        NSLog(@"Stock Count: %li",array.count);
        return array.count;
    }
    return 0;

}
@end
