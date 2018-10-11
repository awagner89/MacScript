# MacScript
Mac Script Implementation for automating the setup process

Here is the link to the file needed for the setup: MacScript_v8.sh

You can also download it by running in terminal:

cd Desktop
git clone https://github.com/MrNeilJ/MacScript.git
OLD VERSION JUST IN CASE: MacScript.sh

This guide is a breakdown of how to set a Mac up from start to finish using a bash script.  It looks long, but the reality is....if you know the admin password that you created on initial setup, then you have completed 99% of what is written below (smile).
/*****************************************************************************************************
Setup macOS out of the box and create Admin profile (latest OS version pre-installed at the factory)
******************************************************************************************************/
-Turn on the machine.
-Select the main language and click the arrow.
-Select the country where the machine will be used and click Continue.
-Select the appropriate keyboard layout and click Continue.
-Connect to the local wireless network and click Continue.
-Select Don't transfer any information now and click Continue.
-Check Enable Location Services on this Mac and click Continue.
-Select Don't sign in and click Continue.
-Click Skip.
-Click Agree.
-Click Agree.
-Create a computer account with the following info and click Continue:
	-Full name: Admin
	-Account name: Admin
	-Password: (current admin password)
	-Hint: Standard
-Set time zone based on current location should be checked.
-Uncheck both boxes in the Diagnostics & Usage screen and click Continue.
-Uncheck Enable Siri on this Mac and click Continue.
-Configure workstation per instructions below.

-Download the attached file and unzip it in an easy to find location.
-Open up the Terminal application
-Type "caffeinate -i sh" (no quotations) and a space
-Drag the file to the terminal window to auto fill the path to the shell file
-Before hitting enter add to the end of the current command "-ADJoin"
-It will look something like this: 
	-caffeinate -i sh Path/To/File/MacScript.sh -ADJoin
-IF YOU GET AN ERROR RUNNING IT:
	-In terminal type "chmod a+x " and then drag the file to terminal and then try it again
	-chmod a+x Path/To/File/MacScript_vX.sh
-The script will make a copy of itself in /Users/Shared for later use
-At the first prompt you are modifying the name of the computer, type in the users first initial and last name.
-If their name was Neil Johnson it would be NJOHNSON (also, if this is a refresh, make sure to increment the name of the computer by 1)
-You will be prompted twice for the password as we are changing the local and host name of the computer
-Next type in the name of the user that has binding privileges to the domain.  Type the binding users entire email address of this account (most likely will be your SSO Email).
-Type in the Binding User's password for that user.
-You may be prompted to type in the administrator password of the computer as well, so pay attention to the prompts.
-Once both are typed in you will see it hang on the command for about 1 minute as it adds it to the domain.
-If you see it state "Settings Changed Successfully" or "Opendirectoryd detected...Ignoring admin, Settings Changed Successfully" then type "y" otherwise type "n" at the prompt asking if it joined successfully.
-Next you will be asked to type in the admin password for the computer to start downloading the applications
-If you correctly typed the information in you will see a large amount of text appear where it will install Homebrew to assist with loading the applications.
-As a heads up, you may be prompted for the admin password for the computer as applications download (usually occurs on the first program, adobe reader).
-The script is automated from here for a bit, during this section it will:
	-Download programs:
	-Google Chrome
	-Adobe Acrobat
	-Microsoft Office Suite
	-Zoom
	-DropBox
	-Slack
	-Reformats the applications on the admin dock to ensure that they are all loaded properly
	-Enable FireWall
-Click on System Preferences → Users & Groups → Login Options
-Click on the Lock and type in the Administrator Password.
-Locate the options button to the right of Allow network users to log in at the login window
-Under the new window select the radio button for Only these Network Users
-Click the + icon in the bottom left of the window and add the current user we are adding, Desktop Admins, and User Admins
-The next prompt will be to load Sophos, which should automatically pop up for you
-On the pop up that appears for Sophos, click install in the bottom right of the window.
-Once completed, click okay and proceed with the terminal prompt by pressing enter.
-The computer should now restart (you will be given a moment to double check things before the restart is initiated by pressing enter once ready.
-RECOMMENDATION: If you are going to have the user remotely connect, I would recommend setting up teamviewer to startup with the computer before restarting the computer.
-Once the computer restarts wait about a minute for an arrow to appear to the left of the password area on the login screen.
-Click the arrow and then type in the information of the user you are adding to the computer.
-If you get a screen that talks about a Secure Token, type in admin and the administrator password and click continue THIS MUST BE DONE OTHERWISE IT WILL CAUSE ISSUES WITH FILE VAULT LATER!
-Configure User
-At the login screen, click Other (you may have to wait a minute or two for it to appear).
-Enter the SSO username and password for the assigned user and click the right arrow (you can omit the “@thetradedesk.com” part of the username).
-Skip the Apple iCloud login.
-Skip the Apple Touch ID setup.
-Leave Enable Siri on this Mac checked and click Continue.
-Once on the Desktop Get that installer file again (best to have this stored on a thumb drive)
-Open up terminal and drag the "MacScript.sh" file to the terminal window
-An easy way to locate the file is clicking anywhere on the desktop and press "Command + Shift + G"
-This will open a search for a specific location, in here type "/Users/Shared"
-You will find the file you're looking for in there.
-Once located and dragged in add "-setup" to the end of the path.
-OPTIONAL: Just run this in terminal instead to get the same result
-/Users/Shared/MacScript.sh -setup
-Once started you will be prompted for the Local Admin password for the computer (NOT THE USER'S SSO INFORMATION).
-The script will then automatically update the user to be an admin, then redo the dock layout (the screen will flash several times during this, that is normal).
-You will then be prompted to install meraki on the computer (it will open a safari link to the proper area).
-On this page type in "196-077-7073" into the prompt.  After which you will download a profile script for the user, trust this configuration profile 2-3 times.
-If asked for a password...swap the username for admin and the password as the local machine password.
-Once completed go back to the terminal and hit enter.
-It will then download the agent for Meraki.  Follow the installation prompts.
-If asked for a password...swap the username for admin and the password as the local machine password.
-If a GUI Popup appears asking for the password, replace the username with "admin" and the password with the local admin password.
-Once completed click enter in the terminal window.
-You will then be prompted to update the Chrome and Safari Homepage information (do so accordingly).
-Once completed with those two tasks the script will then validate that meraki was installed correctly by showing the tail command to you, verify that you see an output.
-After which the script will do a quick cleanup of homebrew which will require the local admin password.
-Lastly, add the correct printer for that user's location.  These printer locations can be located here: How to set up your laptop to print

Once done with that you're all done!


This looks like a lot, but if you remember to follow the prompts and know the admin password then this will be a breeze!