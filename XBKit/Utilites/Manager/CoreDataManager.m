//
//  CoreDataManager.m
//  CoreDataDemo
//
//  Created by Xinbo Hong on 2017/6/10.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        NSError *error;
        
        NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:ModelName withExtension:@"model"];
        managedObjectModel =  [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
        
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
        
        NSURL *fileUrl = [NSURL fileURLWithPath:CoreDataPath];
        [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileUrl options:nil error:&error];
        
        managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
        
    }
    return self;
}

+ (CoreDataManager *)sharedCoreDataManager
{
    static CoreDataManager *coreDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataManager = [[CoreDataManager alloc] init];
    });
    return coreDataManager;
}

- (BOOL)insertDataWithModelName:(NSString *)modelName setAttributeWithDict:(NSDictionary *)params
{
//    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:modelName inManagedObjectContext:managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:modelName inManagedObjectContext:managedObjectContext];
    
    
    for (NSString *key in params) {
        SEL seletor = [self selWithKeyName:key];
        if ([entity respondsToSelector:seletor]) {
            [entity performSelector:seletor withObject:params[key]];
        }
    }
    [managedObjectContext insertObject:entity];
    
    return [managedObjectContext save:nil];
    

}

// 通过一个字符串反回一个set方法
- (SEL)selWithKeyName:(NSString *)keyName
{
    NSString *first = [[keyName substringToIndex:1] uppercaseString];
    NSString *end = [keyName substringFromIndex:1];
    NSString *selString = [NSString stringWithFormat:@"set%@%@:",first,end];
    return NSSelectorFromString(selString);
}


@end
