package us.wcweb.view.mediators {
	import org.robotlegs.base.EventMap;
	import us.wcweb.model.events.PlayerProxyEvent;
	import us.wcweb.view.events.PlayerViewEvent;
	import us.wcweb.view.events.PlayListEvent;
	import us.wcweb.utils.Tools;
	import us.wcweb.view.components.content.elements.PlayListItem;
	import us.wcweb.utils.Strings;
	import us.wcweb.model.events.AssetLoaderProxyEvent;
	import us.wcweb.view.components.content.PlayListView;
	import org.robotlegs.mvcs.Mediator;

	public class PlayListMediator extends Mediator {
		[Inject]
		public var view : PlayListView;
		
		public function PlayListMediator(){
			super();
		}
		
		// ---------------------------------------
		// OVERRIDEN METHODS
		// ---------------------------------------
		override public function onRegister() : void {
			// Register your events in the eventMap here
			// eventMap.mapListener(YOUR VIEW COMPOENT, YOUR EVENT, YOUR HANDLER);

			// Optionally add bindings to your view components public variables
			view.main();
			super.onRegister();
			
			eventMap.mapListener(eventDispatcher, AssetLoaderProxyEvent.XML_CONTENT_LOADED, handlePlayListContentLoaded);
			eventMap.mapListener(eventDispatcher, PlayerProxyEvent.PLAYING, handlePlaying);
			eventMap.mapListener(view, PlayListEvent.PLAY_CLIP, handlePlayListItem);
			
		}

		override public function onRemove() : void {
			// Remove any listeners or bindings here
			// eventMap.unmapListeners();
			super.onRemove();
		}
		// ---------------------------------------
		// EVENT HANDLES
		// ---------------------------------------
		private function handlePlayListContentLoaded(e:AssetLoaderProxyEvent):void{
			
			var itemlist:Array = parse(e.xml);
			Tools.getProperties(itemlist);
			view.initializeList(itemlist);
		}
		
		public function playItemTest(url:String):void{
			trace(new PlayerProxyEvent(PlayerProxyEvent.PLAY_ITEM, url));
//			trace(this is null);
			trace("dispath PlayerProxyEvent.PLAY_ITEM,");
			//Tools.getProperties(this);
			//trace(this.dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAY_ITEM, url)));
//			eventDispatcher.dispatchEvent();
			dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAY_ITEM, url));
		}
		
		private function handlePlaying(e:PlayerProxyEvent):void{
			
		}
		private function handlePlayListItem(e:PlayListEvent):void{
			trace("hear me in mediator?");
			dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAY_ITEM, e.url));
		}
		
		// ---------------------------------------
		// METHODS
		// ---------------------------------------
		
		
		private function parseItem(xml:XML):Object{	
			var itm : Object = new Object();
			for each (var i:XML in xml.children()) {
				// if (i.namespace().prefix == CuePointParser.PREFIX) {
				switch (i.localName().toLowerCase()) {
					case 'title':
						itm['name'] = i.text().toString();
						break;
					case 'author':
						itm['author'] = i.text().toString();
						break;
					case 'link':
						itm['link'] = i.text().toString();
						break;
					case 'seektime':
						itm['time'] = Math.floor(Number(i.text().toString()) / 1000).toString();
						break;
					case 'duration':
						itm['duration'] = Strings.seconds(Math.floor(Number(i.text().toString())/1000).toString());
						break;
					case 'summary':
						itm['description'] = i.text().toString();
						break;
					case 'keywords':
						itm['tags'] = i.text().toString();
						break;
				}
			}
			return new PlayListItem(itm);
		}
		
		private function parse(dat:XML):Array{
			var itemlist:Array = new Array();
			
			for each (var i:XML in dat.children()) {
				if (i.localName().toLowerCase() == 'channel') {
					for each (var j:XML in i.children()) {
						if (j.localName().toLowerCase() == 'item') {
							itemlist.push(parseItem(j));
						}
					}
				}
			
			}
			return itemlist; 
		}
	}
}
