#!/bin/bash
# nautilus script
# install PLEX plugin on Ubuntu 12.04.

# run this script by right clicking on the directory you want to install
install_plugin () {
	# standard feature: install by copying folder
	# future enhancement: install from ZIP file

	PARAMETERS=( "$@" )               ## array containing all params passed to the script

	PLUGIN_FOLDER='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'

	# read folder paths into TO_BE_INSTALLED
	IFS=$'\n' read -d '' -r -a TO_BE_INSTALLED < <(printf '%s\n' $PARAMETERS); unset $IFS

	need_to_restart_server=false

	for package in "${TO_BE_INSTALLED[@]}"; do
		package_name="${package##*/}" # Strip longest match of substring (*/) from front of string

	# sanity check: is the path correct? it should be a directory and end with ".bundle".
		if  [[ -d "$package" ]]; then	# if selected path IS a directory
			if [[ "${package_name##*.}" == "bundle" ]]; then
				installed_package=$PLUGIN_FOLDER$package_name
			# check if plugin already exists
				if [[ -d "$installed_package" ]]; then 
					# if yes, ask to delete it 
					echo -n "A package with the same name is already installed. Would you like to overwrite it? (yes/no): "; read overwrite 
					if [[ $overwrite == [Yy][Ee][Ss] || $overwrite == [Yy] ]]; then 
						sudo rm -R "$installed_package"
					else
						echo "You chose not to overwrite $package_name so it will not be processed."
						continue
					fi
				fi
			# install plugin
				#copy the downloaded plugin to the plex plug-in directory
				sudo cp -R "$package" "$PLUGIN_FOLDER"

				#change the permissions to be like the existing plug-ins 
				#(this is not needed in 14.04 anymore)
				sudo chmod ugoa+rx "$installed_package"

				#change the owner of the files to be like the existing plug-ins
				sudo chown -R plex:plex "$installed_package"

				need_to_restart_server=true

			else # if not "bundle"
				echo "Package name should end with '.bundle'. $package_name will not be processed."
				continue # process next package instead
			fi

		else # if not directory
			echo "Package should be a directory. $package_name will not be processed."
			continue # process next package instead
		fi

	done
# when finished with all packages, restart plex server.
if [[ $need_to_restart_server = true ]]; then 
	sudo service plexmediaserver stop
	sleep 5
	sudo service plexmediaserver start
	
	echo "Installation complete. Your new plug-in should show up now in PLEX."
fi
}

export -f install_plugin

gnome-terminal --execute bash -c 'install_plugin "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"; bash'
