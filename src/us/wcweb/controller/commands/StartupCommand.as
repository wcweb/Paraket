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
	import us.wcweb.events.SystemEvent;
	import org.robotlegs.mvcs.Command;

	import us.wcweb.view.components.content.PlayerView;
	import us.wcweb.view.components.content.PlayListView;

	/**
	 * 
	 * @author Peter Lorent peter.lorent@gmail.com
	 * 
	 */
	public class StartupCommand extends Command {
		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		/**
		 * And here we go! Drop the view components on the stage. 
		 * O, order matters here!
		 * 
		 */
		override public function execute() : void {
			
			dispatch(new SystemEvent(SystemEvent.LOAD_CONTENT));
			trace("dispatch loadCOntent");
			contextView.addChild(new PlayerView());
//			contextView.addChild(new PlayListView());
		}
	}
}