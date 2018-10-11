#!/bin/bash

# Focus an app
function focusApp() {
    osascript <<EOT
        tell app "$*"
        activate
        end tell
EOT
}

function reloadApps() {
	# Install the necessary applications
	brew cask install adobe-acrobat-reader
	brew cask install microsoft-office
	brew cask install zoomus
	brew cask install zoomus-outlook-plugin
	brew cask install teamviewer
	brew cask install dropbox
	brew cask install google-chrome
	brew cask install slack
	
	# Redo the application layout
	appLayout
}

function appLayout() {
	# Set the Dock to default values
	defaults delete com.apple.dock; killall Dock

	# Remove all unneccessary Applications
	dockutil --remove Siri
	dockutil --remove Mail
	dockutil --remove Contacts
	dockutil --remove Calendar
	dockutil --remove Notes
	dockutil --remove Reminders
	dockutil --remove Maps
	dockutil --remove Photos
	dockutil --remove Messages
	dockutil --remove FaceTime
	dockutil --remove Pages
	dockutil --remove Numbers
	dockutil --remove Keynote
	dockutil --remove iTunes
	dockutil --remove iBooks
	dockutil --remove Safari
	dockutil --remove App\ Store
	dockutil --remove System\ Preferences

	dockutil --add /Applications/Safari.app
	dockutil --add /Applications/Google\ Chrome.app
	dockutil --add /Applications/Slack.app
	dockutil --add /Applications/Adobe\ Acrobat\ Reader\ DC.app
	dockutil --add /Applications/Microsoft\ Outlook.app
	dockutil --add /Applications/Microsoft\ Powerpoint.app
	dockutil --add /Applications/Microsoft\ Word.app
	dockutil --add /Applications/Microsoft\ Excel.app
	dockutil --add /Applications/Zoom.us.app
	dockutil --add /Applications/TeamViewer.app
	dockutil --add /Applications/System\ Preferences.app
}

# Bash setup to get the computer on the AD Server

if [ "$1" == "-renameComputer" ]; then
	echo "What would you like to name the computer?"
	read compName
	scutil --set ComputerName $compName
elif [ "$1" == "-ADJoin" ]; then

	echo "Don't forget to add this computer to SmartSheets"
	sleep 1
	echo "Here's the Serial Number:"
	sleep 1
	system_profiler |grep "Serial Number (system)"
	read -p "Press Enter when ready to continue with the script"

	my_name=$(basename -- "$0")
	# Make a copy of the script in the shared folder
	echo Making a copy of the script in the shared folder "/Users/Shared"
	mydir=$(dirname "$0")
	cp "${mydir}"/"${my_name}" /Users/Shared
	
	sleep 1
	
	# Modify the name of the computer
	echo "What would you like to name the computer (typically this is first initial last name)?"
	read compName
	echo "A pop up will appear twice to set the name, fill it in twice"
	sleep 2
	scutil --set ComputerName $compName
	scutil --set LocalHostName $compName
	
	
	# Loop until the computer is properly binded
	adSuccess="n"
	while [ $adSuccess != "y" ]; do
		echo "Type in your AD Account (whole email address) name with binding rights"
		read adName
		
		echo "Type in the AD Account Password:"
		read -s pwName
		
		# Connect it to the AD
		dsconfigad -a $compName -domain thetradedesk.com -u $adName -p $pwName -mobile enable -mobileconfirm disable -localhome enable
		
		echo "Was the AD Join successful? (y/n) This is case sensitive"
		read adSuccess
	done
	
	# Keeps the admin password in a cache temporarily (or at least attempts to)
	echo "Type in the Admin password for this computer to start the app installation process (it may ask again while running)"
	SUDOCREDCACHED=1
	
	while [ $SUDOCREDCACHED != 0 ]; do
		read -s adminPW
		
		echo "$adminPW" | sudo -S -v
		
		sudo -nv 2> /dev/null
		SUDOCREDCACHED=$?
		if [ $SUDOCREDCACHED != 0 ] ; then 
		  echo "Incorrect Password, try again"
		  sudo -k
		fi
	done
	
	# Set the computer to not sleep
	echo "Setting the computer to never sleep as to not affect the downloads"
	sleep 1
	sudo systemsetup -setsleep Never
	sudo systemsetup -setcomputersleep Never
	sudo systemsetup -setdisplaysleep Never
	defaults -currentHost write com.apple.screensaver idleTime 0

	
	echo "A lot of text is about to appear, but that's okay!"
	sleep 2

	# Load homebrew onto computer temporarily
	yes '' | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# Make sure home brew is updated
	brew update
	
	# Install DockUtil for the user setup
	brew install dockutil

	# Install cask to download applications
	brew install cask

	# Set the cask application download location to the default application folder
	# brew cask --caskroom=/Applications

	# Install the necessary applications
	reloadApps

	# Set the applications to the dock properly
	appLayout
	
	# Cleanup the unneeded files
	brew cleanup
	
	# Allow other users to utilize Homebrew
	chgrp -R admin /usr/local/*
	chmod -R g+w /usr/local/*
	
	focusApp 'Terminal'
	
	# Enable Firewall
	echo "Enabling FireWall"
	sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
	echo "Firewall Enabled"
	
	# Add the login options for the computer
	echo "Open up System Preferences -> Users -> Login Options -> Add Current User, Desktop Admins and User Admins"
	sleep 1
	osascript -e 'activate application "System Preferences"'
	focusApp 'Terminal'

	read -p "Press Enter to continue once completed with the step above"
	
	echo "$adminPW" | sudo -S -v
	
	# Download Sophos files
	cd /Users/Shared

	mkdir SophosInstall
		
	curl -O https://dzr-api-amzn-us-west-2-fa88.api-upe.p.hmr.sophos.com/api/download/3630f6d5ccfb1605df373ca13e22df13/SophosInstall.zip
	
	unzip SophosInstall.zip -d /Users/Shared/SophosInstall
	
	# Install Sophos onto the computer
	echo "Installing Sophos (if terminal locks up on sophos install, feel free to close once sophos completes)"
	
	sudo chmod a+x /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/Sophos\ Installer
	sudo chmod a+x /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/tools/com.sophos.bootstrap.helper

	# Install Sophos from within folder (this will open another menu)
	#sh -c "sudo /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/Sophos\ Installer --install"
	
	open /Users/Shared/SophosInstall/Sophos\ Installer.app
	
	read -p "Press Enter once Sophos has been installed"

	rm -rf SophosInstall.zip

	# Removing the sophos installer
	rm -rf SophosInstall

	# Update Operating System and preinstalled apps
	echo "Please check that all applications have been downloaded correctly."
	sleep 2
	echo "Did all applications download properly? (y/n) do not capitalize."
	read downloadResponse
	
	if [ $downloadResponse != 'y' ]; then
		sh /Users/Shared/"${my_name}" -appLoad
	fi
	
	read -p "Press Enter when ready to restart the computer"

	echo "$adminPW" | sudo -S sh -c "softwareupdate -ia && reboot"
	
	
elif [ "$1" == "unbind" ]; then
	echo "Type in your AD Account (whole email address) name with binding rights"
	read adName
	dsconfigad -f -r -u $adName
	
elif [ "$1" == "-setup" ]; then
	my_name=$(basename -- "$0")
	currUser="$(whoami)"
	isAdmin=0
	
	#echo "Type in the Admin Password to join computer as admin (may be prompted twice)."
	#su admin -c "sudo dscl . -merge /Groups/admin GroupMembership $currUser"

	while [ $isAdmin != 1 ]; do
	# Login as admin temporarily
		echo "Logging in as Local Admin to give this user admin rights"
		sleep 1
		echo "Type in Local admin password (you may be prompted twice)"
		su admin -c "sudo dscl . -merge /Groups/admin GroupMembership $currUser"

		if groups $currUser | grep -q -w admin; 
		then 
			isAdmin=1
		else 
			echo "Did not add user successfully, try again"
		fi
	done
	# Keeps the admin password in a cache temporarily (or at least attempts to)
	
	echo "Added $currUser as an administrator for the computer!"
	sleep 1

	# Set Dock layout
	appLayout

	# Download Meraki onto the computer
	echo "Opening Safari for you to install Meraki onto the computer"
	sleep 2
	open https://m.meraki.com
	read -p "Press Enter once you have added the computer to Meraki"
	
	echo "Loading the second part of the Meraki installation"
	sleep 2
	curl -O https://n196.meraki.com/ci-downloads/121c309f9c83aa472e6bbd230cdf37c728582ab7/MerakiPCCAgent.pkg
	open MerakiPCCAgent.pkg
	read -p "Press Enter once you have finished the second part of the Meraki installation"
	osascript -e 'quit application "Safari"'
	
	# Have the admin set the homepage information for the user
	echo "Opening Chrome so you can set the home page to myapps.microsoft.com (set as default app as well)"
	sleep 2
	osascript -e 'activate application "Google Chrome"'
	read -p "Press Enter to continue"
	osascript -e 'quit application "Google Chrome"'

	echo "Opening Safari and set the home page to myapps.microsoft.com"
	sleep 2
	osascript -e 'activate application "Safari"'
	read -p "Press Enter to continue"
	osascript -e 'quit application "Safari"'
	
	echo "All done! Validate that all applications had been installed, running Tail request to validate Meraki is correctly running"
	echo "If you see ping requests to the file then you know it is working properly, close script whenever and restart the computer"
	sleep 2
	
	tail /var/log/m_agent.log
	
	sleep 3
	
	echo "Time for cleanup, when ready press enter"
	read -p "then type in the admin password which will run the cleanup portion of the script"
 	
	su admin -c "/Users/Shared/'${my_name}' cleanup"
	
elif [ "$1" == "-appLoad" ]; then
	my_name=$(basename -- "$0")
	# Keeps the admin password in a cache temporarily (or at least attempts to)
	echo "Type in the Admin password for this computer to start the app installation process (it may ask again while running)"
	read -s adminPW
	echo "$adminPW" | sudo -S -v
	
	# echo "A lot of text is about to appear, but that's okay!"
	# sleep 2

	# Load homebrew onto computer temporarily
	# yes '' | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# Make sure home brew is updated
	#brew update
	
	# Install DockUtil for the user setup
	# brew install dockutil

	# Install cask to download applications
	# brew install cask

	# Install the necessary applications
	reloadApps

	# Set Layout
	appLayout
	
	# Cleanup the unneeded files
	brew cask cleanup
	
	# Allow other users to utilize Homebrew
	# chgrp -R admin /usr/local/*
	# chmod -R g+w /usr/local/*

elif [ "$1" == "-sophos" ]; then
	# Download Sophos files
	cd /Users/Shared

	mkdir SophosInstall
		
	curl -O https://dzr-api-amzn-us-west-2-fa88.api-upe.p.hmr.sophos.com/api/download/3630f6d5ccfb1605df373ca13e22df13/SophosInstall.zip
	
	unzip SophosInstall.zip -d /Users/Shared/SophosInstall
	
	# Install Sophos onto the computer
	echo "Installing Sophos (if terminal locks up on sophos install, feel free to close once sophos completes)"
	
	sudo chmod a+x /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/Sophos\ Installer
	sudo chmod a+x /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/tools/com.sophos.bootstrap.helper

	# Install Sophos from within folder (this will open another menu)
	# sudo /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/Sophos\ Installer --install
	
	open /Users/Shared/SophosInstall/Sophos\ Installer.app
	
	read -p "Press Enter once Sophos has been installed"

	rm -rf SophosInstall.zip

	# Removing the sophos installer
	rm -rf SophosInstall
	
elif [ "$1" == "cleanup" ]; then
	my_name=$(basename -- "$0")
	echo "You may be prompted for the admin password a few times, removing Homebrew"
	sleep 2
	yes "" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
	
	read -p "Almost done. Don't forget to add the printer for this user's location! Press Enter once completed"
	
	echo "All done!, feel free to close the terminal and restart the computer at this point."
	
	sleep 10
	exit

elif [ "$1" == "-secureToken" ]; then
	echo "Type in the userName of the user on this computer (first.lastname)"
	read currUser
	
	# Check if the user has the secure token enabled
	sudo sysadminctl interactive -secureTokenStatus $currUser
	
	echo "Is the Secure Token Enabled? (y/n) capitalization matters."
	read secToken
	
	if [ $secToken == 'n' ]; then
		echo "Running command to enable Secure Token."
		sleep 2
		sudo sysadminctl interactive -secureTokenOn $currUser -password -
		
		sudo sysadminctl interactive -secureTokenStatus $currUser
		
		echo "Done! Feel free to close terminal at this time."
	fi
		
elif [ "$1" == "-noAD" ]; then
	# Make a copy of the script in the shared folder
	my_name=$(basename -- "$0")
	echo Making a copy of the script in the shared folder "/Users/Shared"
	mydir=$(dirname "$0")
	cp "${mydir}"/"${my_name}" /Users/Shared
	
	sleep 1
	
	# Modify the name of the computer
	echo "What would you like to name the computer (typically this is first initial last name)?"
	read compName
	echo "A pop up will appear twice to set the name, fill it in twice"
	sleep 2
	scutil --set ComputerName $compName
	scutil --set LocalHostName $compName
	
	# Keeps the admin password in a cache temporarily (or at least attempts to)
	echo "Type in the Admin password for this computer to start the app installation process (it may ask again while running)"
	SUDOCREDCACHED=1
	
	while [ $SUDOCREDCACHED != 0 ]; do
		read -s adminPW
		
		echo "$adminPW" | sudo -S -v
		
		sudo -nv 2> /dev/null
		SUDOCREDCACHED=$?
		if [ $SUDOCREDCACHED != 0 ] ; then 
		  echo "Incorrect Password, try again"
		  sudo -k
		fi
	done
	
	echo "A lot of text is about to appear, but that's okay!"
	sleep 2

	# Load homebrew onto computer temporarily
	yes '' | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# Make sure home brew is updated
	brew update
	
	# Install DockUtil for the user setup
	brew install dockutil

	# Install cask to download applications
	brew install cask

	# Install the necessary applications
	reloadApps

	# Set the applications to the dock properly
	appLayout
	
	# Cleanup the unneeded files
	brew cleanup
	
	# Allow other users to utilize Homebrew
	chgrp -R admin /usr/local/*
	chmod -R g+w /usr/local/*
	
	focusApp 'Terminal'
	
	# Enable Firewall
	echo "Enabling FireWall"
	sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
	echo "Firewall Enabled"
	
	# Add the login options for the computer
	echo "Open up System Preferences -> Users -> Login Options -> Add Current User, Desktop Admins and User Admins"
	sleep 1
	osascript -e 'activate application "System Preferences"'
	focusApp 'Terminal'

	read -p "Press Enter to continue once completed with the step above"
	
	echo "$adminPW" | sudo -S -v
	
	# Download Sophos files
	cd /Users/Shared

	mkdir SophosInstall
		
	curl -O https://dzr-api-amzn-us-west-2-fa88.api-upe.p.hmr.sophos.com/api/download/3630f6d5ccfb1605df373ca13e22df13/SophosInstall.zip
	
	unzip SophosInstall.zip -d /Users/Shared/SophosInstall
	
	# Install Sophos onto the computer
	echo "Installing Sophos (if terminal locks up on sophos install, feel free to close once sophos completes)"
	
	sudo chmod a+x /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/Sophos\ Installer
	sudo chmod a+x /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/tools/com.sophos.bootstrap.helper

	# Install Sophos from within folder (this will open another menu)
	#sh -c "sudo /Users/Shared/SophosInstall/Sophos\ Installer.app/Contents/MacOS/Sophos\ Installer --install"
	
	open /Users/Shared/SophosInstall/Sophos\ Installer.app
	
	read -p "Press Enter once Sophos has been installed"

	rm -rf SophosInstall.zip

	# Removing the sophos installer
	rm -rf SophosInstall

	# Update Operating System and preinstalled apps
	echo "Please check that all applications have been downloaded correctly."
	sleep 2
	echo "Did all applications download properly? (y/n) do not capitalize."
	read downloadResponse
	
	if [ $downloadResponse != 'y' ]; then
		reloadApps
	fi
	
	read -p "Press Enter when ready to restart the computer"

	echo "$adminPW" | sudo -S sh -c "softwareupdate -ia && reboot"
else
	echo "Error: No arguments / incorrect args provided, to utilize this script please utilize one of the below options"
	echo "1) -ADJoin  			- Joins the computer to the Active Directory."
	echo "2) -renameComputer  	- Renames the computer for you."
	echo "3) -setup   			- Sets up the user account (use this once you're on the user account)."
	echo "4) -appLoad 			- Simply installs Homebrew and all of our applications."
	echo "5) -sophos  			- Loads Sophos onto the computer."
	echo "6) -noAD				- Loads all settings for setup without joining to domain."
fi
