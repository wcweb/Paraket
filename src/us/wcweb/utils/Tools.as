package us.wcweb.utils {
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;

	/**
	 * @author macbookpro
	 */
	public class Tools {
		public var parentLayer : int = 0;
		public  static var DisplayOjbectList : Object ;

		public static function __extend(child : Object, parent : Object) : void {
			for (var key: Object in parent) {
				if (parent.hasOwnProperty(key)) {
					child[key] = parent[key];
				}
			}
		}

		public static function getProperties(obj : *) : String {
			var p : *;
			var res : String = '';
			var val : String;
			var prop : String;
			for (p in obj) {
				prop = String(p);
				if (prop && prop !== '' && prop !== ' ') {
					val = String(obj[p]);
					if (val.length > 10) val = val.substr(0, 10) + '...';
					res += prop + ':' + val + ', ';
				}
			}
			res = res.substr(0, res.length - 2);
			return res;
		}

		// / time second
		public static function walkDisplayObjects(displayObject : DisplayObjectContainer, callbackFunction : Function) : void {
			var child : DisplayObject;
			for (var i : uint = 0 ; i < displayObject.numChildren; i++) {
				child = displayObject.getChildAt(i);

				callbackFunction(child);
				if (displayObject.getChildAt(i) is DisplayObjectContainer) {
					// parentLayer += 1;
					// trace("|", parentLayer);

					walkDisplayObjects(DisplayObjectContainer(child), callbackFunction);
				}
			}

			// trace("------------------");
		}

		public static function findObject(name : String, displayObject : DisplayObjectContainer) : DisplayObject {
			var child : DisplayObject;
			for (var i : uint = 0 ; i < displayObject.numChildren; i++) {
				child = displayObject.getChildAt(i);

				if (getOne(child) !== null) return child ;
				if (displayObject.getChildAt(i) is DisplayObjectContainer) {
					// parentLayer += 1;
					// trace("|", parentLayer);

					walkDisplayObjects(DisplayObjectContainer(child), getOne);
				}
			}

			function getOne(child : DisplayObject) : DisplayObject {
				if (name == child.name) {
					return child;
				}
				return null;
			}
			return null;
		}

		public static function traceContainer(child : DisplayObject) : void {
			// var blank : String = "";
			// while ( parentLayer >= 0) {
			// blank += "-" ;
			// parentLayer -= 1;
			// }

			trace("depth: " + child.parent.getChildIndex(child), child, child.name);
		}

		
	}
}
