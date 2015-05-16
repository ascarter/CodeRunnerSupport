#
# Makefile for CodeRunner support
#

# CodeRunner support
CODERUNNER=~/Library/Application\ Support/CodeRunner

.DEFAULT: install

.PHONY: install uninstall

install: 
	cp Grammars/* $(CODERUNNER)/Grammars/.
	cp -R Languages/* $(CODERUNNER)/Languages/.
	#cp -R Themes/* $(CODERUNNER)/Themes/.

uninstall:
	# Grammars
	-rm -f $(CODERUNNER)/Grammars/CoffeeScript.plist
	-rm -f $(CODERUNNER)/Grammars/Go.plist
	# Languages
	-rm -Rf $(CODERUNNER)/Languages/CoffeeScript.crLanguage
	-rm -Rf $(CODERUNNER)/Languages/Go.crLanguage
	-rm -Rf $(CODERUNNER)/Languages/Java\ 8.crLanguage
	# Themes
