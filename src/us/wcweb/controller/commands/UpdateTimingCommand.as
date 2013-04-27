/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package us.wcweb.controller.commands {
	import org.robotlegs.mvcs.Command;
	import us.wcweb.events.SystemEvent;
	import us.wcweb.model.proxies.JwplayerConnectProxy;
//	import us.wcweb.model.services.GeoCodingService;

	/**
	 * Command to get a location from the Googlemaps API.
	 *  
	 * @author Peter Lorent peter.lorent@gmail.com
	 * 
	 */
	public class UpdateTimingCommand extends Command {
		[Inject]
//		public var service : GeoCodingService;
		public var proxy:JwplayerConnectProxy;
		[Inject]
		public var event : SystemEvent;

		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		override public function execute() : void {
//			service.requestGeocoding(event.body.city, event.body.address);
			proxy.connect();
		}
	}
}