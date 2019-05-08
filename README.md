# Photogram-App
a instagram style apps that integrate with Firebase as remote database 

This apps allow user to create account and post photos. All posts from every users will be shown on Feed 
This apps has summarize every thing I learnt about IOS Development

What I learnt:
- Use Firebase library to create a firebase auth pre build Ui View Controller. Once you click the button on Login page. It will
  automatically bring us to a pre build page to input your login info. If not exist, you will create one and store in Firebase 
  Authenication store. This security authenication is the backend service provided by firebase and you don't need to implement
  yourself. 
  
- complete the whole authenication path with sign out and implement local storage for logined in user

- make a subclass of UITabBarController to detect tab so when user tab camera icon, an ActionSheet will show up to request
  get photo from camera or library. After we choose either one, we will set UIImagePickerController with what we select and show 
  a message to user

- After a photo is selected, I set up a Photo service to upload the photo to Firebase storage and then push the reference url to 
  the Firebase database so we can use these urls to retrieve all the photos from the storage and pop them up in Feed page.
  
- implement getPhoto in PhotoService and setPhoto in PhotoCell and then delegate the tasks to TableView to actually update the view with retrieved photos on Feed page 

- use open source package SDWebImage to download images asynchronous so the UI view doesn't freeze waiting for the load   finished. Add a spinner from UIKit package when loading the photos or refresh. 

- how to get the progress of an upload to Firebase Storage with UICircularProgress Ring, to display the circular progress bar
  control, to navigate to a different tab upon upload completion.
  
  
How to run the app:

Clone the project and simply run it in Xcode with command + R.
You shouldn't need to install cocopod and firebase to your local machine
  
