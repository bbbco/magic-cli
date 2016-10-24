#
# To use this Makefile with your version of magic-cli, change the value of
# PREFIX to whatever you have renamed the main command to.
#

PREFIX = magic-cli

#
# Where to install the tools
#
DESTINATION_DIR = /usr/local/bin

#
# Files to install
#
FILES = \
	${PREFIX} \
	${PREFIX}-*

HIDDEN_GIT_LOCATION_FILE = \
	.${PREFIX}-git-location

GIT_LOCATION = \
	$(abspath .)

#
# Rules
#
install: install_quiet announce_installation

announce_installation:
	@echo "OK, ${PREFIX} command line tools have been installed. 🎉  Here's what's available:\n" && ${PREFIX} --list

populate_git_repo_location:
	@echo ${GIT_LOCATION} > ${DESTINATION_DIR}/${HIDDEN_GIT_LOCATION_FILE}

install_quiet: populate_git_repo_location
	@install -m 755 -p $(FILES) ${DESTINATION_DIR}

uninstall:
	sh -c "cd ${DESTINATION_DIR} && rm ${PREFIX} ${HIDDEN_GIT_LOCATION_FILE} && rm ${PREFIX}-*"
