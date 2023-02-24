using Expr.Expr;
class Node{
    public var children: List<Node>;
    public var line = 0;
    public function new(?children: List<Node>){
        this.children = new List<Node>();
        if (children != null){
            this.children = children;
        }   
    }
}
class StringNode extends Node{
    public var string: String;
    public function new(string: String, ?children: List<Node>){
        super(children);
        this.string = string;
    }
}
class IntNode extends Node{
    public var int: Int;
    public function new(int: Int, ?children: List<Node>){
        super(children);
        this.int=int;
    }
}
class ExprNode extends Node{
    public var expr: Expr.Expr;
    public function new(expr: Expr, ?children: List<Node>){
        super(children);
        this.expr=expr;
    }
}
class FunctionNode extends Node{
    public var name: String = "";
    public function new(name: String, ?children: List<Node>){
        super(children);
        this.name=name;
    }
}
class FunctionCallNode extends Node{
    public var name: String = "";
    public function new(name: String, ?children: List<Node>){
        super(children);
        this.name=name;
    }
}
class NameNode extends Node{
    public var name: String = "";
    public function new(name: String, ?children: List<Node>){
        super(children);
        this.name=name;
    }
}