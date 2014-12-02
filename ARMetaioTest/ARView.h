//
//  ARView.h
//  ARMetaioTest
//
//  Created by 池田昂平 on 2014/11/18.
//  Copyright (c) 2014年 池田昂平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ARView : UIView{
    CGPoint center;
}

//arに関するプロパティ
@property BOOL armarkerRecog;
@property int aridNum;

//capa(静電)に関するプロパティ
@property BOOL capaRecog;
@property int capaidNum;
@property NSArray *touchObjects;
@property BOOL calcReset;
//@property(nonatomic, readonly) CGFloat majorRadius;

@property AVAudioPlayer *capaRecogSound;

@end
