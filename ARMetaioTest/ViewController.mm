//
//  ViewController.m
//  ARMetaioTest
//
//  Created by 池田昂平 on 2014/10/20.
//  Copyright (c) 2014年 池田昂平. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    /*
    //TouchView生成 (タッチ)
    self.view.multipleTouchEnabled = YES;
    TouchView *touchView = [[TouchView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:touchView];
     */
    
    //音の設定
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recogHover" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.recogSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    
    //glView生成 (metaio AR)
    self.glView = [[EAGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    
    //ARView
    self.arview = [[ARView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.arview];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //トラッキング設定ファイル
    //NSString *trackingid01 = [[NSBundle mainBundle] pathForResource:@"TrackingID01" ofType:@"zip"];
    //NSString *trackingid01 = [[NSBundle mainBundle] pathForResource:@"TrackingID01_rev" ofType:@"zip"];
    NSString *trackingid01 = [[NSBundle mainBundle] pathForResource:@"idmarkerConfig" ofType:@"zip"];
    if(trackingid01){
        bool success = m_metaioSDK->setTrackingConfiguration([trackingid01 UTF8String]);
        if(!success){
            NSLog(@"No success loading the trackingconfiguration");
        }
    }else{
        NSLog(@"No success loading the trackingconfiguration");
    }

    /*
    NSString *showobj01path = [[NSBundle mainBundle] pathForResource:@"showobj01" ofType:@"zip"];
    
    if(showobj01path){
        metaio::IGeometry *loadModel01 = m_metaioSDK->createGeometry([showobj01path UTF8String]);
        if(loadModel01){
            //そのまま表示すると少し小さいので、少し拡大
            loadModel01->setScale(metaio::Vector3d(4.0, 4.0, 4.0));
        }else{
            NSLog(@"error, could not load %@", showobj01path);
        }
    }
    */
}

- (void)onTrackingEvent:(const metaio::stlcompat::Vector<metaio::TrackingValues> &)poses{
    
    self.arview.capaRecog = NO;
    
    for(int i = 0; i < poses.size(); i++){
        NSLog(@"onTrackingEvent: quality:%f", poses[i].quality);
        
        if(poses[0].quality >= 0.5){
            self.arview.armarkerRecog = YES;
            
            NSString *markerName = [NSString stringWithCString:poses[i].cosName.c_str() encoding:[NSString defaultCStringEncoding]];
            [self recogARID:markerName];
            
            [self.arview setNeedsDisplay];
            [self.recogSound play];
            
            metaio::Vector3d transComp = poses[i].translation;
            NSLog(@"x座標: %f", transComp.x);
            NSLog(@"y座標: %f", transComp.y);
            NSLog(@"cosName: %s", poses[i].cosName.c_str());
        }else{
            self.arview.armarkerRecog = NO;
            [self.arview setNeedsDisplay];
        }
    }
    NSLog(@"poses.size() = %lu", poses.size());
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recogARID:(NSString *)markerName{
    
    /*
    if([markerName isEqualToString:@"patt01_1"]){
        self.arview.aridNum = 1;
    }else{
        self.arview.aridNum = 0;
        NSLog(@"maker name is %@", markerName);
    }
     */
    
    
    /*
    if([markerName isEqualToString:@"id01_1_1"]){
        self.arview.aridNum = 1;
    }else{
        self.arview.aridNum = 0;
        NSLog(@"maker name is %@", markerName);
    }
    */
    
    if([markerName isEqualToString:@"ID marker 1"]){
        self.arview.aridNum = 1;
    }else if([markerName isEqualToString:@"ID marker 2"]){
        self.arview.aridNum = 2;
    }else{
        self.arview.aridNum = 0;
        NSLog(@"maker name is %@", markerName);
    }
}

@end
