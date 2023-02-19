BUILD_FILE=build.hxml

build :
	haxe $(BUILD_FILE)
build_root : build
	cp bin/cpp/Main jlisp
install : build_root
	sudo cp jlisp /usr/bin/jlisp
clean :
	rm -rf bin
	rm -f jlisp
.PHONY : clean