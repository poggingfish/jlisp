using Lex.Lexer;
class Main {
    static function main() {
        for(i in Lexer.LexCode("(+ 1 2)")){
            Sys.println(i.token + " : " + i.item);
        }
    }
}