//
//  MyTabBar.m
//  baby
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 zhang da. All rights reserved.
//

#import "MyTabBar.h"
#import "FWBTarBarButton.h"

@interface MyTabBar ()

@property (nonatomic,strong) UIButton * selectedButton;

@end
@implementation MyTabBar

//- (id)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        NSArray * titleArr = @[@"广场",@"推荐",@"加号",@"原创",@"我的"];
//        
//        NSArray * imageArr = @[@"home_tab_onlineedu_normal.png",@"home_tab_my_normal.png",@"tabbar_centerAdd.png",@"orginal_normal.png",@"my_normal.png"];
//        NSArray * selectImgArr = @[@"home_tab_onlineedu_selected.png",@"home_tab_my_selected.png",@"tabbar_centerAdd.png",@"orginal_selected",@"my_selected.png"];
//        
//        CGFloat btnW = KScreenWidth/titleArr.count;
//        CGFloat btnH = 49;
//        
//        for (int i = 0; i < titleArr.count; i++) {
//            
//            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            
//            CGFloat btnX = i*btnW;
//            
//            btn.frame = CGRectMake(btnX, 0, btnW, btnH);
//            
//            
//            
//            if (i != titleArr.count/2) {
//                
//                UIImage * nomalImg = [UIImage imageAutomaticName:imageArr[i]];
//                UIImage * selectImg = [UIImage imageAutomaticName:selectImgArr[i]];
//                
//                [btn setImage:nomalImg forState:UIControlStateNormal];
//                [btn setImage:selectImg forState:UIControlStateSelected];
//
////                [btn setTitle:titleArr[i] forState:UIControlStateNormal];
//                
//                btn.titleLabel.font = FONT_ADAPTED_NUM(11);
//                
//                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
//                CGFloat moveY = (btnH - nomalImg.size.height)/2;
//                CGSize oneSize = ONE_STR_HEIGHT(11);
//                
//                
//                btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btnW/2+oneSize.width/2, -30, 0);
//                btn.imageEdgeInsets = UIEdgeInsetsMake(-moveY,0,0,0);
//            }else{
//            
//                UIImage * nomalImg = [UIImage imageNamed:imageArr[i]];
//                UIImage * selectImg = [UIImage imageNamed:selectImgArr[i]];
//                
//                [btn setImage:nomalImg forState:UIControlStateNormal];
//                [btn setImage:selectImg forState:UIControlStateSelected];
//
//            }
//            
//            
//            btn.tag = i;
//            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
//            
//            if (i == 0) {
//                [self btnClick:btn];
//            }
//            
//            [self addSubview:btn];
//        }
//    }
//    return self;
//}


- (void)addTarBarButtonWithImageName:(NSString *)name selectedImage:(NSString *)selectedName{
    //创建button
    FWBTarBarButton * button = [FWBTarBarButton buttonWithType:UIButtonTypeCustom];
    
    //设置tag
    button.tag = self.subviews.count;
    
    //设置图片
    [button setImage:[UIImage imageAutomaticName:name] forState:UIControlStateNormal];
    [button setImage:[UIImage imageAutomaticName:selectedName] forState:UIControlStateSelected];
    
    //设置点击响应
    [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    //设置默认选中按钮
    if (button.tag == 0) {
        [self tabBarButtonClick:button];
    }
    
    //添加到tabBar
    [self addSubview:button];
    
}

/**
 *  当界面加载完成后，自动调用此方法设置按钮尺寸
 */
- (void)layoutSubviews{
    
    for (int i = 0; i < self.subviews.count; i++) {
        //取出按钮
        FWBTarBarButton * button = self.subviews[i];
        
        //设置尺寸
        CGFloat buttonW = self.frame.size.width/self.subviews.count;
        CGFloat buttonH = self.frame.size.height;
        CGFloat buttonY = 0;
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
    }
}
/**
 *  设置tabBar的按钮点击事件
 */
- (void)tabBarButtonClick:(FWBTarBarButton *)button{
    
    //通知代理（控制器）
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        [self.delegate tabBar:self didSelectedItemFrom:_selectedButton.tag to:button.tag];
    }
    
    //将上一个选中的按钮selected状态设置为NO
    _selectedButton.selected = NO;
    
    //将本次点击按钮选中状态设为YES
    button.selected = YES;
    
    //将本次点击按钮存储在selectedButton
    _selectedButton = button;
    
}

@end
