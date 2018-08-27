# quandoo

Task:
Create an iOS client Application for the https://jsonplaceholder.typicode.com/ sample REST API. Requirements:
Application should contain 2 screens – User List and Post List. Special attention should be paid to code organization. Please keep it well organised and testable.
User List - https://jsonplaceholder.typicode.com/users The first screen should display a list of all users.
Every cell in match list should have following data:
* Name: - First and Last Name of the user
* Username
* Email
* Address – User’s address (street, suite, city and zip code). It should be concatenated as one string and not multiple labels.
Please use the custom created UITableViewCell, not the default one.
Constraints should be used in order for the content to be displayed in same manner on different screen sizes. Feel free to increase the height of the cell so all data could be displayed properly.
    
Post List - https://jsonplaceholder.typicode.com/posts?userId=<USER_ID>
The second, Post List screen, should be displayed when one of users from the first screen is selected.
This screen should display all posts from selected user.
Requirements for the Post List screen:
* Post Title
* Post Body
Constraints should be applied on this screen too so UI is stretched in same manner on different screen sizes.
Cell height should be dynamical so complete content of the post is displayed.
