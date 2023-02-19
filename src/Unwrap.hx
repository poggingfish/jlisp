import haxe.Exception;
import haxe.ds.Option;
class UnwrapException extends Exception{} 
class Unwrap{
    public static function unwrap(t: Option<Dynamic>): Dynamic {
        switch t{
            case Some(v): return v;
            default: throw new UnwrapException("Unwrapped on Null");
        };
    }
}