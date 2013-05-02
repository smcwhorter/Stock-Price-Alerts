//
//  CoreDataController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/12/13.
//
//

#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "SPAAppUtilies.h"
#import "Stock.h"
#import "PriceHistory.h"
#import "AppDelegate.h"

@implementation CoreDataManager
@synthesize managedObjectContext;

#pragma mark - Class Methdos
+ (id)sharedManager{
    static CoreDataManager *shareCoreDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCoreDataManager = [[self alloc] init];
    });
    return shareCoreDataManager;
}

#pragma mark - Public methods
-(id) init{
    AppDelegate *appDelegate = [[NSApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    return  self;
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


//TODO: refactor
-(void)saveStockWithDetails:(NSArray *)theStockDetails withUserEnteredValues:(NSArray*)highLowNumOfShares
{
    Stock *newStock = [self getStockManagedObjectWithDefaultData];
    [self setHighLowNumOfShareAttributes:highLowNumOfShares forStock:newStock];
    [self setStockObject:newStock additionalAttributes:theStockDetails];
}


-(void) updateStockListWithPriceHistoryData:(NSMutableDictionary*)stockListData
{
    for(id stockSymbolKey in [stockListData allKeys])
    {
        //Update Stock
        Stock *stockAsManagedObject = [self fetchStockEnityFor:stockSymbolKey];
        if(stockAsManagedObject != nil)
        {
            NSArray *stockData = [stockListData objectForKey:stockSymbolKey];
            [self setStockObject:stockAsManagedObject additionalAttributes:stockData];
            
            //Save Price History
            PriceHistory *newPriceHistory = [self getPriceHistorManagedObjectWithDefaultData];
            [self setPriceHistoryForObject:newPriceHistory usingStockData:stockData];
        }
    }
    
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

#pragma mark - Private Methods

#pragma mark - Stock Methods
//Returns an empty stock object
-(Stock*) getStockManagedObjectWithDefaultData{
    Stock *newStock = (Stock *)[NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:managedObjectContext];
    return newStock;
}

//Returns an empty stock object
-(PriceHistory*) getPriceHistorManagedObjectWithDefaultData{
    PriceHistory *newPriceHistory = (PriceHistory *)[NSEntityDescription insertNewObjectForEntityForName:@"PriceHistory" inManagedObjectContext:managedObjectContext];
    return newPriceHistory;
}

-(void) setHighLowNumOfShareAttributes:(NSArray*)priceShareData forStock:(Stock*)theStock
{
    theStock.highPriceAlert = [SPAAppUtilies convertStringToDecimal:priceShareData[0]];
    theStock.lowPriceAlert = [SPAAppUtilies convertStringToDecimal:priceShareData[1]];
    theStock.numberOfOwnedShares = [SPAAppUtilies convertStringToNumber:priceShareData[2]];
}

- (void)setStockObject:(Stock *)newStock additionalAttributes:(NSArray *)theStockAttributes
{
    if([theStockAttributes count] >= 10){
        [self setStockWithMoreAttributes:theStockAttributes newStock:newStock];
    }else{
        [self setStockObjectWithLessAttributes:theStockAttributes newStock:newStock];
    }
}

- (void)setStockWithMoreAttributes:(NSArray *)theStockDetails newStock:(Stock *)newStock
{
    newStock.symbol = (NSString *)[theStockDetails objectAtIndex:0];
    newStock.companyName = (NSString *)[theStockDetails objectAtIndex:1];
    
    newStock.currentPrice = [NSDecimalNumber decimalNumberWithString:[theStockDetails objectAtIndex:4]];
    newStock.priceRange = (NSString *)[theStockDetails objectAtIndex:7];
    //Trim extra data from precent change
    NSString *percentChange = (NSString *)[theStockDetails objectAtIndex:8];
    newStock.percentChange = [percentChange substringFromIndex:3];
    newStock.targetPrice = (NSString *)[theStockDetails objectAtIndex:9];
}

- (void)setStockObjectWithLessAttributes:(NSArray *)theStockDetails newStock:(Stock *)newStock
{
    newStock.symbol = (NSString *)[theStockDetails objectAtIndex:0];
    newStock.companyName = (NSString *)[theStockDetails objectAtIndex:1];
    
    newStock.currentPrice = [NSDecimalNumber decimalNumberWithString:[theStockDetails objectAtIndex:3]];
    newStock.priceRange = (NSString *)[theStockDetails objectAtIndex:6];
    NSString *percentChange = (NSString *)[theStockDetails objectAtIndex:7];
    //Trim extra data from precent change
    newStock.percentChange = [percentChange substringFromIndex:3];
    newStock.targetPrice = (NSString *)[theStockDetails objectAtIndex:8];
}


#pragma mark - Price History
-(void) setPriceHistoryForObject:(PriceHistory*)priceHistoryObject usingStockData:(NSArray*)theStockDetails
{
     if([theStockDetails count] >= 10){
         [self setPriceHistoryWithMoreAttributes:theStockDetails forPriceHistoryObject:priceHistoryObject];
     }else{
         [self setPriceHistoryWithLessAttributes:theStockDetails forPriceHistoryObject:priceHistoryObject];
     }
}

-(void) setPriceHistoryWithMoreAttributes:(NSArray*)stockAttributes forPriceHistoryObject:(PriceHistory*)phObject
{
    NSString *priceValue = [[NSDecimalNumber decimalNumberWithString:[stockAttributes objectAtIndex:4]] stringValue];
    NSString *percentChange = (NSString *)[stockAttributes objectAtIndex:8];
    
    phObject.symbol = stockAttributes[0];
    phObject.price = [priceValue doubleValue];
    phObject.percentChanged = [percentChange substringFromIndex:3];
    phObject.logDate = [[NSDate date] timeIntervalSince1970];

}

-(void) setPriceHistoryWithLessAttributes:(NSArray*)stockAttributes forPriceHistoryObject:(PriceHistory*)phObject
{
    NSString *priceValue = [[NSDecimalNumber decimalNumberWithString:[stockAttributes objectAtIndex:3]] stringValue];
    NSString *percentChange = (NSString *)[stockAttributes objectAtIndex:7];
    
    phObject.symbol = stockAttributes[0];
    phObject.price = [priceValue doubleValue];
    phObject.percentChanged = [percentChange substringFromIndex:3];
    phObject.logDate = [[NSDate date] timeIntervalSince1970];
    
}

#pragma mark - Fetch Request
-(Stock*)fetchStockEnityFor:(NSString*)stockSymbol
{
    NSError * error;
    Stock *entity = nil;
    NSFetchRequest * fetchRequest = [self createFetchRequestForEnity:@"Stock"];
    
    // check whether the entity exists or not
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"symbol == %@", stockSymbol]];
    
    // if get a entity, that means exists, so fetch it.
    if ([managedObjectContext countForFetchRequest:fetchRequest error:&error])
    {
        entity = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    }
    
    return entity;
}

-(NSFetchRequest*) createFetchRequestForEnity:(NSString*) enityName
{
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:enityName inManagedObjectContext:managedObjectContext]];
    [fetchRequest setFetchLimit:1];
    return fetchRequest;
}

@end
