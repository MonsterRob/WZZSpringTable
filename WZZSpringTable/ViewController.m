//
//  ViewController.m
//  WZZSpringTable
//
//  Created by 王召洲 on 16/8/25.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "ViewController.h"


#import "WZZSpringLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) WZZSpringLayout * layout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layout = [[WZZSpringLayout alloc]init];
    self.layout.minimumLineSpacing = 1;
    self.layout.itemSize = CGSizeMake(self.view.bounds.size.width, 44);
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.layout];
    
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CC"];
    collectionV.backgroundColor = [UIColor clearColor];
    
    collectionV.dataSource = self;
    
    [self.view addSubview:collectionV];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CC" forIndexPath:indexPath];
    
    cell.backgroundColor =[UIColor colorWithRed: arc4random_uniform(256)/255.0  green:arc4random_uniform(256)/255.0 blue: arc4random_uniform(256)/255.0 alpha:1 ];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
