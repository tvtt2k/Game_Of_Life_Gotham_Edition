# Final Project - Putting it all together

You have been provided with a base of code which does most of what was required in Assignment 4.  You are to implement the following problems in this base.  You are required to submit this by modifying the files in place and committing to your repo _in the main branch_.  Do not zip your files and upload them to github.  Do not create an additional branch.  Do not rename the directories or files. Do not move code from the file in which is located. Just change the code, commit and push.

As in previous assignments, do not delete the comments showing where code should be put as I will use them when grading.

## Problem 1 (basically 10 free points):

1. Locate the Colors.xcassets file in the Theming project.  In that file, as you have done before, add all colors referenced in the code. (you can search for `Color(` to find them. Ensure that all colors work in both dark and light mode.
2. Give your app a unique icon by either creating your own or selecting one from a free collection (google "ios free icons") You may reuse your icon from Assignment 4 if you like or create a new one. NB, you _MUST_ give appropriate credit in your app as outlined in the requirements of the site you use or you must state that you created the icon yourself. Provide the credits for your art work as before in the splash screen using the techniques discussed in class. Failure to do this will result in a failing grade for the assignment and likely the course.
3. Replace the "thumbs down" icon on each tab with a unique icon in the same manner. You may use the SF Symbol app to select appropriate icons for the tab bar items, or you may create your own, adding the icon to Assets.xcassets in a manner similar to your AppIcon. You must give proper credit if you use anything other than SF Symbol.
4. NEW -> Give each tab view (simulation, configuration, and statistics) a separate pastel background color of your choosing, using the techniques shown in class.
5. Ensure that all Toggles use your accent color rather than the system default.
6. Ensure that the Tab bar uses your accent color as the highlight color for the Tab items.
7. Ensure that the text in your navigation bar uses your accent color for all titles

Essentially these are free points as I am repeating or slightly enlarging on Problems 1-5 from Assignment 4, transferring or improving your work along the way. So you may use code from your previous assignments to do this.  

You need to get this right before going on to Problem 2 in order to visually reveal the UI elements which have been provided for you.

## Problem 2 (20 points):

In the file ThemedButton, change the overlay to use a Circle or Capsule (your choice) rather than a Rectangle. Adjust the font and layout of the InstrumentationView so that everything looks nice again. Using the techniques shown in class, adjust your layout for the Simulation tab, so that it works and looks nice in portrait and landscape on the following devices: iPad Pro 11” and iPhone (latest model) Pro.

## Problem 3 (40 points):

In the ConfigurationsView.swift file:

1. Locate the comment for Problem 3A's beginning. Wrap the existing display in an NavigationView and make the navigation view have a style of StackNavigationViewStyle.

2. Locate the comment for Problem 3A's end and Problem 3B's beginning. Make the navigation view have a title of Configuration and not be hidden. Do _not_ disturb the comment for Problems 5A and 5B which will be interspersed or appended to your Problem 3B code. 

3. In the ConfigurationView.swift file locate the comment for Problem 3C. In that location wrap the existing code in a NavigationLink such that when the row is selected, a GridEditor view will appear.

4. Use the appropriate modifiers to make sure that the list looks good

## Problem 4 (20 Points):

In the GridEditorView file:

1. Locate the comment that says Problem 4A. Configure a GridView which uses as its backing store the grid state of the current configuration and which updates via a grid action on the current configuration state. 

2. Locate the comment that says Problem 4B. Configure the ThemedButton such that when it is pressed, the SimulationView's grid object in the ApplicationModel is updated and the configuration object associated with this GridEditor is updated to match. Verify that pressing the button updates the grid on the simulation tab AND in that if you exit the GridEditor and return that the configuration has been remembered. Make sure the the entire page looks consistent with the rest of your app

## Problem 5 (20 points):

In ConfigurationsView:

1. Locate the comment marked Problem 5a and implement a `sheet` which will accept being turned on and off via the `isAdding` state and which is turned off via the .stopAdding action. 

2. Locate the comment marked Problem 5b and add a trailing button to the navigation bar which will send the `.addConfig` action to the ConfigurationsState In AddConfigurationView:

In AddConfigurationView:

3. Locate the comment marked Problem 5c and implement the sheet to allow the user to create a new configuration based on input of the title and size. For size, use the provided CounterView, for title use a TextField.

4. Locate the comment marked Problem 5D and implement the `ok` and `cancel` button actions for the view. 

5. Make sure that the AddConfigurationView's background is consistent with the overall theme of your app.

## Problem 6 (20 points):

In SimulationView:

1.  Locate the comment for Problem 6A. Add onAppear and onDisappear modifiers to stop the timer on disappear and restart on appear. Be sure to only have one timer running at any given time.

In SimulationModel: 

2. Locate the comment for Problem 6B.  Modify the two appear and disappear cases to properly turn the timer on view appears and off when it disappears 

## Problem 7 (10 Points)

In StatisticsView:

1 Locate the comment marked Problem 7A.  Using the provided FormLine view, add lines titled "Steps", "Alive", "Born", "Died", and "Empty", with the appropriate value obtained from the statistics store.

In FormLine:

1 Locate the comment marked Problem 7B. Give the text object of the FormLine the following characteristics:

    * a font of .title with digits monospaced
    * a foreground color of your accent color
    * a frame with a maximum width of .infinity and an alignment of .trailing

## Problem 8 (60 points):

Using the techniques shown in class, Implement an animation of your choosing in the GridView such that when the step button is pressed in the InstrumentationView the next step of the grid performs a complex animation. For full credit, your animation should, in multiple phases, animate the positions, color, opacity, and rotation of cells in a way that is subjectively pleasing to the user.

## Overall rules:

Verify that everything is wired up. In short your Final Project app should substantially resemble what you have seen me demonstrate in class.

We will grade by checking first that you have produced a running version of the app. Non-working code can receive at most 170 points and further deductions will follow from there. You should make any adjustments you feel necessary to produce a working app.

## Bonus Points Available (50 points):

You may, at your discretion, improve the app in any way you like and submit your improvements for grading. We will grade your improvements subjectively based on a "Wow" factor. In the past, animations, changes to ThemedButton, interesting modifications to the GoL logic and completely external ideas matching the students interests have qualified for bonus points. However, I _strongly_ advise you to a) first make sure you meet the project requirements before attempting anything complex, b) seek my advice on any particularly elaborate ideas you have to confirm feasibility.
