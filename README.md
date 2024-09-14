# WebNote : Notes Management Application 
 
WebNote is a fully-featured notes management system that allows users to create, edit, delete, and manage their notes. The system includes user authentication and profile creation, ensuring that each user has a personalized experience. WebNote stores notes securely in a MySQL database and offers the ability to download notes in text format. Additionally, users can edit their notes, manage sessions through cookies, and access their note history for review. The application is built using a combination of HTML, CSS, JavaScript, and JSP for server-side interactions.

## Features
- User Authentication and Profile Creation: Users can register, log in, and manage their profiles, allowing for a personalized and secure notes experience.
- Create, Edit, and Delete Notes: Users can easily create new notes, edit existing ones, and delete notes they no longer need.
- Note History: Users can view a complete history of their notes, ensuring that previous versions or deleted notes can be accessed if needed.
- Download Notes: Users can download their notes in .txt format for offline access.
- Session Management: WebNote uses cookies to maintain user sessions, allowing for a smooth and continuous experience while interacting with the platform.

## Requirements
- Java with JSP for server-side interaction
- MySQL database for storing user profiles and notes
- HTML, CSS, and JavaScript for the front-end interface
- JDBC connector for database communication
- Apache Tomcat or any servlet container

## Database Setup
  ```sql
  create table formdetails(
  id int not null auto_increment,
  username varchar(255) not null,
  password varchar(255) not null,
  phone int(10) not null,
  email varchar(255) not null,
  dob varchar(255) not null,
  gender varchar(255) not null,
  address varchar(500),
  primary key (id)
  );
  ```

## Contributing
We welcome contributions from the developer community to help improve WebNote. Feel free to submit pull requests and report issues on GitHub.

## Demo Video
https://github.com/user-attachments/assets/a868f6b1-829d-489b-8813-6f27f91019e6

