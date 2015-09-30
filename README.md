# TrendingVenues

### Intro
Application to fetch a list of venues near an particular location. The result is displayed in a table. The app also offers the ability to view the found venue in a map. A pin is dropped on the map to indicate when the venue is.

### Overview
I have used test able services within in the application, all of which conforming to an interface. (Protocol) This allows for ease of use and Liskov substitution principle. Each service is responsible for a single responsibility. The services in this application use a block based API. However, if there where multiple recipents of the services, multi delegatation would become more apporiate. Also you will see that dependency injection is used to pass weak references. With the AppAssembly managing the objects lifecycle.

### Application
The application is split into these main directories;
- Application - Includes application code to bootstrap
- Business Logic - Includes reuse code for additional targets. Services are included here, which will provide the information required by the UI.
- View Controllers - The main infrasture for the app.
- Views - Custom views and generally any subclass of UIView.

### Open Source
The project is setup using cocoapods, including the following;
- pod 'Mantle', 		'1.3.1', // Used for parsing JSON
- pod 'Masonry',  	'0.6.1', // Used for aiding autolayout syntax
- pod 'SDWebImage', '3.7.1'  // Not used. But would be in the future for image download and caching
- pod 'OHHTTPStubs', '3.1.7' // Not used. But would be in the future for mocking the network requests, and uniting testing the remote service(s).
    
    

