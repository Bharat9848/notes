# General
- you will be judged on gathering requirements, scope down the problem and design using OOP design principles and SOLID.
- First figure out the primary use cases in first few minutes.
- Design should be shown in some form of UML diagrams and well defined classes with SOLID design and ood priciples
- extra points for thinking scalability, extensibility and maintainability beforehand.

# OOP Design priciple
- Object oriented analysis requires requirement gathering and recognizing objects that are required to model the system.
- Object oriented design entails further details out the objects by finding more contraints and detailing object interactions with the help of UML diagrams.
- Object oriented analysis and design are not to include any implementation details.
- **Encapsulation**: Mask the internal details of object representation from outside.
- **Abstraction**: Provide simple contractatual methods to outside world which decreases the overall complexity of the system by hiding complex details inside the implementation.
- **Inheritance**:
- **Polymorphism**

# Interface:
- interface provide access to resource.
- It consists of operations, event and properties.
- Interface can also have semantics e.g. transaction is an abstraction which guarantee atomicity.
- operation is synchronus ? 
- event for aysnchronus ?
- properties can be metadata like access rights, unit of measure or formatting assumption.
- Interface should follow **principle of least surprise**(consistent), **small interface principle**, **uniform access principle**(no implementation details) 
- Interface method names should not specific about resource properties. e.g calculateTotalForCategory - category is internal property of transaction, modifying it will require changes in interface.
- Interface method return type should be a generic wrapper domain class. Helps in reducing multiple flavor return type methods. 
- `void` should be avoided as return type from an interface method. As it is difficult to reason about and test.

# SOLID principle
1. **Single responsibility**
  - A class should have a single reason to change
  - no god classes

2. **Open-closed principle** 
 - class/method should be open to extend but closed for modification. Class/method should not be changed but we should strive for to extend it using new interfaces which can be extendable.
 - class should have most common part as methods which have more general implementation and non-common part is define as interface, it can be passed on as an argument.
 - Changing some part deep down in transitive dependency have ripple effect of chage in higher classes.

3. **Liskov substitution principle**
 - System should not break in case of subclasses references are substituted with superclass reference. It means system is not only working with substituted subclass. It is also working with all the subclasses of the superclass.
 - E.g. of violation is `Vehicle::startEngine` is not working in case of vehicle type `bicycle`. In this case it is better to break the vehicle interface to `Motorized` and `Manual` 
 - Precondition, postcondition, invarient should be completely abided by the subclass. 
4. **Interface segragation principle**: 
 - Dividing of interfaces can have following reasons
    - multiple actor needs access to subset of functionality.
    - different policy require for subset of functionality.
    - different supporting interfaces for debuggabilty
    - same functionality for non-authenticated users etc. 

5. **Dependency Inversion**
  - higher class module should dependent upon lower class module through abstraction, instead of knowing internal details of lower module classes.

## Genral good practice
- control flow mixed with business logic.
- Validation should be a separate class in case we want to run multiple logic across various properties of an entity.
- Validation exception should use **Notification** pattern. In notification pattern we capture all the error in string format and append them in a list and return to user in a single go.
- Dont use exceptions for control flow.
- **Where to put common code in a hierarchy**
  1. Putting common code in a util class from a hierarchy is bad design as it eventually lead to cross pollution from different requirement and make classes as god classes eventually.
  2. It is bad to use inheritance (using abstract classes) for common code from a hierarchy. It makes code less flexible for future changes. 
  3. Using a domain class is the best which mapped to real-world domain as much as possible. Every subclass can leverage the domain class common behavior.
- Test method names should start from a verb which should signify the behaviour under test. It should not be named as `test1`, `textFile` or exactly same as method under test.
 

## UML
- UML is composed of three main building blocks: things, relationships, and diagrams. 
- **UML Things** can be structural which includes. classes, objects, use case, interface, actor, component and node. Behavioural things include state activity and interaction diagram.  
- Structural diagram category includes class diagram, package diagram, object diagram and composite structure diagram. 
- Structural Implementation diagram category includes component and deployment diagram.
- Behavioural interaction diagram category includes sequence, communication, interaction overview and timing diagram.
- Behavioral diagram category includes usecase, activity and state machine diagram.

## Usecase diagram
 - It is used to depict flow and objective of all the usecases.
 - **Actor** interacts with the system, it can be human, hardware/machine and other external system. Primary actor interacts with the system. Any secondary actor is put on the right side of the system while primary is put on the left side of diagram.
 - **Usecase** it is typically mentioned in an oval shape
 - **package**: groups different elements(what is element ?) and it is represented through a folder icon. 
 - **Notes**
 - Relationship between usecases
  1. **Include** relationship: to include a usecase in other usercase e.g. online payment includes credit card validation usecase. It is a always-happen relationship.
  2. **Generalization** relationship: ??
  3. **Extends** relationship: a usecase extends other usecase e.g. Cash withdrawal usecase extends to enhance transaction usecase. It is shown by dashed arrow with `extends` keyword. It is a may-happen releationship 
 
## Class diagram
 - it is used to show static representation of classes for their roles and responsibities.
 - Class have three section - name, attributes and methods
 - abstract classes have `<<abstract>>` above its name.  
 - enum have `<<enumeration>>` above its name.  
 - interface have `<<interface>>` above its name.
 - annotations have `<<annotations>>` above its name.  
 - attributes can be prefixed with `+`, `-` and `#` to represent public, private and protected members.
 - Class relationship can be 
    - inheritance (an empty complete-shape arrow towards the superclass), 
    - association (an incomplete-shape arrow to holded class), 
    - composition (filled diamond arrow towards the aggregator which is a list of some element and empty incomplete shape towards single element definition) 
    - aggregation ( empty diamond arrow towards the aggregator), 
    - two way association with simple line without any arrow.	

## Sequence Diagram
 - `lifeline`, `activation bar` 
 - `object`/`actor` it can be a user, logical object like transaction in ATM domain, physical object like ATM, cash dispenser in ATM
 - Synchronus send messages are shown with solid line and filled arrow while asynchronus send messages are solid line with an open arrowhead.
 - Synchrounus reply messages are shown with dotted line with filled arrow.
 - object creation flow can be shown with new object box at the send message arrow.
 - object deletion flow can be shown with `X` mark in object timeline at the end of activation bar.
 - **fragment frame**
   1. `alt` for if-else flow. if block is separated from else block using horizontal dashed line encompassing whole frame. Conditions should be mentioned near the `alt` section.
   2. `loop`
   3. `par` for parallel flow.
   4. `opt` for single if block.

## Activity/ Flow Chart Diagram 
  - More coarse than sequential diagram as activity encompasses small message interaction between few objects.
  - `init` `end` circle for happy flow
  - `circle with X` can be used to represent error flow.
  - `action` in activity rectangle. It can be decision activity
  - `diamond` to represent divergence of a path to `yes/no` path. 
  - `diamond` to represent merge paths
  - **Fork and join** two solid line vertical bars can be used to show concurrent and parllel activity.  

## Design pattern 
 - see designPattern.md
 
## DAO pattern
- Data access object pattern: abstract the low level details of persistence mechanism which can be a db or file or in-memory. It uses an ID field to identify object.

# Practice question
 - Design tic-tac-toe: Classes - GamePlay
 - Design elevator system:
   -- see elevator repo
 - Design sudoku:
 - Design parkinglot
   -- see workspace repo parking lot.
 - Design ATM
   -- see workspace repo ATM 

# Machine coding
 - Snake and ladder
 - splitwise 
 - Parking Lot
 - Token Bucket
 - Trello
 - FLIPMED
 - Bowling Alley
 - Rate Limiter

## Rough
- "Design a Shipment & Package Management System with the following features:

 Add a package to the system → addPackage(packageId, weight, distance).
 Assign packages to a shipment → assignShipment(shipmentId)
 Calculate total shipment cost → calculateShipmentCost(shipmentId).
 Track shipment status → trackShipment(shipmentId).
  Update shipment status → updateShipmentStatus(shipmentId, status).
 Constraints:
 Each shipment has a weight limit of 100 kg.
 Packages should be prioritized by weight (heaviest first).
 Shipment cost formula:
[
\text{Cost} = \text{$10 (Base Fee)} + (2 \times \text{Total Weight}) + (5 \times \frac{\text{Total Distance}}{100})
]
https://leetcode.com/discuss/post/6377697/wayfair-machine-coding-practice-4-by-ann-qc23/
"
- "Problem statement
This problem requires you to implement a log watching solution (similar to the tail -f command in UNIX). However, in this case, the log file is hosted on a remote machine (same machine as your server code). The log file is in append-only mode.

You have to implement the following:

    A server side program to monitor the given log file and capable of streaming updates that happen in it. This will run on the same machine as the log file. You may implement the server in any programming language.

    A web based client (accessible via URL like http://localhost/log) that prints the updates in the file as and when they happen and NOT upon page refresh. The page should be loaded once and it should keep getting updated in real-time. The user sees the last 10 lines in the file when he lands on the page.

Problem Constraints
The server should push updates to the clients as we have to be as real time as possible.
Be aware that the log file may be several GB, how to optimise for retrieving the last 10 lines?
The server should not retransmit the entire file every time. It should only send the updates.
The server should be able to handle multiple clients at the same time.

The web page should not stay in loading state post the first load and it should not reload thereafter as well.
You may not use off-the-shelf external libraries or tools to read the file or provide tail-like functionalities.

We will be evaluating you for code quality, testability, modularity, corner cases, etc."


- "/ Implement simple circuit breaker given a rpc method.
// please consider the generic circuit breaker options like the following:
//
// * timeWindowSec - (10s) time sliding window size.
// * failureRatioThreshhold - (50%) failure ratio threshold in which the circuit open
// * circuitCloseTimeSec - (5s) required time to circuit re-close
// * min requests - 10

// Main class should be named 'Solution' and should not be public."


- "Vehicle Rental Service

Description:
Flipkart is starting a new vehicle rental service called FlipKar. In this service, we will rent different kinds of vehicles such as cars and bikes.

Features:
Rental service have multiple branches throughout the city.
Each branch has limited number of different kinds of vehicles. 
Each vehicle can be booked with predefined price per unit time slot. For simplicity, current pricing model does not support dynamic pricing or update on prices based on seasonality.
Each vehicle can be booked in multiples of 1 hour time slot.
All bookings should be made before the start time of particular booking.

Requirements:
Onboard a new branch with available vehicle.
Onboard new vehicle(s) of existing type to a particular branch.
Rent vehicle for a time slot and a vehicle type (lowest price as the default choice of selection of vehicle, this should be extendable to any other strategy). While booking a vehicle if availability is not there, then it should fallback to another available branch, which is derived based on the vehicle selection strategy.
A system view should be made available, such as currently blocked vehicles, available vehicles of all the branches.

Other Notes:
Do not use any database or NoSQL store, use in-memory data-structure for now. 
Do not create any UI for the application.
Write a driver class for demo purpose. Which will execute all the commands at one place in the code and have test cases.
Please prioritize code compilation, execution and completion. 
Work on the expected output first and then add good-to-have features of your own.

Expectations:
Make sure that you have working and demonstrable code.
Make sure that code is functionally correct.
Code should be modular and readable.
Separation of concern should be addressed.
Code should easily accommodate new requirements with minimal changes.
Code should be easily testable.


Test cases: 
(Test-cases are defined for understanding feature requirements only. Please model it appropriately based on your service implementation)
add_branch(‘koramangala’, [“1 suv for Rs.12 per hour”, “3 sedan for Rs.10 per hour”, “3 bikes for Rs.20 per hour”]); 
add_branch(‘jayanagar’, [“3 sedan for Rs.11 per hour”, “3 bikes for Rs.30 per hour”, “4 hatchback for Rs.8 per hour”]);
add_branch(‘malleshwaram’, [“1 suv for Rs.11 per hour”, “10 bikes for Rs.3 per hour” , “3 sedan for Rs.10 per hour”]);
add_vehicle(‘koramangala’,  “1 sedan”); //add 1 sedan to koramangala
rent_vehicle(‘suv’, 20th Feb 10:00 AM, 20th Feb 12:00 PM); // should book from malleshwaram.
rent_vehicle(‘suv’, 20th Feb 10:00 AM, 20th Feb 12:00 PM); // should book from koramangala.
rent_vehicle(‘suv’, 20th Feb 10:00 AM, 20th Feb 12:00 PM); //Should fail saying no vehicle.
print_system_view_for_time_slot(20th Feb 11:00 PM, 20th Feb 12:00 PM):
Output:
‘Koramangala’: 
All “suv” are booked.
1“sedan” is available for Rs.10
“bike” is available for Rs.20
‘Jayanagar’:
“sedan” is available for Rs.11
“bike” is available for Rs.30
“hatchback” is available for Rs.8
‘‘Malleshwaram’’:
All “suv” are booked.
“bike” is available for Rs.3
“sedan” is available for Rs.10"

- "Design an Online MarketPlace (similar to Flipkart & Amazon) with functonalities supporting User Login, Adding Product to Market Place. User can add Items to cart, then checkout cart to place Order & also support showing Order History."

- "Flipkart Machine Coding Challenge: Building a Static Email App

Just finished the machine coding round for Flipkart, and it was quite an interesting experience! Around 15 of us were on the call, all tackling the same challenge within a 90-minute timeframe.

The task was to build a static email application with the following core functionalities:

    Layout: A two-panel interface – a left sidebar for the inbox and a larger right panel for detailed email viewing.
    Data: We were provided with hardcoded email data by the interviewer.
    Inbox View (Left Panel): A scrollable list displaying individual emails.
        Click Interaction: Selecting an email in the list should:
            Open its detailed view in the right panel.
            Visually mark the email as "read" in the list (background changing to a light grey).
        Visual States:
            Currently Reading: The selected email in the list should have a subtle yellow background.
            Read: Previously opened emails in the list should have a light grey background.
            Unread: All unopened emails should have a white background.
    Email Detail View (Right Panel): Upon selecting an email, the right panel should display:
        Sender information.
        Timestamp of the email.
        A button to "Mark as Unread," which would revert its visual state in the left panel and its read status.
    Persistence: Both the "delete email" and "mark as read/unread" actions should persist across multiple hypothetical visits to the application.

Bonus Challenge:

    Implement a search bar at the top to filter the displayed emails.

    All of the code should be written in HTML, CSS and Vanilla JavaScript.

By God's grace I cleared the round."

- "Design a hackathon platform having the below features

• Contestants should be able to register themselves with their name and their
department name.
• A problem should have attributes like description, tag, difficulty level (easy, medium, hard), score.
•Contestants should be able to filter problems
based on difficulty level or tags and sort them based on score (design should be extensible to other attributes )
• A contestant should be able to solve a
problem as well as get the list of problems solved by him/her.
• A contestant should be able to see the number
of users that have solved a given problem and average time taken to solve that problem.
• Scoring strategy for a problem could simply be to award the score assigned for the problem or could be something different like a combination of score and time.

Return the current leader of the contest
• Users should be able to get curations like Top
10 most liked problems of a certain tag."

- "Need to design and implement an in-memory search engine for a collection of text documents. The goal was to perform searches based on keywords and return the results ordered by various criteria, such as document size or keyword frequency."

- "I was asked to design In-memory SQL-like Database in one of the interviews(can't reveal company name), that supports following operation.

    It should be possible to create or delete tables in a database.
    The supported column types are string and int.
    It should be possible to insert records in a table.
    It should be possible to print all records in a table.
    It should be possible to filter and display records whose column values match a given value.

Any help would be appreciated :)
Also it would be great if people can suggest some good resources(practice problems) for Machine Coding Rounds."

- "Problem Statement: Had to design an instagram feed consisting of two contributors, influencer and user. Infuencer could create the posts using hashtags and the users could follow hashtags/influencers. There were some more requirements like to keep track of followers, the views on the posts, and also a user could make a fetch query and could see the posts in their feed by the latest order of their creation. After some explanation of objects and classes, 1 hour was given to code the solution."

- "Design crick buzz - gave simple working solution
question asked - which design patterns should be used as i didn't use any in the code."

- "We are developing a rewards bidding system - BidBlitz for Flipkart, where Flipkart plus members will have the opportunity to win a lavish item each day. 
As an engineer, your task is to build a feature that allows members to place bids using their Flipkart Super Coins. 
● The winner of the item will be the member who places the lowest bid.
● At the end of each day, the system should declare the winner.
● Members should be able to view the winners of past events. 

This system aims to enhance member engagement and provide an exciting and rewarding experience for Flipkart plus users. 

    Explanations 

    What is the bid ? 
    a. Pledge Super coin to buy the lavish item 
    What is the BidBlitz Event ? 
    a. It is event in which members submit the bids and at the end of the event , winner is decided based on some criteria 
    (mentioned in the requirements) 
    Requirements 
        System should be able to add members and each member will have super coins assigned by system 
        a. Number of super coins assigned by system should be greater than zero
        System should be able to add event where event name should be unique for each event 
        a. System can only add one event in a single day 
        Members can register for the event and only registered members can participate in the event. 
        Members should be able to submit bids for a particular event as per the below conditions 
        a. Member can only submit all bids at single go and at max 5 bids can be submitted 
        b. Member should have atleast max of 5 bids super coins in his wallet 
        i. Suppose member submit bids -> 100,500,400,800,900 ii. Then member should have at least 900 super coins 
        available 
        iii. Only the max bid would be deducted from the member wallet 
    In above given example, only 900 super coins will be deducted from member wallet 
    c. Each bid should be unique for the member for that event i. Suppose member submit 4 bids -> 100, 200, 300, 400 ii. As each bid has unique value 
    d. Each bid should be greater than zero 
    5. System admin will declare the winner. 
    a. How is the winner decided? 
    i. Member with lowest bid will be declared as winner 
    ii. If the lowest bid is not unique then member who submitted lowest bid first will be declared as winner 
    Bonus Requirement 
    Members can see the winners of past events. 
    a. How many past events can be made visible -> 5 
    b. Order by ascending or descending 
    c. Winners should be sorted by event date
    Commands 
    ADD_MEMBER <number_of_super_coins> 
    a. Example : ADD_MEMBER 1 akshay 10000 
    b. Output : Akshay added successfully 
    c. Example : ADD_MEMBER 2 chris 5000 
    d. Output : Chris added successfully 
    ADD_EVENT <event_name> <prize_name>  
    a. Example : ADD_EVENT 1 BBD IPHONE-14 2023-06-06 
    b. Output : BBD with prize IPHONE-14 added successfully 
    REGISTER_MEMBER <member_id> <event_id> 
    a. Example : REGISTER_MEMBER 1 1 
    b. Output : Akshay registered to the BBD event successfully 
    SUBMIT_BID <member_id> <event_id> <bid_1> <bid_2> <bid_3> <bid_4> <bid_5> a. Example : SUBMIT_BID 1 1 100 200 400 500 600 
    b. Output : BIDS submitted successfully 
    c. Example SUBMIT_BID 2 1 100 200 400 500 
    d. Output : BIDS submitted successfully 
    e. Example : SUBMIT_BID 10 1 100 200 300 400 500 
    f. Output : Member did not registered for this event 
    DECLARE_WINNER EVENT_ID 
    a. Example : DECLARE_WINNER 1 
    b. Output : Akshay wins the IPHONE-14 with lowest bid 100 
    BONUS 
    LIST_WINNERS <order_by> 
    a. Example : LIST_WINNERS asc 
    b. Output : [ {event_id, winner_name, lowest_bid, date} ] 

    Guidelines

● Input can be read from a file or STDIN or coded in a driver method. [No Api and No UI] 
● Output can be written to a file or STDOUT. [No Api] 
● Store all interim/output data in-memory data structures. The usage of databases is not allowed.
● Restrict internet usage to looking up syntax. 
● Language should be Java only. 
● Save your code/project by your name and email it or upload on the google drive link provided. Your program will be executed on another machine. So, explicitly specify dependencies, if any, in your email. 

    Expectations

● The code should be demo-able (very important). The code should be functionally correct and complete. 
● At the end of this interview round, an interviewer will provide multiple inputs to your program for which it is expected to work 
● The code should handle edge cases properly and fail gracefully. Add suitable exception handling, wherever applicable. 
● An example would be to display an error message when the member trying to register for same event again or member does not have enough super coins to bid 
● The code should be readable, modular, testable, and extensible. Use intuitive names for your variables, methods, and classes. 
● It should be easy to add/remove functionality without rewriting a lot of code. 
● Do not write a monolithic code. 
● Don’t use any databases."


- "Design Restaurant Management System: ClearFood

Overview:

Restaurants can serve in multiple areas (identified by Pincode)
Location - At a time, users can order from one restaurant, and the quantity of food can be more than one.
Rating - Users should be able to rate any restaurant with or without comment. Rating of a restaurant is the average rating given by all customers.

Functional Requirements:

    register_restaurant(resturant_name, list of serviceable pin-codes, food item name, food item price, initial quantity) -> Register Restaurant
    update_quantity(restaurant name, quantity to Add) -> Restaurant owners should be able to increase the quantity of the food item:
    rate_restaurant(restaurant name, rating, comment) -> Users should be able to rate(1(Lowest)-5(Highest)) any restaurant with or without comment.
    show_restaurant(rating/price) -> User should be able to get list of all serviceable restaurant, food item name and price in descending order, based on rating, possibly based on price
    place_order(restaurant name, quantity): A restaurant is serviceable when it delivers to the user's pincode and has a non-zero quantity of food item. Place an order from any restaurant with any allowed quantity.
    order_history(username) -> Order History of User: For a given user you should be able to fetch order history.

Note:-
We can use in memory DB
Do not create any UI for the application
We can have driver class to simulate all these Operation

Expectations:-

    Code Completion : Working Executable Code
    Feature Coverage
    Design Principles

Sample flow

User Registration :
register_user(“Pralove”, “M”, “phoneNumber-1”, “HSR”)
register_user(“Nitesh”, “M”, “phoneNumber-2”, “BTM”)
register_user(“Vatsal”, “M”, “phoneNumber-3”, “BTM”)
login_user(“phoneNumber-1”)

Restaurant Registration :
register_restaurant(“Food Court-1”, “BTM/HSR”, “NI Thali”, 100, 5)
NOTE: we will have 2 delimiters in input : ',' to specify separate fields & '/' to identify different pincodes.
register_restaurant(“Food Court-2”, “BTM/pincode-2”, “Burger”, 120, 3)
login_user(“phoneNumber-2”)
register_restaurant(“Food Court-3”, “HSR”, “SI Thali”, 150, 1)
login_user(“phoneNumber-3”)

Fetch Restaurant List :
show_restaurant(“Price”) —-> Output : Food Court-2, Burger | Food Court-1, NI Thali

Place Order :
place_order(“Food Court-1”, 2) —-> Output: Order Placed Successfully.
place_order(““Food Court-2”, 7) —-> Output : Cannot place order

Add Review :
create_review(“Food Court-2”, 3, “Good Food”)
create_review(“Food Court-1”, 5, “Nice Food”)

show_restaurant(“rating”) —->
Output : Food Court-1, NI Thali Food Court-2, Burger

login_user(“phoneNumber-1”) —> update_quantity(“Food Court-2”, 5)
Output: Food Court-2, BTM, Burger - 8

update_location(“Food Court-2”, “BTM/HSR”) —>
Output: Food Court-2, “BTM/HSR”, Burger - 8

Additional Notes:

    The round was of 1:30 hours duration, which consisted of problem understanding, performing the actual implementation, on a language of your choice on your local editor, and then discussion.
    Since the time was limited, interviewer was interested majorly on the model design, and implementations of the methods was dependant on the remaining timeframe. But this was not communicated properly, and later on I was told that my model implementations are not extensible as per the overall problem statement. The interviewer started comparing that how will my solution work for existing features in Zomato, in which I told that I considered the design as per the current problem statement, and not a general one.
    Overall, I would say that even the interviewer was not clear if the expectations are as per a general machine coding round or an LLD design round. I communicated the same and he became infuriated, and later on gave me no hire, which I expected :)
    If someone goes for interview with them in future, I would only advise them to clarify the expectations properly beforehand, and ask them what is their priority (model/schema design or actual working code), since time is very less for a complete implementation.
"

- "Ride Hailing Service Backend: Machine Coding Problem

We need to build a backend for the ride hailing platform like Uber. Come up with working runnable code for it.
Functional Requirements:
Register user and driver.
Implement a pricing strategy including these factors- surge, car type, distance, etc. Show users the price for each car type to choose from.
Book a ride if a driver is available within a certain radius.
Points to Note:
Avoid any service coding frameworks like spring/express.
Feel free to assume any other detail.
Write clean and extensible production quality code.
Using a database is not required. Store data in-memory only.
Making APIs is not required.
Add comments where you feel you could have done better given more time.
Do specify any assumptions you make.

Solution-
https://github.com/anomaly2104/lld-cab-booking-ola-uber-grab-lyft"


- "Create an application like Trello which is a project management application, where you can manage your project by tracking smaller tasks. For reference : https://trello.com/

(think of it as similar to Jira Board)

Basic Features and workings :
The application contains multiple boards to signify different projects
Each board contains different lists to signify sub-project
Each list contain different cards signifying smaller tasks
Each card can be assigned to a user or may remain unassigned
Optional to take command line input OR write unit tests to test the functionality.
Definitions :
User: Each user should have a userId, name, email.
Board: Each board should have an id, name, url, members, lists
List: Each list should have an id, name and cards .
Card: Each card should have an id, name, assigned user, priority.
Attributes of card::
id, name, description, assigned user, priority.
Id to be unique , card to be identified by id .
Card to be uniquely identified on a board.
Requirements :
We should be able to create/delete boards, add/remove people from the members list (project members) and modify attributes. Deleting a board should delete all lists inside it.
We should be able to create/delete lists and modify attributes. Deleting a list should delete all cards inside it.
Cards inside a list should be sorted by priority
Deleting a member should assign cards associated with them to unassigned
We should be able to create/delete cards, assign/unassign a member to the card and modify attributes.
Users can create cards /edit boards.
We should also be able to move cards across lists in the same board
Ability to show a single board.
Cards should be unassigned by default
Ids should be auto-generated for board/list/card
Do not allow more than 5 issues to be assigned to an assignee in a board.
Updates to list, card, board should be thread safe.
Bonus:

Users should be able to do the Search. Search can be on user name, description,etc. Search can happen is 2 ways.
Search in the entire Board
Search in the entire List
We might add more such options in the future

Guidelines:

Time: 120 min
Write modular and clean code.
A driver program/main class/test case is needed to test out the code by the evaluator with multiple test cases. But do not spend too much time in the input parsing. Keep it as simple as possible.
Evaluation criteria: Demoable & functionally correct code, Code readability, Proper Entity modelling, Modularity & Extensibility, Separation of concerns, Abstractions. Use design patterns wherever applicable
You are not allowed to use any external databases like MySQL. Use only in memory data structures.
No need to create any UX"

- "Design Stack Overflow like service-"




