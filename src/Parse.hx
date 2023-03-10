using Lex.Token;
using Lex.Tokens;
using Node;
class Parse{
    public function new(){}
    var line = 0;
    var recurse = 0;
    var def_array:Array<Any> = new Array<Any>();
    public function Parse(tokens: Array<Any>){
        var base: Node.Node = new Node.Node();
        var i = 0;
        recurse++;
        while (i < tokens.length){
            if (Type.typeof(tokens[i]) == Type.typeof(def_array)){
                Parse(tokens[i]);
            }
            else{
                var token: Token = cast tokens[i];
                if (token.token == Tokens.FUNC){
                    var name: Token = cast tokens[++i];
                    var name: String = cast Unwrap.unwrap(name.item);
                    var body = Parse(tokens[++i]);
                    var tmp = new Node.FunctionNode(name);
                    tmp.children.add(body);
                    base.children.add(tmp);
                }
                else if (token.token == Tokens.CALL){
                    var name: Token = cast tokens[++i];
                    var tmp: FunctionCallNode = new FunctionCallNode(Unwrap.unwrap(name.item));
                    base.children.add(tmp);
                }
                else if (token.token == Tokens.NAME){
                    var name: String = cast Unwrap.unwrap(token.item);
                    var next_tok: Token = cast tokens[++i];
                    if (next_tok.token == Tokens.EQUALS){
                        var next_tok: Token = cast tokens[++i];
                        if (next_tok.token == Tokens.INT){
                            var tmp = new Node.ExprNode(Expr.EQ);
                            tmp.children.add(new Node.NameNode(name));
                            tmp.children.add(new Node.IntNode(cast Unwrap.unwrap(next_tok.item)));
                            base.children.add(tmp);
                        }
                    }
                }
                else if (token.token == Tokens.NL){
                    line++;
                }
                else if (token.token == Tokens.SEMICOLON){}
                else if (token.token == Tokens.INLINE){
                    var next_tok: Token = cast tokens[++i];
                    if (next_tok.token == Tokens.STRING){
                        var code: String = cast Unwrap.unwrap(next_tok.item);
                        base.children.add(new Node.InlineNode(code));
                    }
                }
                else{
                    Todo.todo("Implement parse for token " + token.token);
                }
            }
            i++;
        }
        return base;
    }
}