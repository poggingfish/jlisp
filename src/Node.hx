using Expr.Expr;
class Node{
    public var children: List<Node>;
    public function new(){
        children = new List<Node>();   
    }
}
class StringNode extends Node{
    public var string: String;
    public function new(string: String){
        super();
        this.string = string;
    }
}
class IntNode extends Node{
    public var int: Int;
    public function new(int: Int){
        super();
        this.int=int;
    }
}
class ExprNode extends Node{
    public var expr: Expr.Expr;
    public function new(expr: Expr){
        super();
        this.expr=expr;
    }
}