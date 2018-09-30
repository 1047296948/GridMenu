//
//  GridMenu.m
//  JFViewer
//
//  Created by James on 2018/9/29.
//  Copyright © 2018年 glodon. All rights reserved.
//

#import "GridMenu.h"

//--------------------------------------------
// GridMenuItem

@implementation GridMenuItem

+ (instancetype)itemWithTitle:(NSString*)title andImage:(UIImage*)image {
    return [[GridMenuItem alloc] initWithTitle:title andImage:image];
}

- (instancetype)initWithTitle:(NSString*)title andImage:(UIImage*)image {
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
    }
    return self;
}

@end

//--------------------------------------------
// GridMenuCell

@interface GridMenuCell ()

@property (nonatomic, strong) UIButton* button;
@property (nonatomic, weak) GridMenu* gridMenu;

@end

@implementation GridMenuCell

- (instancetype)initWithFrame:(CGRect)frame andItem:(GridMenuItem*)item {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = item.title;
        [self addSubview:self.titleLabel];
        
        _imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.image = item.image;
        [self addSubview:self.imageView];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = self.bounds;
        self.button.backgroundColor = [UIColor clearColor];
        self.button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.button];
        
        self.data = item.data;
    }
    return self;
}

- (BOOL)disable {
    return !self.button.enabled;
}

- (void)setDisable:(BOOL)disable {
    self.button.enabled = !disable;

    if (self.gridMenu.delegate && [self.gridMenu.delegate respondsToSelector:@selector(gridMenu:setupCell:)]) {
        [self.gridMenu.delegate gridMenu:self.gridMenu setupCell:self];
    }
}

@end

//--------------------------------------------
// GridMenu

@implementation GridMenu

- (void)cellButtonClicked:(UIButton*)button {
    if (self.delegate) {
        [self.delegate gridMenu:self cellClicked:(GridMenuCell*)button.superview];
    }
}

#pragma mark - getter/setter

@synthesize columnCount = _columnCount;

- (NSUInteger)columnCount {
    if (_columnCount < 1 || _columnCount > 100) {
        return 4;
    }
    return _columnCount;
}

- (void)setColumnCount:(NSUInteger)columnCount {
    if (self.columnCount != columnCount) {
        _columnCount = columnCount;
        if (self.cells.count) {
            [self setNeedsLayout];
        }
    }
}

- (void)setDelegate:(id<GridMenuDelegate>)delegate {
    _delegate = delegate;
    if (self.cells.count) {
        [self setNeedsLayout];
    }
}

- (void)setItems:(NSArray<GridMenuItem*>*)items {
    for (GridMenuCell* c in self.cells) {
        [c removeFromSuperview];
    }
    
    NSMutableArray* cells = [NSMutableArray arrayWithCapacity:items.count];
    for (GridMenuItem* i in items) {
        GridMenuCell* c = [[GridMenuCell alloc] initWithFrame:CGRectZero andItem:i];
        c.gridMenu = self;
        [c.button addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:c];
        [cells addObject:c];
    }
    _cells = cells;
    
    [self setNeedsLayout];
}

#pragma mark - overide

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger rowCount = (NSInteger)ceill((double)(self.cells.count) / (double)(self.columnCount));
    CGFloat w = self.frame.size.width/self.columnCount;
    CGFloat h = self.frame.size.height/rowCount;
    
    for (int i=0; i<self.cells.count; ++i) {
        GridMenuCell* cell = self.cells[i];
        
        int row = (int)floor((double)(i) / (double)(self.columnCount));
        int col = i % self.columnCount;
        CGRect frame = CGRectMake(col*w, row*h, w, h);
        cell.frame = frame;
        
        cell.imageView.frame = CGRectMake(0, 0, w, h*0.7);
        cell.titleLabel.frame = CGRectMake(0, h*0.7, w, h*0.3);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(gridMenu:setupCell:)]) {
            [self.delegate gridMenu:self setupCell:cell];
        }
    }
}

@end
