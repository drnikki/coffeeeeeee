//
//  OrderCreateViewController.h
//  CoffeeSVP User
//
//  Created by bmaci on 2/3/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUtilities.h"
#import "ConnectionManager.h"
#import "MenuDrinkItem.h"

@interface OrderCreateViewController : UIViewController
<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIView *itemSelector;
@property (nonatomic, strong) IBOutlet UIView *milkSelector;
@property (nonatomic, strong) IBOutlet UITextField *specialInstructionsField;
@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UIButton *createOrderButton;

@property (nonatomic, strong) IBOutlet UIPickerView *itemPickerView;
@property (nonatomic, strong) IBOutlet UIPickerView *milkPickerView;


@property (nonatomic, strong) IBOutlet UITextField *itemPickerInputField;
@property (nonatomic, strong) IBOutlet UITextField *milkPickerInputField;

@property (nonatomic, strong) IBOutlet UIView *customItemPickerView;
@property (nonatomic, strong) IBOutlet UIView *customMilkPickerView;

@property (nonatomic, strong) IBOutlet UIButton *resignRespondersButton;

- (IBAction)createOrder:(id)sender;
- (IBAction)resignResponders:(id)sender;

@end
