BUILD_FILE=build.hxml

build :
	haxe $(BUILD_FILE)
install : build
	sudo cp bin/cpp/Main /usr/bin/jlisp