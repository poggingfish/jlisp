import haxe.macro.Expr;
import haxe.macro.PositionTools;
import haxe.macro.Context;
class Todo{
    public static function log(locStr: String, msg: String){
        Sys.println(locStr + " : " + msg);
        Sys.exit(1);
    }
    macro public static function todo(args: Array<Expr>){
        var x = PositionTools.toLocation(Context.currentPos());
        var locStr = "TODO " + x.file + ":" + x.range.start.line;
        args.unshift(macro $v{locStr});
        return macro Todo.log($a{args});
    }
}