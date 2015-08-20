//
//  SampleData.h
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015년 young1park. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SampleDataType) {
	SampleDataTypeImage = 0,
	SampleDataTypeMap
};

@interface SampleData : NSObject

@property (nonatomic) SampleDataType type;
@property (nonatomic) float height;
@property (nonatomic, strong) NSString *text;

@end
