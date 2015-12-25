//
//  SortOrderCollectionCell.h
//  视图布局Demo
//
//  Created by 李赛 on 15/12/24.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *orderFileName=@"sortOrderArray.plist";
@interface SortOrderCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIView *seperateViewV;
@property (weak, nonatomic) IBOutlet UIView *seperaterViewH;

@end

@interface SortOrderModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, assign) NSInteger tagIndex;///索引，tag为唯一标示

+(void)storeCrackPlistFile:(NSString *)fileName withObject:(id)object;

+(NSMutableArray *)ArrayFromLocalFile;

- (NSDictionary *)dictionaryDescription;
@end