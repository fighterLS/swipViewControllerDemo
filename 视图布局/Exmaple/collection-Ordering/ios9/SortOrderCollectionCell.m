//
//  SortOrderCollectionCell.m
//  视图布局Demo
//
//  Created by 李赛 on 15/12/24.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "SortOrderCollectionCell.h"
#define plistFilesPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"plistFiles"]
@implementation SortOrderCollectionCell
-(void)awakeFromNib
{

}
@end

@implementation SortOrderModel
- (NSDictionary *)dictionaryDescription
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.name,@"name",self.iconUrl,@"iconUrl",@(self.tagIndex),@"tagIndex", nil];
}
#pragma mark --Helper method--
+(void)storeCrackPlistFile:(NSString *)fileName withObject:(id)object
{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:plistFilesPath])
    {
        [fileManager createDirectoryAtPath:plistFilesPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *plistPath = [plistFilesPath stringByAppendingPathComponent:fileName];
    if (![object writeToFile:plistPath atomically:YES]) {
        NSLog(@"write plist fail");
    }
    
}
+(NSMutableArray *)ArrayFromLocalFile
{
    NSString *plistPath = [plistFilesPath stringByAppendingPathComponent:orderFileName];
    if ([[NSFileManager defaultManager]fileExistsAtPath:plistPath])
    {
        NSMutableArray *localfileArray=[NSMutableArray arrayWithContentsOfFile:plistPath];
        return localfileArray;
    }
    return nil;
}
@end