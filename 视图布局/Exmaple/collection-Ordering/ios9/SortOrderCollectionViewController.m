//
//  SortOrderCollectionViewController.m
//  视图布局Demo
//
//  Created by 李赛 on 15/12/22.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "SortOrderCollectionViewController.h"
#import "SortOrderCollectionCell.h"

@interface SortOrderCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UILongPressGestureRecognizer *longPressGesture;
}
@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic, strong) SortOrderCollectionCell *vCell;
@end

@implementation SortOrderCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _numberArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i=0; i<16; i++) {
        SortOrderModel *model=[[SortOrderModel alloc]init];
        model.tagIndex=i;
        model.name=[NSString stringWithFormat:@"芈月传%@",@(i)];
        model.iconUrl=@"http://url.芈月传.com";
        NSDictionary *dict=[model dictionaryDescription];
        [_numberArray addObject:dict];
    }
    [SortOrderModel storeCrackPlistFile:orderFileName withObject:_numberArray];
    self.contentCollectionView.delegate=self;
    self.contentCollectionView.dataSource=self;
    longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongpressGesture:)];
    [self.contentCollectionView addGestureRecognizer:longPressGesture];
    // Do any additional setup after loading the view.
}

-(void)handleLongpressGesture:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    if(gesture.state == UIGestureRecognizerStateBegan)
        
    {
        NSIndexPath *selectedIndexPath = [_contentCollectionView indexPathForItemAtPoint:[gesture locationInView:self.contentCollectionView]];
        _vCell=(SortOrderCollectionCell*)[_contentCollectionView cellForItemAtIndexPath:selectedIndexPath];
        _vCell.seperaterViewH.hidden=YES;
        _vCell.seperateViewV.hidden=YES;
        _vCell.layer.masksToBounds=YES;
        _vCell.layer.borderWidth=1;
        _vCell.layer.borderColor=[UIColor redColor].CGColor;
       [_contentCollectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
    }
    
    else if(gesture.state == UIGestureRecognizerStateEnded)
        
    {
        _vCell.seperaterViewH.hidden=NO;
        _vCell.seperateViewV.hidden=NO;
        _vCell.layer.masksToBounds=NO;
        _vCell.layer.borderWidth=0;
        _vCell.layer.borderColor=[UIColor clearColor].CGColor;
        [self.contentCollectionView endInteractiveMovement];
        
    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        [self.contentCollectionView updateInteractiveMovementTargetPosition:point];
    }else
    {
        [self.contentCollectionView cancelInteractiveMovement];
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _numberArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SortOrderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SortOrderCollectionCell" forIndexPath:indexPath];
        // Configure the cell
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width=self.view.frame.size.width/3;
    return  CGSizeMake(width,width);
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    SortOrderModel *sourceModel=[_numberArray objectAtIndex:sourceIndexPath.item];
    [_numberArray removeObjectAtIndex:sourceIndexPath.item];
    [_numberArray insertObject:sourceModel atIndex:destinationIndexPath.item];
    [SortOrderModel storeCrackPlistFile:orderFileName withObject:_numberArray];
}

@end
