//
//  ApplicationState.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/29/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ApplicationState : NSManagedObject

@property (nonatomic, retain) NSNumber * alertStateOnOff;
@property (nonatomic, retain) NSDate * lastUpdated;

@end
