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

HELPER_DIR = ${PREFIX}_helpers

HELPERS = \
	${HELPER_DIR}/**

#
# Rules
#
install: install_quiet announce_installation

announce_installation:
	@echo "OK, ${PREFIX} command line tools have been installed. 🎉  Here's what's available:\n" && ${PREFIX} --list

install_check:
	test -d $(DESTINATION_DIR) || mkdir -p $(DESTINATION_DIR)

install_helpers: $(HELPERS)
	@echo "Installing helpers ..."
	@mkdir -p ${DESTINATION_DIR}/${HELPER_DIR}
	@cp -r $(HELPERS) ${DESTINATION_DIR}/${HELPER_DIR}/
    ifeq ($(shell gem list \^bundler\$$ -i), false)
	    gem install bundler
    endif
	cd ${DESTINATION_DIR}/${HELPER_DIR} && bundle install --path vendor/bundle

install_scripts: $(FILES)
	@echo "Installing scripts ..."
	@install -m 755 -p $(FILES) ${DESTINATION_DIR}

install_quiet: uninstall install_check install_helpers install_scripts

uninstall:
	cd ${DESTINATION_DIR} && rm -f ${PREFIX} && rm -f ${PREFIX}-* && rm -rf ${HELPER_DIR}/
