#!/bin/bash
#
# Script to set up Travis-CI test VM.
#
# This file is generated by l2tdevtools update-dependencies.py any dependency
# related changes should be made in dependencies.ini.

L2TBINARIES_DEPENDENCIES="${l2tbinaries_dependencies}";

L2TBINARIES_TEST_DEPENDENCIES="${l2tbinaries_test_dependencies}";

PYTHON2_DEPENDENCIES="${python2_dependencies}";

PYTHON2_TEST_DEPENDENCIES="${python2_test_dependencies}";

PYTHON3_DEPENDENCIES="${python3_dependencies}";

PYTHON3_TEST_DEPENDENCIES="${python3_test_dependencies}";

# Exit on error.
set -e;

if test $${TRAVIS_OS_NAME} = "osx";
then
	git clone https://github.com/log2timeline/l2tbinaries.git -b dev;

	mv l2tbinaries ../;

	for PACKAGE in $${L2TBINARIES_DEPENDENCIES};
	do
		echo "Installing: $${PACKAGE}";
		sudo /usr/bin/hdiutil attach ../l2tbinaries/macos/$${PACKAGE}-*.dmg;
		sudo /usr/sbin/installer -target / -pkg /Volumes/$${PACKAGE}-*.pkg/$${PACKAGE}-*.pkg;
		sudo /usr/bin/hdiutil detach /Volumes/$${PACKAGE}-*.pkg
	done

	for PACKAGE in $${L2TBINARIES_TEST_DEPENDENCIES};
	do
		echo "Installing: $${PACKAGE}";
		sudo /usr/bin/hdiutil attach ../l2tbinaries/macos/$${PACKAGE}-*.dmg;
		sudo /usr/sbin/installer -target / -pkg /Volumes/$${PACKAGE}-*.pkg/$${PACKAGE}-*.pkg;
		sudo /usr/bin/hdiutil detach /Volumes/$${PACKAGE}-*.pkg
	done

elif test $${TRAVIS_OS_NAME} = "linux";
then
	sudo rm -f /etc/apt/sources.list.d/travis_ci_zeromq3-source.list;

	sudo add-apt-repository ppa:gift/dev -y;
	sudo apt-get update -q;

	if test $${TRAVIS_PYTHON_VERSION} = "2.7";
	then
		sudo apt-get install -y $${PYTHON2_DEPENDENCIES} $${PYTHON2_TEST_DEPENDENCIES};
	else
		sudo apt-get install -y $${PYTHON3_DEPENDENCIES} $${PYTHON3_TEST_DEPENDENCIES};
	fi
	if test $${TARGET} = "pylint";
	then
		sudo apt-get install -y pylint;
	fi
fi
