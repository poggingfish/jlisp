using Lex.Token;
using Lex.Tokens;
using Todo.Todo;
using Node.Node;
using Unwrap.Unwrap;
using Expr.Expr;
class Tree{
    public static function ToList(V: Array<Node>){
        var out: List<Node> = new List<Node>();
        for (i in V){
            out.push(i);
        }
    }
    public static function Treeify(tokens: List<Token>){
        var AST = new Node.FunctionNode("Main");
        var p = new Node.ExprNode(Expr.ADD);
        p.children.add(new Node.IntNode(5));
        p.children.add(new Node.IntNode(5));
        AST.children.add(p);
        return AST;
    }
}