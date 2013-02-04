//
//  OrderCreateViewController.m
//  CoffeeSVP User
//
//  Created by bmaci on 2/3/13.
//  Copyright (c) 2013 bmaci. All rights reserved.
//

#import "OrderCreateViewController.h"

@interface OrderCreateViewController ()

@end

@implementation OrderCreateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //Add gesture recognizers to Selectors
    UITapGestureRecognizer *itemGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectItem:)];
    UITapGestureRecognizer *milkGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMilk:)];
    
    [self.itemPickerInputField addGestureRecognizer:itemGR];
    [self.milkPickerInputField addGestureRecognizer:milkGR];
    
    [self initPickers];
    //set delegates
    [self.specialInstructionsField setDelegate:self];
    [self.nameField setDelegate:self];
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    [self setViewMovedUp:YES];
    
}

-(void)keyboardWillHide {
   [self setViewMovedUp:NO];
}

-(void)initPickers
{
    //item picker
    CGRect itemFrame = self.itemPickerView.frame;
    itemFrame.size.height = 180;
    
    self.itemPickerView.showsSelectionIndicator = YES;
    self.itemPickerInputField.inputView = self.itemPickerView;
    
    self.itemPickerView.frame = itemFrame;
    
    // Prepare done button
    UIToolbar* keyboardItemDoneButtonView = [[UIToolbar alloc] init];
    keyboardItemDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardItemDoneButtonView.translucent = NO;
    keyboardItemDoneButtonView.tintColor = nil;
    [keyboardItemDoneButtonView sizeToFit];
    
    UIBarButtonItem* doneItemButton = [[UIBarButtonItem alloc] initWithTitle:@"Select this drink"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(itemPickerDoneClicked:)];
    
    [keyboardItemDoneButtonView setItems:[NSArray arrayWithObjects:doneItemButton, nil]];
    
    [self.customItemPickerView addSubview:keyboardItemDoneButtonView];
    
    // Plug the keyboardDoneButtonView into the text field...
    self.itemPickerInputField.inputAccessoryView = keyboardItemDoneButtonView;
    
    
    //milk picker
    CGRect milkFrame = self.milkPickerView.frame;
    milkFrame.size.height = 180;
    
    self.milkPickerView.showsSelectionIndicator = YES;
    self.milkPickerInputField.inputView = self.milkPickerView;
    
    self.milkPickerView.frame = milkFrame;
    
    // Prepare done button
    UIToolbar* keyboardMilkDoneButtonView = [[UIToolbar alloc] init];
    keyboardMilkDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardMilkDoneButtonView.translucent = NO;
    keyboardMilkDoneButtonView.tintColor = nil;
    [keyboardMilkDoneButtonView sizeToFit];
    
    UIBarButtonItem* doneMilkButton = [[UIBarButtonItem alloc] initWithTitle:@"Select this milk"
                                                                       style:UIBarButtonItemStyleBordered target:self
                                                                      action:@selector(milkPickerDoneClicked:)];
    
    [keyboardMilkDoneButtonView setItems:[NSArray arrayWithObjects:doneMilkButton, nil]];
    
    [self.customMilkPickerView addSubview:keyboardMilkDoneButtonView];
    
    // Plug the keyboardDoneButtonView into the text field...
    self.milkPickerInputField.inputAccessoryView = keyboardMilkDoneButtonView;
    
    
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.specialInstructionsField] || [sender isEqual:self.nameField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        
        [self setPickerViewMovedUp:NO forView:self.customItemPickerView];
        [self setPickerViewMovedUp:NO forView:self.customMilkPickerView];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y = -kOFFSET_FOR_KEYBOARD;
        rect.size.height = 400 + kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y = 0;
        rect.size.height = 400;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setPickerViewMovedUp:(BOOL)movedUp forView:(UIView *)picker
{
    CGRect rect = picker.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y =  self.view.frame.size.height - rect.size.height;
        //rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y = self.view.frame.size.height;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    
    UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction;
    
    [UIView animateWithDuration:0.2 delay:0.0 options:options animations:^
     {
         picker.frame = rect;
     } completion:nil];

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)selectItem:(id)sender
{
    //load UIPicker
    //NSLog(@"Select Item");
    
    self.itemPickerView.delegate = self;
    self.itemPickerView.dataSource = self;
    
    //close keyboard if it's open
    [self.view endEditing:YES];
    [self setPickerViewMovedUp:YES forView:self.customItemPickerView];
    
    [self setPickerViewMovedUp:NO forView:self.customMilkPickerView];
    
}

- (void)selectMilk:(id)sender
{
    //load UIPicker
    //NSLog(@"Select Milk");
    
    self.milkPickerView.delegate = self;
    self.milkPickerView.dataSource = self;
    
    //close keyboard if it's open
    [self.view endEditing:YES];
    [self setPickerViewMovedUp:YES forView:self.customMilkPickerView];
    
    [self setPickerViewMovedUp:NO forView:self.customItemPickerView];
}

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return (pickerView == self.itemPickerView) ? [[ConnectionManager shareInstance].menuItems count] : [[ConnectionManager shareInstance].milkOptions count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(pickerView == self.itemPickerView)
    {
        MenuDrinkItem *m = [[ConnectionManager shareInstance].menuItems objectAtIndex:row];
        return [m drinkName];
    }
    
    else
    {
        return [[ConnectionManager shareInstance].milkOptions objectAtIndex:row];
    }
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView == self.itemPickerView) [self.itemPickerInputField setText:[self pickerView:self.itemPickerView titleForRow:[self.itemPickerView selectedRowInComponent:0] forComponent:0]];
    
    else [self.milkPickerInputField setText:[self pickerView:self.milkPickerView titleForRow:[self.milkPickerView selectedRowInComponent:0] forComponent:0]];
    
}


- (IBAction)createOrder:(id)sender
{
   [ConnectionManager submitNewOrder:self.nameField.text withItem:self.itemPickerInputField.text andMilk:self.milkPickerInputField.text andSpecialInstructions:self.specialInstructionsField.text];
}

- (void)itemPickerDoneClicked:(id)sender
{
    //set picker data
    [self.itemPickerInputField setText:[self pickerView:self.itemPickerView titleForRow:[self.itemPickerView selectedRowInComponent:0] forComponent:0]];
    [self setPickerViewMovedUp:NO forView:self.customItemPickerView];
}

- (void)milkPickerDoneClicked:(id)sender
{
    //set picker data
    [self.milkPickerInputField setText:[self pickerView:self.milkPickerView titleForRow:[self.milkPickerView selectedRowInComponent:0] forComponent:0]];
    [self setPickerViewMovedUp:NO forView:self.customMilkPickerView];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (IBAction)resignResponders:(id)sender
{
    [self.view endEditing:YES];
    //[self.specialInstructionsField resignFirstResponder];
    //[self.nameField resignFirstResponder];
    
    [self setPickerViewMovedUp:NO forView:self.customItemPickerView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
