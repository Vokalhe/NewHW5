//
//  ViewController.m
//  Test
//
//  Created by 2 on 01.02.16.
//  Copyright © 2016 1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSMutableArray* runBlocks1;
@property (nonatomic) NSMutableArray* runBlocks2;
@property (nonatomic) NSArray* arrayOfColors;
@property (nonatomic) BOOL isAnimating;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    
    self.view.backgroundColor = [UIColor colorWithRed:24/225.f green:54/225.f blue:66/225.f alpha:1.f];
    
    NSArray *arrayOfColors = @[[UIColor colorWithRed:32/255.f green:87/255.f blue:110/255.f alpha:1.f],
                               [UIColor colorWithRed:70/255.f green:154/255.f blue:184/255.f alpha:1.f],
                               [UIColor colorWithRed:109/255.f green:179/255.f blue:191/255.f alpha:1.f],
                               [UIColor colorWithRed:149/255.f green:207/255.f blue:202/255.f alpha:1.f],
                               [UIColor colorWithRed:207/255.f green:233/255.f blue:244/255.f alpha:1.f],
                               [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.f]
                               ];
    self.runBlocks1 = [[NSMutableArray alloc]init];
    self.runBlocks2 = [[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer
                                         alloc] initWithTarget:self action:@selector(twoTouch)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    for (int i = 0; i < 39; i++) {
        UIView *blocks1 = [[UIView alloc] initWithFrame:(CGRect){3 + 17 * i, 99, 16, 86.5f}];
        blocks1.layer.cornerRadius = 5;
        [self.view addSubview:blocks1];
        
        UIView *blocks2 = [[UIView alloc] initWithFrame:(CGRect){3 + 17 * i, 190, 16, 86.5f}];
        blocks2.layer.cornerRadius = 5;
        [self.view addSubview:blocks2];
        
        switch (i) {
            case 0:
            case 1:
            case 38:
            case 37:
                blocks1.backgroundColor = arrayOfColors[0];
                blocks2.backgroundColor = arrayOfColors[0];
                break;
            case 2:
            case 3:
            case 4:
            case 5:
            case 33:
            case 34:
            case 35:
            case 36:
                blocks1.backgroundColor = arrayOfColors[1];
                blocks2.backgroundColor = arrayOfColors[1];
                break;
            case 6:
            case 7:
            case 8:
            case 9:
            case 29:
            case 30:
            case 31:
            case 32:
                blocks1.backgroundColor = arrayOfColors[2];
                blocks2.backgroundColor = arrayOfColors[2];
                break;
            case 10:
            case 11:
            case 12:
            case 13:
            case 25:
            case 26:
            case 27:
            case 28:
                blocks1.backgroundColor = arrayOfColors[3];
                blocks2.backgroundColor = arrayOfColors[3];
                break;
            case 14:
            case 15:
            case 16:
            case 17:
            case 21:
            case 22:
            case 23:
            case 24:
                blocks1.backgroundColor = arrayOfColors[4];
                blocks2.backgroundColor = arrayOfColors[4];
                break;
            case 18:
            case 19:
            case 20:
                blocks1.backgroundColor = arrayOfColors[5];
                blocks2.backgroundColor = arrayOfColors[5];
                break;
            default:
                break;
        }
        [self.runBlocks1 addObject:blocks1];
        [self.runBlocks2 addObject:blocks2];

    }
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.f, screenHeight/2, screenWidth, 1.f)];
    line.backgroundColor = [[UIColor alloc] initWithRed:84/255.f green:113/255.f blue:125/255.f alpha:1];
    [self.view addSubview:line];
    
        // Do any additional setup after loading the view, typically from a nib.
}

-(void) twoTouch{
    self.isAnimating = YES;
    int i = 1;
    for (UIView *blocks1 in self.runBlocks1) {
        [UIView animateWithDuration:0.5f delay:i*0.025f options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
            CGRect frame = blocks1.frame;
            frame.origin.y = frame.origin.y - 5 - 2.0*i;
            frame.size.height = 90;
            blocks1.frame = frame;
        } completion:nil];
        i++;
    }
    
    i = 1;
    for (UIView *blocks2 in self.runBlocks2) {
        [UIView animateWithDuration:0.5f delay:i*0.025f options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
            CGRect frame = blocks2.frame;
            frame.origin.y = frame.origin.y - 5 - 2.0*i;
            frame.size.height = 90;
            blocks2.frame = frame;
        } completion:nil];
        i++;
    }
}

- (void)oneTouch: (UITouch*) touch {
    if (!self.isAnimating) {
        CGPoint position = [touch locationInView:self.view];
        CGFloat screenHeight = self.view.frame.size.height;
        if (position.y < screenHeight/2) {
            for (UIView *blocks1 in self.runBlocks1){
            if (((CGRectGetMinX(blocks1.frame)<= position.x) && (position.x<= CGRectGetMaxX(blocks1.frame)))){
                       [UIView setAnimationDuration:0.3f];
                        CGRect frame = blocks1.frame;
                        frame.origin.y = position.y;
                        frame.size.height = screenHeight/2 - position.y;
                        blocks1.frame = frame;
                        [UIView commitAnimations];
                }
            }
        }
        else if (position.y > screenHeight/2){
            for (UIView *blocks2 in self.runBlocks2){
                if (((CGRectGetMinX(blocks2.frame)<= position.x) && (position.x<= CGRectGetMaxX(blocks2.frame)))){
                        [UIView setAnimationDuration:0.3f];
                        CGRect frame = blocks2.frame;
                        frame.origin.y = position.y;
                        frame.size.height = screenHeight/2 - position.y;
                        blocks2.frame = frame;
                        [UIView commitAnimations];
                }
            }
        }
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self oneTouch:touch];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self oneTouch:touch];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self oneTouch:touch];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self oneTouch:touch];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
