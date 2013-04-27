package us.wcweb.model.proxies {
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import us.wcweb.utils.Tools;
	import org.robotlegs.mvcs.Context;
	import us.wcweb.utils.Debug;
	import flash.display.LoaderInfo;
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author macbookpro
	 */
	public class LocalConfigProxy extends Actor {
		
		public var parameters:Object;
		
		public function LocalConfigProxy() {
			
			super();
			
		}
		public function setConfig(context:DisplayObjectContainer):void{
			//Security.allowDomain("maps.googleapis.com");
			var fvars:Object = LoaderInfo(context.root.loaderInfo).parameters;
			
			parameters ={
				files: '',
				post2: '',
				otherconfig:''
			};
			
			Tools.__extend(parameters, fvars);
			trace("In localConfigProxy debug flashvar : "+Tools.getProperties(parameters));
		}
		
		
	}
}
