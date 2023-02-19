import haxe.io.Error;
using sys.io.File;
using sys.io.FileInput;
using Lex.Lexer;
using Tree.Tree;
class Main {
    static function usage(){
        Sys.println("Usage: jlisp <file>");
    }
    static function main() {
        var file: String;
        try{
            file = Sys.args()[0];
        } catch(e){
            usage();
            throw Error;
        }
        var t: FileInput = null;
        try{
            t = File.read(file);
        } catch(e){
            usage();
            throw Error;
        }
        var f = t.readAll(1);
        var code = f.toString();
        Tree.Treeify(Lexer.LexCode(code));
    }
}