install:
	if [ "$(shell id -u)" = 0 ];then\
		echo "This script cannot be run as root!";\
		exit 1;\
	fi
	echo "Running install scripts"
	sudo ./install.sh
	echo "Setting up service"
	systemctl --user daemon-reload
	systemctl --user enable ambiance.service
	systemctl --user start ambiance.service

purge:
	if [ "$(shell id -u)" = 0 ];then\
		echo "This script cannot be run as root!";\
		exit 1;\
	fi
	echo "Stopping service"
	systemctl --user disable ambiance.service
	systemctl --user stop ambiance.service
	echo "Cleaning up files"
	sudo ./remove.sh
	echo "Reloading services"
	systemctl --user daemon-reload
