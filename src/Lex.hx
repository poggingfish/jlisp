import haxe.ds.Option;
enum Tokens{
    LBRACKET; // (
    RBRACKET; // )
    LCURL; // {
    RCURL; // }
    SPACE; // " "
    NL; // \n
    PLUS; // +
    MINUS; // -
    EQUALS; // =
    SEMICOLON; // ;
    INT;
    STRING; // "*"
    NAME; // *
    CALL; // Call
    FUNC; // Function
    INLINE; // Inline code
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
            ";",
            "{",
            "}",
            "\\",
            "\"",
            " ",
            "=",
            "\n",
            "0","1","2","3","4","5","6","7","8","9"
        ]; // List of all reserved words
        var tokens: Array<Token> = new Array<Token>();
        while (i < code.length){ // Loop through all characters
            if (code.charAt(i) == "("){
                tokens.push(new Token(Tokens.LBRACKET));
            }
            else if (code.charAt(i) == ")"){
                tokens.push(new Token(Tokens.RBRACKET));
            }
            else if (code.charAt(i) == "{"){
                tokens.push(new Token(Tokens.LCURL));
            }
            else if (code.charAt(i) == "}"){
                tokens.push(new Token(Tokens.RCURL));
            }
            else if (code.charAt(i) == " "){
                tokens.push(new Token(Tokens.SPACE));
            }
            else if (code.charAt(i) == "+"){
                tokens.push(new Token(Tokens.PLUS));
            }
            else if (code.charAt(i) == "-" && Std.parseInt(code.charAt(i+1)) == null){ // Checking that "-" is not the start of a negative number
                tokens.push(new Token(Tokens.MINUS));
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
                var t = Std.parseInt(ib);
                tokens.push(new Token(Tokens.INT,t));
            }
            else if (code.charAt(i) == "\""){
                var p: Int = i+1;
                var sb: String = ""; // String buffer
                var reading: Bool = true;
                while (reading){
                    if (code.charAt(p) == "\\"){
                        p++;
                        if (code.charAt(p) == "\\"){
                            sb += "\\";
                        }
                        else if (code.charAt(p) == "n"){
                            sb += "\n";
                        }
                        else if (code.charAt(p) == "\""){
                            sb += "\"";
                        }
                        p++;
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
                tokens.push(new Token(Tokens.STRING, sb));
            }
            else if (code.charAt(i) == "="){
                tokens.push(new Token(Tokens.EQUALS));
            }
            else if (code.charAt(i) == ";"){
                tokens.push(new Token(Tokens.SEMICOLON));
            }
            else if (code.charAt(i) == "\n"){
                tokens.push(new Token(Tokens.NL));
            }
            else{
                var sb: String="";
                while (!reserved.contains(code.charAt(i))){
                    sb+=code.charAt(i);
                    i++;
                }
                switch(sb){
                    case "function": tokens.push(new Token(Tokens.FUNC));
                    case "call": tokens.push(new Token(Tokens.CALL));
                    case "inline": tokens.push(new Token(Tokens.INLINE));
                    default: tokens.push(new Token(Tokens.NAME,sb));
                }
                i-=1;
            }
            i++;
        }
        return tokens;
    }
}