//
//  ViewController.h
//  FQTextEditor
//
//  Created by quan on 16/7/15.
//  Copyright © 2016年 quan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <YYText/YYText.h>


@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (strong, nonatomic) YYTextView *titleView;

@property (strong, nonatomic) YYTextView *textView;

@property (strong, nonatomic) UITableView *tableView;

@end

