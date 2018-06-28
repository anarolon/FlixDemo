//
//  MovieCell.h
//  FlixDemo
//
//  Created by Chaliana Rolon on 6/28/18.
//  Copyright © 2018 Chaliana Rolon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterLabel;

@end
