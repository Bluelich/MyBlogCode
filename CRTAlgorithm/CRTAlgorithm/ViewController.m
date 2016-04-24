//
//  ViewController.m
//  CRTAlgorithm
//
//  Created by 周强 on 16/4/24.
//  Copyright © 2016年 Bluelich. All rights reserved.
//

#import "ViewController.h"

@interface CRTModel : NSObject

@property (assign, nonatomic) NSInteger divider;

@property (assign, nonatomic) NSInteger remain;

+(instancetype)modelWithDivider:(NSInteger)divider
                         remain:(NSInteger)remain;

@end

@implementation CRTModel

+(instancetype)modelWithDivider:(NSInteger)divider remain:(NSInteger)remain
{
    CRTModel *model = [[self alloc] init];
    model.divider = divider;
    model.remain = remain;
    return model;
}

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self teseCRT];
}
-(void)teseCRT
{
    CRTModel *model1 = [CRTModel modelWithDivider:3 remain:2];
    CRTModel *model2 = [CRTModel modelWithDivider:5 remain:3];
    CRTModel *model3 = [CRTModel modelWithDivider:7 remain:2];
    
    NSInteger a = [self getSubMinNumberOfDivider1:model1.divider divider2:model2.divider andDivider3:model3.divider remainOf3:model3.remain];
    NSInteger b = [self getSubMinNumberOfDivider1:model2.divider divider2:model3.divider andDivider3:model1.divider remainOf3:model1.remain];
    NSInteger c = [self getSubMinNumberOfDivider1:model3.divider divider2:model1.divider andDivider3:model2.divider remainOf3:model2.remain];
    
    NSInteger sum = a + b + c;
    NSInteger lcmOfAll = [self lcmOf:model1.divider and:model2.divider and:model3.divider];
    
    NSInteger result = sum - lcmOfAll;
    NSLog(@"总数为：%ld + %ld * k (k为自然数)",result,lcmOfAll);
}
//最大公约数
-(NSInteger)gcdOf:(NSInteger)a and:(NSInteger)b
{
    static const NSInteger(^GCDRecursionBlock)(NSInteger,NSInteger) = ^(NSInteger ra, NSInteger rb){
        if (!ra || !rb) return MAX(ra, rb);
        return GCDRecursionBlock(rb,ra%rb);
    };
    return GCDRecursionBlock(a,b);
}

//最小公倍数
-(NSInteger)lcmOf:(NSInteger)a and:(NSInteger)b
{
    return a * b / [self gcdOf:a and:b]; //最小公倍数等于两数之积除以最大公约数
}
//3个数的最小公倍数
-(NSInteger)lcmOf:(NSInteger)a and:(NSInteger)b and:(NSInteger)c
{
    //更相减损术
    return [self lcmOf:[self lcmOf:a and:b] and:c];
}

-(NSInteger)getSubMinNumberOfDivider1:(NSInteger)divider1
                             divider2:(NSInteger)divider2
                          andDivider3:(NSInteger)divider3
                            remainOf3:(NSInteger)remainOf3
{
    NSInteger minCommonMultiple = [self lcmOf:divider1 and:divider2];
    NSInteger result = minCommonMultiple;
    while ((result % divider3) != remainOf3) {
        result += minCommonMultiple;
    }
    return result;
}
@end
