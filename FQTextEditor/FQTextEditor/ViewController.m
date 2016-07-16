//
//  ViewController.m
//  FQTextEditor
//
//  Created by quan on 16/7/15.
//  Copyright © 2016年 quan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<YYTextViewDelegate> {
    CGFloat heightOfTableHeader;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"0字";
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.tintColor = [UIColor brownColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithWhite:0.7 alpha:0.9],NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil]];
    
    
    UIBarButtonItem *backBt = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(tapCancelGoBack)];
    self.navigationItem.leftBarButtonItem = backBt;
    
    UIBarButtonItem *rightBt = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publishArticle)];
    self.navigationItem.rightBarButtonItem = rightBt;
    
    YYTextSimpleMarkdownParser *parser = [YYTextSimpleMarkdownParser new];
    [parser setColorWithBrightTheme];
    
    _textView = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _textView.scrollEnabled = NO;
    _textView.text = _textView.text;
    _textView.font = [UIFont systemFontOfSize:18];
    _textView.textParser = parser;
    _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _textView.delegate = self;
//    if (kiOS7Later) {
//        _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
//    }
//    _textView.backgroundColor = [UIColor colorWithWhite:0.134 alpha:1.000];
//    _textView.backgroundColor = [UIColor whiteColor];
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.scrollIndicatorInsets = _textView.contentInset;
    _textView.selectedRange = NSMakeRange(_textView.text.length, 0);
    _textView.allowsUndoAndRedo = YES;
     _textView.textParser = parser;
    [self.view addSubview:_textView];
    
    _titleView = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.000];
    _titleView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _titleView.textContainerInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _titleView.font = [UIFont systemFontOfSize:24];
    heightOfTableHeader = [_textView sizeThatFits:CGSizeMake(_textView.frame.size.width, FLT_MAX)].height;
    self.titleView.frame = CGRectMake(0, 0, _textView.frame.size.width, heightOfTableHeader);
    _titleView.delegate = self;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.tableView.rowHeight = 1;
    
    
    _tableView.tableHeaderView = _titleView;
    _tableView.tableFooterView = _textView;
    
    #pragma mark - 定义键盘附件
    UIBarButtonItem *hideKeyboardBt = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_format_keyboard"] style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard)];
    UIBarButtonItem *undoBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undo)];
    UIBarButtonItem *redoBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(redo)];
    UIBarButtonItem *editFormatBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(showEditFormat)];
    UIBarButtonItem *insertBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showInsertElementMenu)];
    UIBarButtonItem *moreBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showMoreMenu)];
    UIBarButtonItem *spaceBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    toolBar.items = @[ hideKeyboardBt, spaceBt, undoBt, spaceBt, redoBt, spaceBt, editFormatBt, spaceBt, insertBt, spaceBt, moreBt];
    
    self.textView.inputAccessoryView = toolBar;
    
}

-(void)hideKeyboard {
    [self.view endEditing:YES];
}

-(void)undo {
    
    [self.textView _undo];
    
}

-(void)redo {
    
    [self.textView _redo];
    
}

-(void)showEditFormat{
    
}

-(void)showInsertElementMenu {
    
}

-(void)showMoreMenu {
    
}


//返回上个界面
-(void)tapCancelGoBack {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//发布文章
-(void)publishArticle {
    [self.view endEditing:YES];
    
    //解析得到HTML格式字符串，发送至服务器
    //...
    
   
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    
    //    cell
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}

#pragma mark - YYTextViewDelegate
- (void)textViewDidBeginEditing:(YYTextView *)textView {
    
}
- (void)textViewDidChange:(YYTextView *)textView {
    if (textView == _titleView) {//动态计算标题框的高度
        
        heightOfTableHeader = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, FLT_MAX)].height;
        self.titleView.frame = CGRectMake(0, 0, textView.frame.size.width, heightOfTableHeader);
        self.tableView.tableHeaderView = self.titleView;
    }
    
}

-(BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView == _titleView && [text isEqualToString:@"\n"]) {//编辑标题框点击return键，光标跳到内容编辑框
        [_textView becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    if (textView == _titleView) { //点击内容编辑框，标题框网上移动；
        [UIView animateKeyframesWithDuration:0.2 delay:0.01 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
            self.tableView.contentOffset = CGPointMake(0, heightOfTableHeader);
        } completion:^(BOOL finished) {
            
        }];
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
