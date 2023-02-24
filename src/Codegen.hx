using Node.Node;
using Expr.Expr;
using Todo.Todo;
using haxe.ds.Option;
class Codegen{
    var funcs: Map<String,String> = new Map<String,String>();
    var func_ptr = 0;
    public var out_string = "";
    public function new(){}
    public function NextFunc(name: String){
        var _name = "_JL_proc_" + func_ptr++;
        funcs.set(name,_name);
        return _name;
    }
    public function ToArray(f: List<Node>){
        var t: Array<Node> = new Array<Node>();
        for (i in f){
            t.push(i);
        }
        return t;
    }
    public function Codegen(node: Dynamic, ?Init: Bool){
        switch Type.getClass(node){
            case Node.Node:
                var node: Node.Node = node;
                for (i in node.children){
                    Codegen(i);
                }
            case Node.FunctionNode:
                var node: Node.FunctionNode = node;
                var name = NextFunc(node.name);
                out_string += name + " = function(){";
                for (i in node.children){
                    Codegen(i);
                }
                out_string += "}";
            case Node.FunctionCallNode:
                var node: Node.FunctionCallNode = node;
                out_string += funcs[node.name] + "();";
            case Node.ExprNode:
                var node: Node.ExprNode = node;
                switch(node.expr){
                    case EQ:
                        var t = ToArray(node.children);
                        var name: String = (cast t[0]).name;
                        var int: Node.IntNode = cast t[1];
                        out_string += name + ' = ${int.int};';
                    default: Todo.todo("Implement parse expr for type: " + node.expr);
                }
            case Node.InlineNode:
                var node: Node.InlineNode = node;
                out_string += node.code;
            default: Todo.todo("Implement parse for type: " + Type.getClass(node));
        }
        if (Init){
            out_string += funcs["Main"] + "();";
        }
    }
}