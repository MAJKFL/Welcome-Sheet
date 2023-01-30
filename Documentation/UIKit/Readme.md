# Configuring from Storyboards

You can set up the pages of your Welcome Sheet from a Storyboard or XIB file—without writing a single line of code. Check out the [demo](../../Demo/UIKit-Storyboard-WelcomeSheetDemo/) for more details.

## Creating a WelcomeSheetStoryboardController

Drag out a new UIViewController and set the class to `WelcomeSheetStoryboardController`.
<div style="display: flex; align-items: center">
    <img alt="A new UIViewController" src="Resources/ViewController.png" width="300px"/>
    <img alt="Set class of the controller to WelcomeSheetStoryboardController" src="Resources/SetClassOfViewController.png" width="300px"/>
</div>

## Creating a page

- Create a new object and set the class to `UIWelcomeSheetPage`.  
<div style="display: flex; align-items: center">
    <img alt="A new Object" src="Resources/Object.png" width="300px"/>
    <img alt="Set class of the object to UIWelcomeSheetPage" src="Resources/SetClassOfObjectToPage.png" width="300px"/>
</div>

- Go to the *Attributes* tab and configure the page.

<img alt="Configure the attributes of a page" src="Resources/ConfigurePage.png" width="300px"/>

### Adding a row to the page

- Create a new object and set the class to `UIWelcomeSheetPageRow`.  

<div style="display: flex; align-items: center">
    <img alt="A new Object" src="Resources/Object.png" width="300px"/>
    <img alt="Set class of the object to UIWelcomeSheetPageRow" src="Resources/SetClassOfObjectToRow.png" width="300px"/>
</div>

- Go to the *Attributes* tab and configure the row.  

<img alt="Configure the attributes of a page row" src="Resources/ConfigureRow.png" width="300px"/>

- Go to the *Connections* tab of your *page* and connect the `rows` outlet collection to all of the rows for the page.

<img alt="Connect the rows for your page" src="Resources/ConnectRows.png" width="300px"/>

### Connecting a page to the controller

- On your controller, go to the *Connections* tab and make a connection for each of your pages.  

<img alt="Connect the pages for your welcome sheet" src="Resources/ConnectPages.png" width="300px"/>

## Summary

To configure your Welcome sheet from a storyboard do as follows:

- Drag out a new UIViewController and set the class to `WelcomeSheetStoryboardController`.  
- For each of your pages:
    - Drag out a new Object and set the class to `UIWelcomeSheetPage`.
    - Configure the attributes
    - For each of the rows in your page:
        - Drag out a new Object and set the class to `UIWelcomeSheetPageRow`.
        - Configure the attributes
        - Connect the row to your page by draging out a connection to the `rows` outlet.
    - Connect the page to your sheet by draging out a connection to the `pages` outlet.
- You now have a Welcome Sheet without writing a single line of code!

You should end up with a lot of objects like so:

<img alt="Objects connected to your sheet" src="Resources/WelcomeSheetScene.png" width="300px"/>

# Using a System Symbol in a UIImage

Due to conversion issues between `UIImage` and SwiftUI’s `Image`, system symbols will have a squashed appearance. Welcome Sheet overcomes this issue by obtaining the name of the system symbol from the `UIImage` and creating a new `Image` from the system name.