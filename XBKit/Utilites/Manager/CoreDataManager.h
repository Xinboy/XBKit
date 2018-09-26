//
//  CoreDataManager.h
//  CoreDataDemo
//
//  Created by Xinbo Hong on 2017/6/10.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//本地文件存储位置
#define CoreDataPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sqlite.db"]

#define ModelName @"Model"
@interface CoreDataManager : NSObject
{
    //数据模型对象
    NSManagedObjectModel *managedObjectModel;
    
    //创建本地持久文件对象
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
    //管理数据对象
    NSManagedObjectContext *managedObjectContext;
}

+ (CoreDataManager *)sharedCoreDataManager;

//添加数据
- (BOOL)insertDataWithModelName:(NSString *)modelName setAttributeWithDict:(NSDictionary *)params;

// 查看
/*
 modelName           :实体对象类的名字
 predicateString     :谓词条件
 identifers          :排序字段集合
 ascending           :是否升序
 */
- (NSArray *)selectDataWithModelName:(NSString *)modelName
                     predicateString:(NSString *)predicateString
                                sort:(NSArray *)identifers
                           ascending:(BOOL)ascending;


// 修改
- (BOOL)updateDataWithModelName:(NSString *)modelName
                predicateString:(NSString *)predicateString
             setAttributWithDic:(NSDictionary *)params;

// 删除
- (BOOL)deleteDataWithModelName:(NSString *)modelName
                predicateString:(NSString *)predicateString;


@end
