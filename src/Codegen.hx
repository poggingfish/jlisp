using Node.Node;
using Expr.Expr;
using Todo.Todo;
class Codegen{
    var funcs: Map<String,String> = new Map<String,String>();
    var func_ptr = 0;
    public function new(){}
    public function NextFunc(name: String){
        var _name = "_JL_proc_" + func_ptr++;
        funcs.set(name,_name);
        return _name;
    }
    function CreateFunc(name: String){
        Sys.println(':$name');
    }
    function EndFunc(){
        Sys.println('ret');
    }
    function PushStackInt(int: Int){
        
    }
    public function Codegen(node: Dynamic, ?Init: Bool){
        switch Type.getClass(node){
            case Node.FunctionNode:
                var node: Node.FunctionNode = node;
                var name = NextFunc(node.name);
                CreateFunc(name);
                for (i in node.children){
                    Codegen(i);
                }
                EndFunc();
            case Node.IntNode:
                var node: Node.IntNode = node;
                Sys.println("push #"+node.int);
            case Node.ExprNode:
                var node: Node.ExprNode = node;
                if (node.expr == ADD){
                    var p: Int = 0;
                    for (i in node.children){
                        Codegen(i);
                        p+=1;
                    }
                    Sys.println("add");
                    for (i in 0...p-2){
                        Sys.println("add");
                    }
                }
            default:
                Todo.todo("Implement codegen for type " + Type.typeof(node));
        }
        if (Init){
            Sys.println(":main");
            Sys.println("jump :" + funcs.get("Main"));
        }
    }
}