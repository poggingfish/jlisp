using Lex.Token;
using Lex.Tokens;
class Tree{
    var i = 0;
    public function new(){}
    public function Treeify(T: Array<Token>){
        var finished: Array<Any> = new Array<Any>();
        while (i < T.length){
            switch (T[i].token){
                case LCURL:
                    i+=1;
                    finished.push(Treeify(T));
                case RCURL:
                    return finished;
                case SPACE:
                default:
                    finished.push(T[i]);
            }
            i++;
        }
        return finished;
    }
}