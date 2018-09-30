//
//  GridMenu.h
//  JFViewer
//
//  Created by James on 2018/9/29.
//  Copyright © 2018年 glodon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GridMenu;

//--------------------------------------------
// GridMenuItem

@interface GridMenuItem : NSObject

@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) UIImage* image;

@property (nonatomic, strong) id data;

+ (instancetype)itemWithTitle:(NSString*)title andImage:(UIImage*)image;

- (instancetype)initWithTitle:(NSString*)title andImage:(UIImage*)image;

@end

//--------------------------------------------
// GridMenuCell

@interface GridMenuCell : UIView

@property (nonatomic, strong, readonly) UIImageView* imageView;

@property (nonatomic, strong, readonly) UILabel* titleLabel;

@property (nonatomic, strong) id data;

@property (nonatomic, assign) BOOL disable;

@end

//--------------------------------------------
// GridMenuDelegate

@protocol GridMenuDelegate <NSObject>

- (void)gridMenu:(GridMenu*)gridMenu cellClicked:(GridMenuCell*)cell;

@optional
- (void)gridMenu:(GridMenu*)gridMenu setupCell:(GridMenuCell*)cell;

@end

//--------------------------------------------
// GridMenu

@interface GridMenu : UIView

// 列数量，默认4，有效范围[1, 100]，超出范围时，实际值为4
@property (nonatomic, assign) NSUInteger columnCount;

@property (nonatomic, strong, readonly) NSArray<GridMenuCell*>* cells;

@property (nonatomic, weak) id<GridMenuDelegate> delegate;

- (void)setItems:(NSArray<GridMenuItem*>*)items;

@end

NS_ASSUME_NONNULL_END
