//
//  VIPinField.m
//  Pods
//
//  Created by 熊国锋 on 2017/3/14.
//
//

#import "VIPinField.h"

#define CONTENT_VIEW    self.contentView

@interface DigitCell : UICollectionViewCell

@property (nonatomic, copy)   UIColor       *textColor;

@property (nonatomic, copy)   NSString      *text;
@property (nonatomic, strong) UILabel       *label;
@property (nonatomic, strong) UIView        *sepLine;

@end

@implementation DigitCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _textColor = [UIColor blackColor];
        
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont boldSystemFontOfSize:28];
        self.label.textColor = self.textColor;
        [CONTENT_VIEW addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CONTENT_VIEW);
            make.centerX.equalTo(CONTENT_VIEW);
        }];
        
        self.sepLine = [[UIView alloc] init];
        self.sepLine.backgroundColor = self.textColor;
        
        [CONTENT_VIEW addSubview:self.sepLine];
        [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(CONTENT_VIEW).multipliedBy(.7);
            make.centerX.equalTo(CONTENT_VIEW);
            make.top.equalTo(self.label.mas_bottom);
            make.bottom.equalTo(CONTENT_VIEW);
            make.height.equalTo(@2);
        }];
    }
    
    return self;
}

- (void)setTextColor:(UIColor *)textColor {
    self.label.textColor = textColor;
    self.sepLine.backgroundColor = textColor;
}

- (void)setText:(NSString *)text {
    self.label.text = text;
}

@end

#pragma mark - VIPinField

@interface VIPinField () < UICollectionViewDataSource, UICollectionViewDelegateFlowLayout >

@property (nonatomic, strong) NSMutableString       *pinText;
@property (assign)            NSInteger             digitCount;

@property (nonatomic, strong) UICollectionView      *collectionView;

@end

@implementation VIPinField

- (instancetype)initWithFrame:(CGRect)frame digitCount:(NSInteger)digitCount {
    if (self = [self initWithFrame:frame]) {
        [self setupWithFrame:frame digitCount:digitCount];
    }
    
    return self;
}

- (void)setupWithFrame:(CGRect)frame digitCount:(NSInteger)digitCount {
    self.pinText = [[NSMutableString alloc] init];
    self.digitCount = digitCount;
    self.enabled = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame
                                             collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.userInteractionEnabled = YES;
    
    [self.collectionView registerClass:[DigitCell class]
            forCellWithReuseIdentifier:[DigitCell reuseIdentifier]];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.collectionView reloadData];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    [self.collectionView reloadData];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = [textColor copy];
    
    [self.collectionView reloadData];
}

- (NSString *)text {
    return [self.pinText copy];
}

- (void)setText:(NSString *)text {
    NSInteger length = MIN([text length], self.digitCount);
    if (length) {
        self.pinText = [[text substringWithRange:NSMakeRange(0, length)] mutableCopy];
        [self.collectionView reloadData];
        
        [self.delegate pinTextDidChange:self];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    
    self.collectionView.backgroundColor = backgroundColor;
}

#pragma mark - UIKeyInput

- (BOOL)hasText {
    return [self.pinText length] > 0;
}

- (void)insertText:(NSString *)text {
    if ([self isEnabled]) {
        if ([self.pinText length] < self.digitCount) {
            [self.pinText appendString:text];
            
            [self.collectionView reloadData];
            [self.delegate pinTextDidChange:self];
        }
        else {
            [self shakeView];
        }
    }
}

- (void)deleteBackward {
    if ([self.pinText length] && [self isEnabled]) {
        NSRange range = NSMakeRange([self.pinText length] - 1, 1);
        [self.pinText deleteCharactersInRange:range];
        
        [self.collectionView reloadData];
        [self.delegate pinTextDidChange:self];
    }
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.digitCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:[DigitCell reuseIdentifier]
                                                     forIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = CGRectGetHeight(collectionView.bounds);
    CGFloat width = CGRectGetWidth(collectionView.bounds);
    return CGSizeMake(width / self.digitCount, height);
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(DigitCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.item;
    NSString *text;
    if (index < [self.pinText length]) {
        text = [self.pinText substringWithRange:NSMakeRange(index, 1)];
    }
    else {
        text = @"";
    }
    
    cell.text = text;
    if (self.textColor) {
        cell.textColor = self.textColor;
    }
}

- (void)paste:(id)sender {
    
}

@end
