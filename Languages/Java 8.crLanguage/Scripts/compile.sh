#!/bin/bash
# This is a CodeRunner compile script. Compile scripts are used to compile
# code before being run using the run command specified in CodeRunner
# preferences. This script is invoked with the following properties:
#
# Current directory:	The directory of the source file being run
#
# Arguments $1-$n:		User-defined compile flags	
#
# Environment:			$CR_FILENAME	Filename of the source file being run
#						$CR_ENCODING	Encoding code of the source file
#						$CR_TMPDIR		Path of CodeRunner's temporary directory
#
# This script should have the following return values:
# 
# Exit status:			0 on success (CodeRunner will continue and execute run command)
#
# Output (stdout):		On success, one line of text which can be accessed
#						using the $compiler variable in the run command
#
# Output (stderr):		Anything outputted here will be displayed in
#						the CodeRunner console

enc[4]="UTF8"			# UTF-8
enc[10]="UTF16"			# UTF-16
enc[5]="ISO8859-1"		# ISO Latin 1
enc[9]="ISO8859-2"		# ISO Latin 2
enc[30]="MacRoman"		# Mac OS Roman
enc[12]="CP1252"		# Windows Latin 1
enc[3]="EUCJIS"			# Japanese (EUC)
enc[8]="SJIS"			# Japanese (Shift JIS)
enc[1]="ASCII"			# ASCII

# Set Java 8
JAVA_HOME=`/usr/libexec/java_home -v 1.8`

directory=`dirname "$0"`

# Check if file resides in a folder with package name, if so, change directory
package=`php "$directory/parsejava.php" --package "$PWD/$CR_FILENAME"`
if [ ${#package} -ne 0 ]; then
	# Check if package name is in the form package.subpackage.subpackage
	# If this structure matches directory structure, change directory...
	packageDirectory=`echo "$package" | sed 's/\./\//g'`
	if [[ $PWD == *"$packageDirectory" ]]; then
		cd "${PWD:0:${#PWD}-${#packageDirectory}}"
		CR_FILENAME="$packageDirectory"/"$CR_FILENAME"
	else
		if [[ $package == *.* ]]; then
			errmessage="structure"
		else
			errmessage="named"
		fi
			>& 2 echo "CodeRunner warning: Java file \"$CR_FILENAME\" with package \"$package\" should reside in folder $errmessage \"$packageDirectory\"."
	fi
fi

javac "$CR_FILENAME" -encoding ${enc[$CR_ENCODING]} "${@:1}"
status=$?

if [ $status -ne 0 ]; then
	javac -version &>/dev/null
	if [ $? -ne 0 ]; then
		echo -e "\nTo run Java code, you need to install a JDK. You can download a JDK at http://oracle.com/technetwork/java/javase/downloads/\n\nIf you see a prompt asking you to install Java Runtime Environment, please ignore it and use the JDK download link above."
	fi
	exit $status
fi

# Use parsejava.php to get package and class name of main function.
out=`php "$directory/parsejava.php" "$PWD/$CR_FILENAME"`
status=$?
if [ $status -ne 0 ]; then
	>& 2 echo "CodeRunner warning: Could not find a main method in the file \"$CR_FILENAME\". Please add a main method or run the file in your project containing your main method."
	compname=`echo "$CR_FILENAME" | sed 's/\(.*\)\..*/\1/'`
	if [ -z "$out" ]; then
		out="$compname"
	else
		out="$out.$compname"
	fi
fi
echo "cd \"$PWD\"; JAVA_HOME=$JAVA_HOME java $out"
exit 0