//
//  main.m
//  BlockDemo
//
//  Created by qingyun on 15-1-27.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

int globalVal = 100;

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // 代码块的定义, 注意：此处的逻辑不会被执行，在调用的时候才会执行
        void(^demoBlock)(void) = ^{
            printf("Hello, C!\n");
            NSLog(@"Hello, OC!");
        };
        
        // 1.代码块的直接调用
        demoBlock();
        
        
        // 2.代码块的内联时用
        NSArray *array = @[@"2",@"4",@"1",@"7"];
        
        NSLog(@"unsorted:%@", array);
        
        NSArray *array1 = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            return [obj1 compare:obj2];
        }];
        NSLog(@"sorted:%@", array1);
        
        // 用代码块实现一个加法
        // 关于参数和返回值的一些省略做法
        // 1.如果代码块不适用于传参数，可以将参数列表省略
        // 2.代码块中有return语句，那么代码块的返回值类型就是return值的类型，可省略返回值类型
        // 3.返回值省略时，表达式若有多个return，则所有return返回值的类型必须相同
        
        int (^quare_block)(int number1, int number2) = ^(int number1, int number2){
            return number1+number2;
        };
        
        NSLog(@">>>>>>%d",quare_block(10,20));
        
        // 使用typedef来定义一个相同类型的代码块类型
        typedef int (^QingYunQuareBlock)(int a, int b);
        
        QingYunQuareBlock mulitply = ^(int a, int b){return a*b;};//乘
        NSLog(@">>>>>>%d",mulitply(10,20));
        QingYunQuareBlock divide = ^(int a, int b){return a/b;};//除
        NSLog(@">>>>>>%d",divide(100,20));

        QingYunQuareBlock add = ^(int a, int b){return a+b;};//+
        NSLog(@">>>>>>%d",add(10,20));
        QingYunQuareBlock cut = ^(int a, int b){return a-b;};//-
        NSLog(@">>>>>>%d",cut(100,20));
        
        
        
        
        // 测试代码块对变量的处理
        
        // 局部变量，在定义代码块的时候获取局部变量的一个快照，所以不能在代码块内部改变此变量
        __block int inVal = 50;
        void (^testValBlock)() = ^{
            inVal++;
            NSLog(@"<<<<<<<<<<<inVal>>>>>>>%d", inVal);
        };
        //inVal++;
        testValBlock();
        
        
        // 全局变量，可以在代码块内部进行改变操作
        void (^testValBlock1)() = ^{
            globalVal++;
            NSLog(@"globalVal>>>>>>>%d", globalVal);
        };
        testValBlock1();
        
        // 静态变量，可以直接在在代码块内部进行改变操作
        static int staVal = 80;
        void (^testValBlock2)() = ^{
            staVal++;
            NSLog(@"staVal>>>>>>>%d", staVal);
        };
        testValBlock2();
        
    }
    return 0;
}

