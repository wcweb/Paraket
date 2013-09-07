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
	import us.wcweb.controller.commands.playerControllers.PostRecordCommand;
	import us.wcweb.controller.commands.playerControllers.StopPostCommand;
	import org.robotlegs.mvcs.Command;
	import us.wcweb.controller.commands.playerControllers.PlayClipItemCommand;
	import us.wcweb.controller.commands.playerControllers.PlayCurrentItemCommand;
	import us.wcweb.controller.commands.playerControllers.StartRecordCommand;
	import us.wcweb.controller.commands.playerControllers.StopCurrentItemCommand;
	import us.wcweb.controller.commands.playerControllers.StopRecordCommand;
	import us.wcweb.controller.commands.stageCommands.CleanupStartupCommand;
	import us.wcweb.events.SystemEvent;
	import us.wcweb.model.events.PlayerProxyEvent;
	import us.wcweb.model.events.RecordProxyEvent;
	import us.wcweb.view.events.PlayerViewEvent;


	/**
	 * Map Commands.
	 *
	 * @author Peter Lorent peter.lorent@gmail.com
	 *
	 */
	public class PrepControllerCommand extends Command {
		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		override public function execute() : void {
			// commandMap.mapEvent(SystemEvent.REQUEST_GEOCODING, UpdateTimingCommand, SystemEvent);
//			commandMap.mapEvent(SystemEvent.load, commandClass)
			commandMap.mapEvent(SystemEvent.LOAD_CONTENT, LoadXMLCommand, SystemEvent, true);
			
			commandMap.mapEvent(SystemEvent.CLEANUP_STARTUP, CleanupStartupCommand, SystemEvent, true);
			//commandMap.mapEvent(SystemEvent.STAGE_CLICK, StageClickCommand, SystemEvent);
			commandMap.mapEvent(PlayerProxyEvent.PLAY_ITEM, PlayClipItemCommand, PlayerProxyEvent);

			commandMap.mapEvent(RecordProxyEvent.START_RECORD, StartRecordCommand);
			commandMap.mapEvent(RecordProxyEvent.STOP_RECORD, StopRecordCommand);
			commandMap.mapEvent(RecordProxyEvent.PLAY_CURRENT_RECORDED, PlayCurrentItemCommand);
			commandMap.mapEvent(RecordProxyEvent.STOP_CURRENT_PLAY, StopCurrentItemCommand);
			commandMap.mapEvent(SystemEvent.POST_RECORD, PostRecordCommand);
			commandMap.mapEvent(SystemEvent.STOP_POST, StopPostCommand);
			
			
		}
	}
}