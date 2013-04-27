package us.wcweb.controller.commands {
  import us.wcweb.view.mediators.PlayListMediator;
  import us.wcweb.view.components.content.PlayListView;
  import us.wcweb.view.mediators.PlayerViewMediator;
  import us.wcweb.view.components.content.PlayerView;
  import org.robotlegs.mvcs.Command;

  public class PreViewCommand extends Command {
    /**
     * @inheritDoc
     */
    override public function execute() : void {
      // Your command content goes here dude
      	mediatorMap.mapView(PlayerView, PlayerViewMediator);
		mediatorMap.mapView(PlayListView, PlayListMediator);
    }
  }
}