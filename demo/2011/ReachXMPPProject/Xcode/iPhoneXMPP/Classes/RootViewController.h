#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class iPhoneXMPPAppDelegate;


@interface RootViewController : UITableViewController <UITextFieldDelegate,NSFetchedResultsControllerDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	NSFetchedResultsController *fetchedResultsController;
    
    NSMutableDictionary *accountDic;
    UITextField *inputBox;
}

@property (nonatomic, retain) IBOutlet UITextField *inputBox;
- (IBAction)settings:(id)sender;

@end
