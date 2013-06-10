//
//  PhotoCollectionController.m
//  EventManager
//
//  Created by Yingdong Zhang on 5/16/13.
//  Copyright (c) 2013 Yingdong Zhang. All rights reserved.
//

#import "PhotoCollectionController.h"

@interface PhotoCollectionController ()

@end

@implementation PhotoCollectionController

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
    //[super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // return the photos linked to the event to the array
    self.imageList = [[self.eventToEdit.photos allObjects] mutableCopy];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"viewPhotoSegue"])
    {
        PhotoViewController* controller = segue.destinationViewController;
        NSIndexPath* indexPath = [self.collectionView indexPathForCell:sender];
        controller.photoToView = [self.imageList objectAtIndex:indexPath.row];
        controller.delegate = self;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageList count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoCell";
    PhotoCell* cell = (PhotoCell*)[self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    Photo *photo = [self.imageList objectAtIndex:indexPath.row]; // 4.new

    NSData *imgData = photo.photo;
    UIImage* img = [UIImage imageWithData:imgData];
    cell.photoView.image = img;
    
    return cell;
}

-(IBAction)openCamera:(id)sender
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* img = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    NSData *imgData = [NSData dataWithData:UIImagePNGRepresentation(img)];
    
    // if the image is not nil, save it to core data and add it to the event
    if(imgData != nil)
    {
        Photo* newPhoto = (Photo*)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];

        newPhoto.photo = imgData;
        
        [self.imageList addObject:newPhoto];
        [self.delegate savePhoto:newPhoto];
        NSLog(@"%i", [self.imageList count]);
    }

    NSError* error;
    if(!([self.managedObjectContext save:&error]))
    {
        NSLog(@"Core Data Save Error: %@", [error description]);
    }

    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// delete the photo from the list and core data
-(void)deleteSelectedPhoto:(Photo *)photo
{
    [self.managedObjectContext deleteObject:photo];
    [self.imageList removeObject:photo];
    NSError* error;
    
    if(![self.managedObjectContext save:&error])
    {
        NSLog(@"Core Data Error: %@", error.description);
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
