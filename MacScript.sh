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
	dockutil --remove News

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

function printerCheck() {
	echo "Would you like to add the office printers? (case matters)"
	read printChoice
	
	echo "To add the printers you will need to know the Site Code, would you like to see a list of the Site Codes? (y/n)"
	read siteList

	if [ $siteList == "y" ]; then
		echo "Site Code List:"
		echo "-------------------------"
		echo "BV = Bellevue"
		echo "BD = Boulder"
		echo "CH = Chicago"
		echo "HH = Hamburg"
		echo "HK = Hong Kong"
		echo "IR = Irvine"
		echo "LD = London"
		echo "LA = Los Angeles"
		echo "NY = New York"
		echo "SF = San Francisco"
		echo "SJ = San Jose"
		echo "ST = Seattle"
		echo "SG = Singapore"
		echo "SY = Sydney"
		echo "VT = Ventura (HQ 42)"
		echo "VN = Ventura (101)\n"
		sleep 1
	fi


	while [ $printChoice == "y" ]; do
		echo "Type in the site code of the office you want to add the printers of (VT, VN, NY, CH, etc). Case Matters"
		read siteCode

		if [ $siteCode == "BV" ]; then
			echo "Adding Bellevue Printers"
			lpadmin -p "BVPR01" -v "http://10.32.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "BVPR01 Added!"

		elif [ $siteCode == "BD" ]; then
			echo "Adding Boulder Printers"
			lpadmin -p "BDPR01" -v "http://10.5.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "BDPR01 Added!"
			lpadmin -p "BDPR02" -v "http://10.5.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "BDPR02 Added!"
			

		elif [ $siteCode == "CH" ]; then
			echo "Adding Chicago Printers"
			lpadmin -p "CHPR01" -v "http://10.6.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "CHPR01 Added!"
			lpadmin -p "CHPR02" -v "http://10.6.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "CHPR02 Added!"

		elif [ $siteCode == "HH" ]; then
			echo "Adding Hamburg Printers"
			lpadmin -p "HHPR01" -v "http://10.14.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "HHPR01 Added!"
			lpadmin -p "HHPR02" -v "http://10.14.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "HHPR02 Added!"

		elif [ $siteCode == "HK" ]; then
			echo "Adding Hong Kong Printers"
			lpadmin -p "HKPR01" -v "http://10.17.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "HKPR01 Added!"
			lpadmin -p "HKPR02" -v "http://10.17.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "HKPR02 Added!"

		elif [ $siteCode == "IR" ]; then
			echo "Adding Irvine Printers"
			lpadmin -p "IRPR01" -v "http://10.31.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "IRPR01 Added!"

		elif [ $siteCode == "LD" ]; then
			echo "Adding London Printers"
			lpadmin -p "LDPR01" -v "http://10.13.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "LDPR01 Added!"
			lpadmin -p "LDPR02" -v "http://10.13.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "LDPR02 Added!"

		elif [ $siteCode == "LA" ]; then
			echo "Adding Los Angeles Printers"
			lpadmin -p "LAPR01" -v "http://10.33.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "LAPR01 Added!"
			lpadmin -p "LAPR02" -v "http://10.33.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "LAPR02 Added!"

		elif [ $siteCode == "NY" ]; then
			echo "Adding New York Printers"
			lpadmin -p "NYPR01" -v "http://10.4.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "NYPR01 Added!"
			lpadmin -p "NYPR02" -v "http://10.4.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "NYPR02 Added!"
			lpadmin -p "NYPR03" -v "http://10.4.5.3" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "NYPR03 Added!"
			lpadmin -p "NYPR04" -v "http://10.4.5.4" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "NYPR04 Added!"
			lpadmin -p "NYPR05" -v "http://10.4.5.5" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "NYPR05 Added!"
		
		elif [ $siteCode == "SF" ]; then
			echo "Adding San Francisco Printers"
			lpadmin -p "SFPR01" -v "http://10.3.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "SFPR01 Added!"

		elif [ $siteCode == "SJ" ]; then
			echo "Adding San Jose Printers"
			lpadmin -p "SJPR01" -v "http://10.30.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "SJPR01 Added!"

		elif [ $siteCode == "ST" ]; then
			echo "Adding Seattle Printers"
			lpadmin -p "STPR01" -v "http://10.23.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "STPR01 Added!"

		elif [ $siteCode == "SG" ]; then
			echo "Adding Ventura (101) Printers"
			lpadmin -p "SGPR01" -v "http://10.11.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "SGPR01 Added!"

		elif [ $siteCode == "SY" ]; then
			echo "Adding Sydney Printers"
			lpadmin -p "SYPR01" -v "http://10.29.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "SYPR01 Added!"
			lpadmin -p "SYPR02" -v "http://10.29.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "SYPR02 Added!"

		elif [ $siteCode == "VT" ]; then
			echo "Adding Ventura (HQ) Printers"
			lpadmin -p "VTPR01" -v "http://10.1.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VTPR01 Added!"
			lpadmin -p "VTPR02" -v "http://10.1.5.2" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VTPR02 Added!"
			lpadmin -p "VTPR03" -v "http://10.1.5.3" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VTPR03 Added!"
			lpadmin -p "VTPR06" -v "http://10.1.5.6" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VTPR06 Added!"
			lpadmin -p "VTPR07" -v "http://10.1.5.7" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VTPR07 Added!"

		elif [ $siteCode == "VN" ]; then
			echo "Adding Ventura (101) Printers"
			lpadmin -p "VNPR01" -v "http://10.9.5.1" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VNPR01 Added!"
			lpadmin -p "VNPR12" -v "http://10.9.5.12" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VNPR12 Added!"
			lpadmin -p "VNPR03" -v "http://10.9.5.3" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VNPR03 Added!"
			lpadmin -p "VNPR04" -v "http://10.9.5.4" -P "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" -o "APOptionalDuplexer=True" -E
			echo "VNPR04 Added!"
		fi
		
		echo "Would you like to add any other Office Site Printers? (y/n)"
		read printChoice
	done

	echo "Closing printer setup"
}

# Bash setup to get the computer on the AD Server

if [ "$1" == "-renameComputer" ]; then
	echo "What would you like to name the computer?"
	read compName
	scutil --set ComputerName $compName
	
elif [ "$1" == "-ADJoin" ]; then

	echo "Don't forget to add this computer to SmartSheets"
	sleep 1
	
	read -p "Press Enter when ready to continue with the script"

	my_name=$(basename -- "$0")
	# Make a copy of the script in the shared folder
	echo 'Making a copy of the script in the shared folder "/Users/Shared"'
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

	chmod a+x /Users/Shared/"${my_name}"
	
	# Set the computer to not sleep
	#echo "Setting the computer to never sleep as to not affect the downloads"
	#sleep 1
	#sudo systemsetup -setsleep Never
	#sudo systemsetup -setcomputersleep Never
	#sudo systemsetup -setdisplaysleep Never
	#defaults -currentHost write com.apple.screensaver idleTime 0

	
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

	# Install Duti to set default applications
	brew install duti

	# Set the cask application download location to the default application folder
	# brew cask --caskroom=/Applications

	# Install the necessary applications
	reloadApps

	# Set the applications to the dock properly
	appLayout

	# Add permissions for App Setup
	"$adminPW" | sudo -S -v

	sudo xattr -d -r com.apple.quarantine /Applications/Slack.app
	sudo xattr -d -r com.apple.quarantine /Applications/Google\ Chrome.app
	sudo xattr -d -r com.apple.quarantine /Applications/Adobe\ Acrobat\ Reader\ DC.app
	sudo xattr -d -r com.apple.quarantine /Applications/Microsoft\ Outlook.app
	sudo xattr -d -r com.apple.quarantine /Applications/Microsoft\ Powerpoint.app
	sudo xattr -d -r com.apple.quarantine /Applications/Microsoft\ Word.app
	sudo xattr -d -r com.apple.quarantine /Applications/Microsoft\ Excel.app
	sudo xattr -d -r com.apple.quarantine /Applications/Zoom.us.app
	sudo xattr -d -r com.apple.quarantine /Applications/TeamViewer.app
	sudo xattr -d -r com.apple.quarantine /Applications/ZoomOutlookPlugin
	sudo xattr -d -r com.apple.quarantine /Applications/Dropbox.app
	
	
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

	# Load remaining applications and redo the layout
	appLayout

	# Set Adobe Acrobat as the default application
	echo "Setting some default applications."
	sleep 1
	duti -s com.adobe.reader .pdf all
	echo "Adobe Acrobat has been set as the default application"
	sleep 1

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

	echo "Reopening chrome, turn on automatic updates and approve opening from the internet if you see that popup"
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
	
	read -p "Time for cleanup, when ready to proceed press enter"
	sleep 1
	echo "Type in the admin password"
 	
	su admin -c "sh /Users/Shared/'${my_name}' cleanup"
	
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
	brew cleanup
	
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

	printerCheck
	
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

elif [ "$1" == "-permissions" ]; then
	echo "Make sure you have su'd into admin before running this (or are already on the admin side)"
	sleep 2

	echo "Type in Admin Password"
	sudo -v
	# Add permissions for App Setup
	sudo xattr -d -r com.apple.quarantine /Applications/Slack.app
	sudo xattr -d -r com.apple.quarantine /Applications/Google\ Chrome.app
	sudo xattr -d -r com.apple.quarantine /Applications/Adobe\ Acrobat\ Reader\ DC.app
	sudo xattr -d -r com.apple.quarantine /Applications/Microsoft\ Outlook.app
	sudo xattr -d -r com.apple.quarantine /Applications/Microsoft\ Powerpoint.app
	sudo xattr -d -r com.apple.quarantine /Applications/Microsoft\ Word.app
	sudo xattr -d -r com.apple.quarantine /Applications/Microsoft\ Excel.app
	sudo xattr -d -r com.apple.quarantine /Applications/Zoom.us.app
	sudo xattr -d -r com.apple.quarantine /Applications/TeamViewer.app

elif [ "$1" == "-printers" ]; then
	printerCheck

else
	my_name=$(basename -- "$0")
	# Make a copy of the script in the shared folder
	
	mydir=$(dirname "$0")
	cp "${mydir}"/"${my_name}" /Users/Shared

	echo "+--------------------------------------------------+"
	echo "| ___  ___             _____           _       _    |"
	echo "| |  \/  |            /  ___|         (_)     | |   |"
	echo "| | .  . | __ _  ___  \  --.  ___ _ __ _ _ __ | |_  |"
	echo "| | |\/| |/ _' |/ __|  '--. \/ __| '__| | '_ \| __| |"
	echo "| | |  | | (_| | (__  /\__/ / (__| |  | | |_) | |_  |"
	echo "| \_|  |_/\__,_|\___| \____/ \___|_|  |_| .__/ \__| |"
	echo "|                                       | |         |"
	echo "|                                       |_|         |"
	echo "+--------------------------------------------------+"
	
	echo "\Welcome to the Mac Setup Script"
	sleep .5
	echo "Type in the number for the action you'd like to complete:"

	echo "1) -ADJoin  			- Joins the computer to the Active Directory."
	echo "2) -renameComputer  	- Renames the computer for you."
	echo "3) -setup   			- Sets up the user account (use this once you're on the user account)."
	echo "4) -printers			- Assists with adding just printers via that Office's Specific Site Code"
	echo "5) -quit				- Quit the setup application"

	read userResponse "> "

	if [ $userResponse == "1" ]; then
		echo "Beginning ADJoin initial Setup"
		sleep 2
		caffeinate -i sh "${mydir}"/"${my_name}" -ADJoin

	elif [ $userResponse == "2" ]; then
		echo "Beginning Renaming Procedure"
		sleep 2
		caffeinate -i sh "${mydir}"/"${my_name}" -renameComputer

	elif [ $userResponse == "3" ]; then
		echo "Beginning Setup Process"
		sleep 2
		caffeinate -i sh "${mydir}"/"${my_name}" -setup

	elif [ $userResponse == "4" ]; then
		echo "Beginning Printer Setup Process"
		sleep 2
		caffeinate -i sh "${mydir}"/"${my_name}" -printers

	else
		echo "Quitting application, thank you!"

	fi


fi
