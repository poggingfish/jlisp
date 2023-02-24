import haxe.io.Error;
using sys.io.File;
using sys.io.FileInput;
using Lex.Lexer;
using Tree.Tree;
using Codegen.Codegen;
using Parse.Parse;
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
        var parse = new Parse();
        var tree = new Tree();
        var codegen = new Codegen();
        codegen.Codegen(parse.Parse(tree.Treeify(Lexer.LexCode(code))), true);
    }
}