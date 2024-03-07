import Std.BoundedInts
import Std.FileIO
import Std.Unicode.UnicodeStringsWithUnicodeChar
import Std.Wrappers
import Std.Collections.Seq

method Main(args: seq<string>) {
  if |args| != 3 {
    var programName := if |args| > 0 then args[0] else "<compiler>";
    print "Usage: " + programName + " <in.fun> <out.s>\n";
    return;
  }

  var src_bytes_option := FileIO.ReadBytesFromFile(args[1]);
  match src_bytes_option {
    case Success(src_bytes) => {
      var bytes_uint8 := Seq.Map((byte) => byte as BoundedInts.uint8, src_bytes);
      match UnicodeStringsWithUnicodeChar.FromUTF8Checked(bytes_uint8) {
        case Some(unicode) => print unicode;
        case None => print "Input file " + args[1] + " was not valid UTF8";
      }
    }
    case Failure(err) => {
      print "Failed to read file " + args[1] + ": " + err + "\n";
    }
  }
}
