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

-(id) init{
    AppDelegate *appDelegate = [[NSApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    return  self;
}

-(void) addStockEnitiy{
    //Create a stock entity
    NSManagedObject *stock = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:managedObjectContext];
    //Set the stock entity attributes
    [stock setValue:@"Apple" forKey:@"symbol"];
}

-(NSInteger*) stockEntityCount{
    //NSManagedObjectContext *moc = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Stock"
                                              inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }else{
        return array.count;
    }
    return 0;

}
@end
