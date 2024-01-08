# README

This README is about installing the project Tic-tac-toe

Steps for installation :

Note : All command is based on windows OS.

1. Install ruby - v 3.3.0 on your device. Download ruby from (https://rubyinstaller.org/downloads/) based on your device.
2. Install rails - v 7.1.0 on your device with the command ( gem install rails ) which install the lastest version of rails.
3. Clone the repository.
4. Run " bundle install " command to install all the gems.
5. Run "rails s" command to start your rails application.
6. Application will be run in the port (3000) with the url (http://localhost:3000)  

Game :

You can start your game by as a first player (X) and second player (O).

Issue : 

There is an issue like you have to refresh your webpage for every player's turn. I am unable to make a call for every turn because the webpage to render by TURBO_STREAM by rails only in first webpage render it is render by HTML. 