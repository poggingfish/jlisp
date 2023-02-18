BUILD_FILE=build.hxml

build :
	haxe $(BUILD_FILE) > /dev/null
install : build
	sudo cp bin/cpp/Main /usr/bin/jlisp
run : build
	bin/cpp/Main