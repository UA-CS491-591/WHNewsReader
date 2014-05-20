//
//  WHSearchTableViewController.h
//  WHNewsReader
//
//  Created by Mason Saucier on 5/13/14.
//
//

#import <UIKit/UIKit.h>

@interface WHSearchTableViewController : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;

- (void)handleSearch:(UISearchBar *)searchBar;

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;

@end 
