package {
	import us.wcweb.utils.Tools;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	import us.wcweb.ParaketContext;
	import us.wcweb.utils.Debug;





	public class Paraket extends Sprite {
		

		private var _context:ParaketContext;
		public var config:Object;
		
		public function Paraket() {
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			//Security.allowDomain("maps.googleapis.com");
			
			
			_context = new ParaketContext(this);
			
		}

	}
}
