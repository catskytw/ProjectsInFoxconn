#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class iPhoneXMPPAppDelegate;


@interface RootViewController : UITableViewController <UITextFieldDelegate,NSFetchedResultsControllerDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	NSFetchedResultsController *fetchedResultsController;
    
    NSMutableDictionary *accountDic;
    UITextField *inputBox;
    BOOL isLoading;
}

@property (nonatomic, retain) IBOutlet UITextField *inputBox;
@property (nonatomic) BOOL isLoading;
- (IBAction)settings:(id)sender;
-(NSString *)getName:(NSString *)name;
@end
