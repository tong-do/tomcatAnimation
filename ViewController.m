//
//  ViewController.m
//  汤姆猫
//
//  Created by tong on 2020/01/20.
//  Second commit
//  Copyright © 2020 tong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewCat;
- (IBAction)drink;
- (IBAction)fart;
- (IBAction)knockout;
- (IBAction)cymbal;
- (IBAction)eat;
- (IBAction)pie;
- (IBAction)scratch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)drink {
    
    if (self.imgViewCat.isAnimating) {
        return;
    }
    
    
    //示范代码，后面动作可以用封装
    //0.动态加载图片到一个NSArray中
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < 81; i++) {
        NSString *imgName = [NSString stringWithFormat:@"drink_%02d.jpg",i];
//        UIImage *imagCat = [UIImage imageNamed:imgName];
        //解决：换种加载图片的方式，不使用缓存，获取图片的完整路径
        NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        //不传递图片名称，传递图片的完整路径
        UIImage *imagCat = [UIImage imageWithContentsOfFile:path];
        [arrayM addObject:imagCat];
    }
    //1.设置UIImageview的animationImages属性，此属性包含那些要执行动画的图片
    self.imgViewCat.animationImages = arrayM;
    //2.设置动画持续时间
    self.imgViewCat.animationDuration = 3;
    //self.imgViewCat.animationDuration = self.imgViewCat.animationImages.count * 0.1;
    //3.设置动画是否需要重复播放(不设置的话会一直循环)
    self.imgViewCat.animationRepeatCount = 1;
    //4.开启动画
    [self.imgViewCat startAnimating];
    
    [self.imgViewCat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:3];
}

- (IBAction)fart {
    [self startAnimating:28 picName:@"fart"];
}

- (IBAction)knockout {
    [self startAnimating:81 picName:@"knockout"];
}

- (IBAction)cymbal {
    [self startAnimating:13 picName:@"cymbal"];
}

- (IBAction)eat {
    [self startAnimating:40 picName:@"eat"];
}

- (IBAction)pie {
    [self startAnimating:24 picName:@"pie"];
}

- (IBAction)scratch {
    [self startAnimating:56 picName:@"scratch"];
}

// 封装重复处理的方法，图片张数和图片名称参数不同而已
-(void)startAnimating:(int)count picName:(NSString *)picName
{
    //判断是否正在执行动画，是的话当前动作不执行
    if (self.imgViewCat.isAnimating) {
        return;
    }
   //0.动态加载图片到一个NSArray中
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%@_%02d.jpg",picName,i];
        //通过imgName：这种方式加载图片，加载好的图片会一直保存写在内存中，不会释放 优点：下次使用不需要重新加载，速度快 缺点：占用内存过多（缓存）
//        UIImage *imagCat = [UIImage imageNamed:imgName];
        //解决：换种加载图片的方式，不使用缓存，获取图片的完整路径
        NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        //不传递图片名称，传递图片的完整路径
        UIImage *imagCat = [UIImage imageWithContentsOfFile:path];
        
        [arrayM addObject:imagCat];
    }
    //1.设置UIImageview的animationImages属性，此属性包含那些要执行动画的图片
    self.imgViewCat.animationImages = arrayM;
    //2.设置动画持续时间
    self.imgViewCat.animationDuration = 3;
    //3.设置动画是否需要重复播放(不设置的话会一直循环)
    self.imgViewCat.animationRepeatCount = 1;
    //4.开启动画
    [self.imgViewCat startAnimating];
    
    //执行完毕后清空图片集合，问题是，动画还没开始执行，就已经让图片集合清空了，也就是说self.imgViewCat.animationImages 里面已经没有图片了，所以动画就不执行了
//    self.imgViewCat.animationImages = nil; 【performSelector】<- 延迟执行方法的api @selector()里装的是需要延迟执行的方法
    [self.imgViewCat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:3];
}

@end
