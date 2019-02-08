//
//  ACInfoMode.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/2/7.
//  Copyright © 2019 kk. All rights reserved.
//

#import "ACCellMode.h"

#define NAME_W (SCREEN_WIDTH - countcoordinatesX((15 + 40 + 10 + 15)))
#define IMAGE_W ((NAME_W - countcoordinatesX(10) * 2 - countcoordinatesX(50)) / 3)

#pragma mark - 声明
@interface ACCellMode()

@property (nonatomic, strong) ASNetworkImageNode *iconMode;
@property (nonatomic, strong) ASTextNode *nameNode;
@property (nonatomic, strong) ASTextNode *textNode;
@property (nonatomic, strong) NSMutableArray<ASNetworkImageNode *> *imageNodes;
@property (nonatomic, strong) ASTextNode *timeNode;
@property (nonatomic, strong) ASButtonNode *actionNode;
@property (nonatomic, strong) ASImageNode *triangleNode;
@property (nonatomic, strong) ASDisplayNode *replyNode;
@property (nonatomic, strong) ASTextNode *likeNode;
@property (nonatomic, strong) ASDisplayNode *lineNode;
@property (nonatomic, strong) NSMutableArray<ASTextNode *> *replyNodes;

@end


#pragma mark - 实现
@implementation ACCellMode


- (instancetype)init {
    if (self = [super init]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self initUI];
    }
    return self;
}
- (void)initUI {
    [self iconMode];
    [self nameNode];
    [self textNode];
    [self imageNodes];
    [self timeNode];
    [self replyNode];
    [self replyNode];
    [self triangleNode];
    [self likeNode];
    [self lineNode];
    
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.actionNode setBackgroundColor:[UIColor orangeColor]];
    [self.replyNode setBackgroundColor:kColor_Line_Color];
}


#pragma mark - set
- (void)setModel:(ACModel *)model {
    _model = model;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = countcoordinatesX(3);
    NSDictionary *nameDict = @{NSFontAttributeName: [UIFont systemFontOfSize:AdjustFont(14)],
                               NSForegroundColorAttributeName: kColor_Text_Black};
    NSDictionary *textDict = @{NSFontAttributeName: [UIFont systemFontOfSize:AdjustFont(12)],
                               NSForegroundColorAttributeName: kColor_Text_Black,
                               NSParagraphStyleAttributeName: style};
    NSDictionary *timeDict = @{NSFontAttributeName: [UIFont systemFontOfSize:AdjustFont(10)],
                               NSForegroundColorAttributeName: kColor_Text_Gary};
    
    [self.iconMode setURL:[NSURL URLWithString:model.icon]];
    [self.nameNode setAttributedText:[[NSAttributedString alloc] initWithString:model.name attributes:nameDict]];
    [self.textNode setAttributedText:[[NSAttributedString alloc] initWithString:model.text attributes:textDict]];
    [self.timeNode setAttributedText:[[NSAttributedString alloc] initWithString:model.time attributes:timeDict]];
    for (int i=0; i<model.images.count; i++) {
        [self.imageNodes[i] setURL:[NSURL URLWithString:model.images[i]]];
    }
    
    NSMutableAttributedString *attrm = [[NSMutableAttributedString alloc] init];
    for (int i=0; i<model.likes.count; i++) {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:AdjustFont(14)],
                                     NSForegroundColorAttributeName: [UIColor redColor]};
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:model.likes[i].name attributes:attributes];
        [attrm appendAttributedString:attr];
    }
    [self.likeNode setAttributedText:attrm];


    for (int i=0; i<model.replys.count; i++) {
        ASTextNode *node = [[ASTextNode alloc] init];
        node.attributedText = [[NSAttributedString alloc] initWithString:@"123123"];
        [self addSubnode:node];
        [self.replyNodes addObject:node];
    }
    
    
}


#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    [_nameNode.style setMaxWidth:ASDimensionMakeWithPoints(NAME_W)];
    [_textNode.style setMaxWidth:_nameNode.style.maxWidth];
    [_actionNode.style setPreferredSize:CGSizeMake(80, countcoordinatesX(20))];
    [_replyNode.style setWidth:ASDimensionMake(NAME_W)];
    [_replyNode.style setHeight:ASDimensionMake(countcoordinatesX(200))];
    
    for (int i=0; i<9; i++) {
        ASImageNode *imageMode = self.imageNodes[i];
        if (i < [self.model.images count]) {
            if ([self.model.images count] == 1) {
                [imageMode.style setPreferredSize:CGSizeMake(IMAGE_W * 1.5, IMAGE_W * 1.5)];
            } else {
                [imageMode.style setPreferredSize:CGSizeMake(IMAGE_W, IMAGE_W)];
            }
        }
        else {
            [imageMode.style setPreferredSize:CGSizeZero];
        }
    }
    for (int i=0; i<self.replyNodes.count; i++) {
        ASTextNode *node = self.replyNodes[i];
        [node.style setWidth:ASDimensionMake(NAME_W - countcoordinatesX(10))];
    }
    
    ASStackLayoutSpec *textStack = ({
        ASStackLayoutSpec *textStack = [[ASStackLayoutSpec alloc] init];
        textStack.direction = ASStackLayoutDirectionVertical;
        textStack.spacing = countcoordinatesX(5);
        textStack.justifyContent = ASStackLayoutJustifyContentStart;
        textStack.alignItems = ASStackLayoutAlignItemsStart;
        textStack.style.spacingAfter = countcoordinatesX(10);
        textStack.children = ({
            NSMutableArray *textChildren = [NSMutableArray array];
            [textChildren addObject:_nameNode];
            if (_model.text.length != 0) {
                [textChildren addObject:_textNode];
            }
            textChildren;
        });
        textStack;
    });
    
    ASStackLayoutSpec *imageStack = ({
        ASStackLayoutSpec *imageStack = [[ASStackLayoutSpec alloc] init];
        imageStack.direction = ASStackLayoutDirectionHorizontal;
        imageStack.spacing = countcoordinatesX(10);
        imageStack.justifyContent = ASStackLayoutJustifyContentStart;
        imageStack.alignItems = ASStackLayoutAlignItemsStart;
        imageStack.lineSpacing = countcoordinatesX(10);
        imageStack.children = self.imageNodes;
        imageStack.style.spacingAfter = countcoordinatesX(10);
        imageStack;
    });
    
    ASStackLayoutSpec *actionStack = ({
        ASStackLayoutSpec *actionStack = [[ASStackLayoutSpec alloc] init];
        actionStack.direction = ASStackLayoutDirectionHorizontal;
        actionStack.spacing = countcoordinatesX(10);
        actionStack.justifyContent = ASStackLayoutJustifyContentSpaceBetween;
        actionStack.alignItems = ASStackLayoutAlignItemsCenter;
        actionStack.alignContent = ASStackLayoutAlignContentStart;
        actionStack.children = @[_timeNode, _actionNode];
        actionStack.style.width = ASDimensionMake(NAME_W);
        actionStack;
    });
    
    ASInsetLayoutSpec *triangleStack = ({
        UIEdgeInsets edge = UIEdgeInsetsMake(0, countcoordinatesX(20), 0, 0);
        ASInsetLayoutSpec *triangleStack = [[ASInsetLayoutSpec alloc] init];
        triangleStack.insets = edge;
        triangleStack.children = @[_triangleNode];
        triangleStack.style.spacingBefore = 0;
        triangleStack;
    });

    ASOverlayLayoutSpec *likeContentSpec = ({
        ASStackLayoutSpec *likeStack = ({
            _likeNode.style.width = ASDimensionMake(NAME_W - countcoordinatesX(10));
            _lineNode.style.width = ASDimensionMake(NAME_W - countcoordinatesX(10));
            ASStackLayoutSpec *imageStack = [[ASStackLayoutSpec alloc] init];
            imageStack.direction = ASStackLayoutDirectionVertical;
            imageStack.spacing = countcoordinatesX(5);
            imageStack.justifyContent = ASStackLayoutJustifyContentStart;
            imageStack.alignItems = ASStackLayoutAlignItemsStart;
            imageStack.children = ({
                NSMutableArray *arrm = [NSMutableArray array];
                if (_model.likes.count != 0) {
                    [arrm addObjectsFromArray:@[_likeNode, _lineNode]];
                }
                if (_model.replys.count != 0) {
                    [arrm addObjectsFromArray:self.replyNodes];
                }
                arrm;
            });
            imageStack;
        });

        ASInsetLayoutSpec *likeSpec = [[ASInsetLayoutSpec alloc] init];
        likeSpec.insets = UIEdgeInsetsMake(countcoordinatesX(5), countcoordinatesX(5), INFINITY, countcoordinatesX(5));
        likeSpec.child = likeStack;

        ASOverlayLayoutSpec *likeContentSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_replyNode overlay:likeSpec];
        likeContentSpec;
    });

    ASStackLayoutSpec *replySpec = ({
        ASStackLayoutSpec *replySpec = [[ASStackLayoutSpec alloc] init];
        replySpec.direction = ASStackLayoutDirectionVertical;
        replySpec.spacing = 0;
        replySpec.justifyContent = ASStackLayoutJustifyContentStart;
        replySpec.alignItems = ASStackLayoutAlignItemsStart;
        replySpec.alignContent = ASStackLayoutAlignContentStart;
        replySpec.children = @[triangleStack, likeContentSpec];
        replySpec.style.width = ASDimensionMake(NAME_W);
        replySpec;
    });
    
    ASStackLayoutSpec *contentStack = ({
        ASStackLayoutSpec *contentStack = [[ASStackLayoutSpec alloc] init];
        contentStack.direction = ASStackLayoutDirectionVertical;
        contentStack.spacing = 0;
        contentStack.justifyContent = ASStackLayoutJustifyContentStart;
        contentStack.alignItems = ASStackLayoutAlignItemsStart;
        contentStack.style.width = ASDimensionMake(NAME_W);
        contentStack.children = ({
            NSMutableArray *contentChildren = [NSMutableArray array];
            [contentChildren addObject:textStack];
            if (self.model.images.count != 0) {
                [contentChildren addObject:imageStack];
            }
            [contentChildren addObject:actionStack];
            if (self.model.likes.count != 0 || self.model.replys.count != 0) {            
                [contentChildren addObject:replySpec];
            }
            contentChildren;
        });
        contentStack;
    });
    
    ASStackLayoutSpec *cellStack = ({
        ASStackLayoutSpec *cellStack = [[ASStackLayoutSpec alloc] init];
        cellStack.direction = ASStackLayoutDirectionHorizontal;
        cellStack.spacing = countcoordinatesX(10);
        cellStack.justifyContent = ASStackLayoutJustifyContentStart;
        cellStack.alignItems = ASStackLayoutAlignItemsStart;
        cellStack.children = @[_iconMode, contentStack];
        cellStack;
    });
    
    ASInsetLayoutSpec *layout = ({
        UIEdgeInsets edge = UIEdgeInsetsMake(countcoordinatesX(10), countcoordinatesX(15), countcoordinatesX(10), countcoordinatesX(15));
        ASInsetLayoutSpec *layout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:edge child:cellStack];
        layout;
    });
    
    return layout;
}


#pragma mark - get
- (ASNetworkImageNode *)iconMode {
    if (!_iconMode) {
        _iconMode = [[ASNetworkImageNode alloc] init];
        _iconMode.cornerRadius = countcoordinatesX(2);
        _iconMode.style.preferredSize = CGSizeMake(countcoordinatesX(40), countcoordinatesX(40));
        [self addSubnode:_iconMode];
    }
    return _iconMode;
}
- (ASTextNode *)nameNode {
    if (!_nameNode) {
        _nameNode = [[ASTextNode alloc] init];
        [self addSubnode:_nameNode];
    }
    return _nameNode;
}
- (ASTextNode *)textNode {
    if (!_textNode) {
        _textNode = [[ASTextNode alloc] init];
        [self addSubnode:_textNode];
    }
    return _textNode;
}
- (NSMutableArray<ASNetworkImageNode *> *)imageNodes {
    if (!_imageNodes) {
        _imageNodes = [[NSMutableArray alloc] init];
        for (int i=0; i<9; i++) {
            ASNetworkImageNode *mode = [[ASNetworkImageNode alloc] init];
            [_imageNodes addObject:mode];
            [self addSubnode:mode];
        }
    }
    return _imageNodes;
}
- (ASTextNode *)timeNode {
    if (!_timeNode) {
        _timeNode = [[ASTextNode alloc] init];
        [self addSubnode:_timeNode];
    }
    return _timeNode;
}
- (ASButtonNode *)actionNode {
    if (!_actionNode) {
        _actionNode = [[ASButtonNode alloc] init];
        [self addSubnode:_actionNode];
    }
    return _actionNode;
}
- (ASImageNode *)triangleNode {
    if (!_triangleNode) {
        _triangleNode = [[ASImageNode alloc] init];
        _triangleNode.image = [UIImage imageNamed:@"cc_triangle"];
        _triangleNode.style.preferredSize = ({
            UIImage *triangle = _triangleNode.image;
            CGFloat triangleW = countcoordinatesX(10);
            CGFloat triangleH = triangleW / triangle.size.width * triangle.size.height;
            CGSizeMake(triangleW, triangleH);
        });
        [self addSubnode:_triangleNode];
    }
    return _triangleNode;
}
- (ASTextNode *)likeNode {
    if (!_likeNode) {
        _likeNode = [[ASTextNode alloc] init];
        _likeNode.attributedText = [[NSAttributedString alloc] initWithString:@"qweqweqeqqeqweqweqweqeqqeqweqweqweqeqqeqweqweqweqeqqeqwe"];
        [self addSubnode:_likeNode];
    }
    return _likeNode;
}
- (ASDisplayNode *)lineNode {
    if (!_lineNode) {
        _lineNode = [[ASDisplayNode alloc] init];
        _lineNode.backgroundColor = kColor_White;
        [self addSubnode:_lineNode];
    }
    return _lineNode;
}
- (ASDisplayNode *)replyNode {
    if (!_replyNode) {
        _replyNode = [[ASDisplayNode alloc] init];
        _replyNode.cornerRadius = countcoordinatesX(2);
        [self addSubnode:_replyNode];
    }
    return _replyNode;
}
- (NSMutableArray<ASTextNode *> *)replyNodes {
    if (!_replyNodes) {
        _replyNodes = [NSMutableArray array];
    }
    return _replyNodes;
}


@end
