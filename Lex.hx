import haxe.ds.Option;
enum Tokens{
    LBRACKET; // (
    RBRACKET; // )
    SPACE; // " "

    PLUS; // +
    MINUS; // -
    INT;

    STRING; // "*"
    ITEM;
}
class Token{
    public var token: Tokens; // Token
    public var item: Option<Dynamic>; // Item is optional.
    public function new(token: Tokens, ?arg: Dynamic){
        if (arg != null){
            this.item = Some(arg);
        }
        this.token = token;
    }
}
class Lexer{
    public static function LexCode(code: String){
        var i: Int = 0;
        var reserved: Array<String> = [
            "-",
            "+",
            "(",
            ")",
            "\\",
            "\"",
            " ",
            "0","1","2","3","4","5","6","7","8","9"
        ];
        var tokens: List<Token> = new List<Token>();
        while (i < code.length){ // Loop through all characters
            if (code.charAt(i) == "("){
                tokens.add(new Token(Tokens.LBRACKET));
            }
            else if (code.charAt(i) == ")"){
                tokens.add(new Token(Tokens.RBRACKET));
            }
            else if (code.charAt(i) == " "){
                tokens.add(new Token(Tokens.SPACE));
            }
            else if (code.charAt(i) == "+"){
                tokens.add(new Token(Tokens.PLUS));
            }
            else if (code.charAt(i) == "-" && Std.parseInt(code.charAt(i+1)) == null){
                tokens.add(new Token(Tokens.MINUS));
            }
            else if (Std.parseInt(code.charAt(i)) != null || code.charAt(i) == "-"){
                var p: Int = 0;
                var ib: String = "";
                if (code.charAt(i) != "-"){
                    p = i;
                    ib = ""; // Integer buffer
                }
                else{
                    p = i+1;
                    ib = "-"; // Integer buffer
                }
                while (Std.parseInt(code.charAt(p)) != null){
                    ib += code.charAt(p);
                    p++;
                }
                i = p-1;
                tokens.add(new Token(Tokens.INT,Std.parseInt(ib)));
            }
            else if (code.charAt(i) == "\""){
                var p: Int = i+1;
                var sb: String = ""; // String buffer
                var reading: Bool = true;
                while (reading){
                    if (code.charAt(p) == "\\"){
                        if (code.charAt(++p) == "n"){
                            sb += "\n";
                            p++;
                        }
                        else if (code.charAt(p++) == "\""){
                            sb += "\"";
                        }
                    }
                    else if (code.charAt(p) == "\""){
                        reading = false;
                        p++;
                    }
                    else{
                        sb+=code.charAt(p);
                        p++;
                    }
                }
                i = p-1;
                tokens.add(new Token(Tokens.STRING, sb));
            }
            else{
                var sb: String="";
                while (!reserved.contains(code.charAt(i))){
                    sb+=code.charAt(i);
                    i++;
                }
                tokens.add(new Token(Tokens.ITEM,sb));
                i-=1;
            }
            i++;
        }
        return tokens;
    }
}