# Mandatory Assignment

In order to take part in the iPraktikum course, you need to submit an interactive iPhone app (iOS 15) developed using Xcode 13 and SwiftUI 3 as part of the Mandatory Assignment.


## Submission


-   **Clone this repository** and use it to work on your app.
-   **Follow the branching model** described in [this introductory video](https://www.youtube.com/watch?v=7TQ3xqglY80) or in [these slides](https://confluence.ase.in.tum.de/display/IOS22CW/Intro+Course%3A+Mandatory+Assignment?preview=/120160455/121474151/PR.pdf).
-   Submit your app **by creating a pull request**, which one of the tutors will review.
    -   Requirements NOT met: The tutor asks you to update your pull request.
    -   Requirements met: The tutor will accept the pull request.
-   The **Deadline** is **20.04.2022, 11:59 PM**
    -   Make sure to submit your solution **at least one week earlier**, allowing sufficient time for pull request reviews by tutors.
-   **Interviews**: **21.04.2022 - 27.04.2022**
    -   After accepting you submission, we may invite you to a short interview to ensure that you implemented your Mandatory Assignment without the help of third parties.

## Requirements

The table below lists all of the requirements to your iPhone app in a short form. Refer to the [detailed list with hints and how-to's](https://confluence.ase.in.tum.de/display/IOS22CW/Intro+Course%3A+Mandatory+Assignment) while working on your app.

After verifying that you implemented each of them, put a ✅ into the *Implemented* column before submitting the pull request for review. Don't touch the *Fulfilled* column, it will be filled by your tutor.

> Submissions without a ✅ in each row will not be reviewed but rejected for another revision.

| #  | Description                                                                         | Implemented | Fulfilled |
|----|-------------------------------------------------------------------------------------|-------------|-----------|
| 1  | Create at least 5±2 custom views                                                    |      ✅     |     ❌     |
| 1a | Use the List view in at least one of the custom views                               |      ✅     |     ❌     |
| 1b | Use AsyncImage in at least one of the custom views.                                 |      ✅     |     ❌     |
| 1c | Import and display a custom font in at least one of the custom views                |      ✅     |     ❌     |
| 2  | Include at least one asynchronous API call handled using async / await.             |      ✅     |     ❌     |
| 2a | Handle network errors and display appropriate error messages.                       |      ✅     |     ❌     |
| 3  | Use the MVVM pattern throughout your app.                                           |      ✅     |     ❌     |
| 3a | Avoid business logic in your SwiftUI views.                                         |      ✅     |     ❌     |
| 3b | Use appropriate property wrappers in your views.                                    |      ✅     |     ❌     |
| 3c | Use at least one published property in a ViewModel.                                 |      ✅     |     ❌     |
| 4  | Follow Apple's Human Interface Guidelines while creating the UI.                    |      ✅     |     ❌     |
| 4a | Support Dark Mode.                                                                  |      ✅     |     ❌     |
| 5  | Include at least one third-party package.                                           |      ✅     |     ❌     |
| 5a | Ensure that you install the package of your choice using the Swift Package Manager. |      ✅     |     ❌     |
| 6  | Use SF Symbols.                                                                     |      ✅     |     ❌     |
| 7  | Source code follows best practices, is readable, and easy to understand.            |      ✅     |     ❌     |
| 7a | Follow coding guidelines.                                                           |      ✅     |     ❌     |
| 7b | Comment your code inline.                                                           |      ✅     |     ❌     |
| 7c | Document your code.                                                                 |      ✅     |     ❌     |
| 7d | Use Apple's Logger throughout your app.                                             |      ✅     |     ❌     |


## Documentation

> Make sure to remove all *TODO*s before you submit your app for review.

### Features

My app allows a parent to follow their children's vegetable consumption through added meals.
A user (a parent) can add children and meals to his/her account and get suggestions for meals. 
Each meal has a list of ingredients, such that an ingredient can either be a veggie or not. 


### Screens

Main screen: Home page of the user (no login necessay). The screen contains three buttons
	1. check my children: a space for the user to customize (add children, add meals for the respective child)
    2. get meal suggestions: loads a page with meal suggestions
    3. my cookbook: a Carousel representing all the meals saved in the model
Children list screen: contains a list of children with possibility to add children in a sheet
Child Screen: contains the description of the child (name and age) together with the list of meals the parent added for the child
Meals Overview screen: contains a list of meals fetched from an open source API 
Meal screen: contains a description and an image of the meal

Open features: 
	1. possibility to select a meal from the existing meals of the system 
    2. Help button leading to the meal suggestion in the meal creation sheet
    3. Editing existing child/meal

### Requirements

1. A user can add a child to a list of children: Add button with sheet
2. A user can add a meal to the list of meals of a child: Add button in childview with a form 
	** Option 1: create a totally new meal 
    ** Option 2: add meal from the cookbook
    /!\ The options are implemented through an alert message with three buttons (new meal + cookbook + cancel)
3. A user can get suggestions for meals: list of meals fetched asynchronously from a public API
4. A user can add a suggested meal to the cookbook 


#### 1) Create at least 5±2 custom views created

The views in this app are: 

	1. Content view: the opening screen of the app representing three clickable buttons 
    2. ChildrenListView: clicking the first button (check my children) leads to this view with a list of the user's added children
    	3. childView: a view for each child representing a description of the child (name and age) and the list of meals added for the child
    4. MealSuggestionView: a view representing a list of meals fetched from a public API 
    	5. MealView: a view representing all the infromation about a meal (name + ingredients + veggie grade (how many 🥦 in the meal) + instructions + image if availabel)
    6. CookbookView: A view with an installed package representing a Carousel view with all the meals in the system (meals from children or from meal suggestions)

#### 1a) Use the List view in at least one of the custom views

See ChildrenListView, MealSuggestionView, and ChildView

#### 1b) Use AsyncImage in at least one of the custom views.

See MealView: the image of the meal

#### 1c) Import and display a custom font in at least one of the custom views.

Imported and installed the custom font "DancingScript-Bold" and used it in several views through the app

#### 2) Include at least one asynchronous API call handled using async / await.

See MealSuggestionModel: used the async await to fetch meals from the public api https://www.themealdb.com/api.php

#### 2a) Handle network errors and display appropriate error messages.

See MealSuggestionModel and MealSuggestionView used Apple's logger to print catched error

#### 3) Use the MVVM pattern throughout your app.

See (ChildView + EditChildView + EditChildModel) and (MealView + EditMealView + EditMealModel)

#### 3a) Avoid business logic in your SwiftUI views.

Use of MVVM architecture: ViewModel encapsulates logic and View represents the screen architecture

#### 3b) Use appropriate property wrappers in your views.

Used @ObservedObject, @Published, @State, and @EnvironmentObject

#### 3c) Use at least one published property in a ViewModel.

See EditMealViewModel and EditChildViewModel for examples

#### 4) Follow Apple's Human Interface Guidelines while creating the UI.

The app supports dark mode. 
Use of functional buttons through the app.
Clear fonts, colors, and font sizes.

#### 4a) Support Dark Mode.

The app supports dark mode:  @Environment(\.colorScheme) var colorScheme in ContentView

#### 5) Include at least one third-party package.

See Cookbook view: included ACarousel package for a nice representation of the meals in the cookbook

#### 5a) Ensure that you install the package of your choice using the Swift Package Manager.

The package appears under Frameworks, libraries, and Embedded Content

#### 6) Use SF Symbols.

See:
	1. ContentView: icons for the three buttons in the main screen
	2. MealView (leaf symbol)
    3. Sheets: plus button
    4. Cookbook: forward and backward arrows at the bottom of the carousel
    

#### 7) Source code follows best practices, is readable, and easy to understand.

- The indentation is done in all files
- The code is segemented in smaller modules whenever necessary

#### 7a) Follow coding guidelines.

1. CamelCase naming of all variables and properties
2. use of argument labels for better readability

#### 7b) Comment your code inline.

Model functions commented throughout the code + use of Apple logger for better console interaction

#### 7c) Document your code.

Code documented in this Readme file. 

#### 7d) Use Apple's Logger throughout your app.

> TODO
