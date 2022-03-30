# Netic
WebApps Development Final Project - Netic Web Aplication for online dating with simple search engine. 

In this project a simple dating application is design, with a user-friendly interface. Both user and admin roles are included, with different 
contents and functionalities each one.

The application is based on the ability to find the person most similar to the user preferences. For this purpuse, a search engine with several filters is developed, in in which the user can select those criteria that interest him or her. As a result, thweinternal logic of the application will show him/her the profiles that match those criteria. Moreover, users can interact with other profiles founded (likes, comments, view profile). However, no chat between users has been developed till now.
During an user session, unlimited searches and interactions with other profiles can be done. User profile's activity can be seen at any time.
In order to make this search engine work properly, several relational databases with many fields are used, which collect the detailed data from every profile logged, and any updates done (data modified, interaction, deleted accounts, etc).

The admin role can manage every user account, and collect simple statistics about the whole users' activity.

This web app is developed using web technologies (HTML, CSS, Bootstrap, Jquery, JScript, JSP) on the front-end side, Java Servlets for back-end and a mysql Database. Regarding software architecture, a DAO Pattern is used, in which a driver tipe 4 (JDBC) is used for the connection with the database.
