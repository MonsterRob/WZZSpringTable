//
//  WZZSpringLayout.m
//  WZZSpringTable
//
//  Created by 王召洲 on 16/8/25.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZSpringLayout.h"

@interface WZZSpringLayout ()
@property (strong,nonatomic) UIDynamicAnimator * animator;
@end
@implementation WZZSpringLayout

-(void)prepareLayout {
    [super prepareLayout];
    
    if (!_animator) {
        
        _animator = [[UIDynamicAnimator alloc]initWithCollectionViewLayout:self];
        
        // 获取内容视图大小
        CGSize contextSize = [self collectionViewContentSize];
        // 获取视图内所有cell 的属性
        // 调用父类方法 获取属性
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contextSize.width, contextSize.height)];
        // 给  属性绑定行为
        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *attachAttr = [[UIAttachmentBehavior alloc]initWithItem:item attachedToAnchor:item.center];
            attachAttr.length = 0;
            attachAttr.frequency = 0.8;
            attachAttr.damping = 0.5;
            [_animator addBehavior:attachAttr];// 由 _animator 负责管理每个行为
            
        }
    }
}

// 由animator 负责提供
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [_animator itemsInRect:rect];
}


//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"iiiiii_____");
//    return [_animator layoutAttributesForCellAtIndexPath:indexPath];
//}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    UICollectionView *scrollView = self.collectionView;
    
    // 每次滚动距离
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    
    // 触点位置
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    // 遍历
    for (UIAttachmentBehavior *spring in _animator.behaviors) {
        
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanchFromTouch = fabsl(touchLocation.y - anchorPoint.y);
        
        CGFloat scrollResistance = distanchFromTouch/500;
        
        // 获取行为绑定的属性
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        
        CGPoint center = item.center;
        
        center.y += (delta> 0) ? MIN(delta, delta * scrollResistance):MAX(delta, delta * scrollResistance);
        
        item.center = center;
        [_animator updateItemUsingCurrentState:item];
    }
    
    return NO;
}
@end
