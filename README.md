### The Test

In terms of the test, everything that was asked to be done was completed.

There were however some parts that I didn’t finish but felt that there wouldn’t be much gain in it though, since I believe I was able to showcase my expertise.

When it comes to these improvements, I’ll do a quick run of improvements that I would do as someone that would be developing an app of this scope and wanted to deploy this app to the AppStore while building a business like Jamble.

1. Filters

- Filters are currently only single-selectable. This means that if the customer selects a second filter the previously selected one is unselected. A solution I had in mind was to open a modal with the list of filters, grouped by section (Size, Color, Price Range, etc.) where the customer would be able to select whatever filters they would want.
- A filter is not un-selectable unless the “Reset” button is tapped. A way to fix this would be the point above.
-  The way products are being filtered is also not the best/most optimal way. Once again, this was because of the scope of the exercise, where time is limited and I just wanted to get things working.
-  The filter logic should be behind the ViewModel, not in it. This would allow us to have a different filter engine in the future if we would want, which could be easily switchable, almost like a plug-in. Basically the same logic as for a network/database engine where it could be changed without the ViewModel/View layers having to know about it.

2. Error Handling

- In terms of error handling, I would have added an “Empty Results” screen to better show the customer that their filters got no results. In this case the only way to achieve this scenario would be through search.
- The Product List View Controller should also be able to handle errors that come from data loading, since this could come from local storage, a network service, a database, etc.

3. Tests

- I added 2 tests just to show you that I know how to write tests and how to code an app to be testable. Wanted to show my expertise here a bit more but once again, due to time constraints I had to leave these for last.

Still, hope you found the project valuable and enough to grasp my knowledge and how I could be an asset to Jamble. I’m free to answer any questions about the architecture or how/why I achieved this end result.

Cheers!

![2](https://github.com/TiagoSantosSilva/JambleTest/assets/23014633/5de4031e-7a95-4c00-b24f-d384f35c4e34)
![1](https://github.com/TiagoSantosSilva/JambleTest/assets/23014633/f402aa4d-8fb7-479e-82ed-a1c973466be3)
