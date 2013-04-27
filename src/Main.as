package {
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import org.libra.events.LibraEvent;
  import org.libra.geom.IntDimension;
  import org.libra.geom.IntPoint;
  import org.libra.JButton;
  import org.libra.JCheckBox;
  import org.libra.JComboBox;
  import org.libra.JFrame;
  import org.libra.JList;
  import org.libra.JPanel;
  import org.libra.JTabPanel;
  import org.libra.JTextField;
  import org.libra.JWindow;
  import org.libra.managers.CursorManager;
  import org.libra.managers.LibraManager;
  import org.libra.ui.BasicListItem;
  
  /**
   * 文档类
   * 在使用LibraUI时，需要初始化一下LibraManager，该类使用了单例模式，
   * 所以只需要调用LibraManager.getInstance(this);即可。参数this就是文档类实例。
   * @see org.libra.managers.LibraManager
   * @author Eddie
   */
  public class Main extends Sprite {
    
    public function Main():void {
      if (stage) init();
      else addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e:Event = null):void {
      removeEventListener(Event.ADDED_TO_STAGE, init);
      // entry point
      ///*
      LibraManager.getInstance(this);
      var win:JWindow = new JWindow(this);
      win.setSize(new IntDimension(stage.stageWidth, stage.stageHeight));
      win.show();
      
      var f:JFrame = new JFrame(win);
      f.setSize(new IntDimension(300, 200));
      f.setLocation(new IntPoint((stage.stageWidth - f.getWidth()) >> 1, (stage.stageHeight - f.getHeight()) >> 1));
      f.show();
       
      var list:JList = new JList();
      list.setSize(new IntDimension(200, 150));
      list.setLocation(new IntPoint(50, 10));
      list.appendItem(new BasicListItem("h"));
      list.appendItem(new BasicListItem("e"));
      list.appendItem(new BasicListItem("l"));
      list.appendItem(new BasicListItem("l"));
      list.appendItem(new BasicListItem("o"));
      list.appendItem(new BasicListItem("w"));
      list.appendItem(new BasicListItem("o"));
      list.appendItem(new BasicListItem("r"));
      list.appendItem(new BasicListItem("l"));
      list.appendItem(new BasicListItem("d"));
      list.appendItem(new BasicListItem("!"));
      f.append(list);
      /*
      var c:JComboBox = new JComboBox("ComboBox", 18, 6);
      c.setSize(new IntDimension(65, 23));
      c.setLocation(new IntPoint(10, 0));
      c.appendItem(new BasicListItem("h"));
      c.appendItem(new BasicListItem("e"));
      c.appendItem(new BasicListItem("l"));
      c.appendItem(new BasicListItem("l"));
      c.appendItem(new BasicListItem("o"));
      c.appendItem(new BasicListItem("w"));
      c.appendItem(new BasicListItem("o"));
      c.appendItem(new BasicListItem("r"));
      c.appendItem(new BasicListItem("l"));
      c.appendItem(new BasicListItem("d"));
      c.appendItem(new BasicListItem("!"));
      f.append(c);
      
      var check:JCheckBox = new JCheckBox("check");
      check.setSize(new IntDimension(56, 23));
      check.setLocation(new IntPoint(100, 160));
      f.append(check);
      
      var f2:JFrame = new JFrame(win, true);
      f2.setSize(new IntDimension(100, 100));
      f2.show();
      //var s:Sprite = createShape();
      //s.x = f.getLocation().getX();
      //s.y = f.getLocation().getY() + 50;
      //win.addChild(s);
      var b2:JButton = new JButton("close");
      b2.setSize(new IntDimension(56, 23));
      f2.append(b2);
      b2.addActionListener(function(evt:LibraEvent):void { f2.tryToClose() } );
      
      var f3:JFrame = new JFrame(win, true);
      f3.setSize(new IntDimension(120, 60));
      f3.show();
      var b3:JButton = new JButton("close F3");
      b3.setSize(new IntDimension(56, 23));
      b3.addActionListener(function(evt:LibraEvent):void { f3.tryToClose() } );
      f3.append(b3);
      var tabPanel:JTabPanel = new JTabPanel(win, new IntPoint(10, 10), new IntDimension(120, 23), 60, new IntPoint(10, 80));
      tabPanel.setSize(new IntDimension(500, 400));
      win.append(tabPanel);
      
      var p:JPanel = new JPanel(tabPanel);
      p.setSize(new IntDimension(400, 300));
      var tt:JTextField = new JTextField("thisis a test");
      tt.pack();
      p.append(tt);
      
      var p2:JButton = new JButton("button");
      p2.setSize(new IntDimension(300, 200));
      tabPanel.append(p);
      tabPanel.append(p2);*/
    } 
    
    private function test():void {
      
    }
    
    private function createShape():Sprite {
      var s:Sprite = new Sprite();
      s.mouseChildren = false;
      s.graphics.beginFill(0xff00ff);
      s.graphics.drawRect(0, 0, 100, 100);
      s.graphics.endFill();
      return s;
    }
    
    private function onBtnHandler(evt:LibraEvent):void {
      trace("b is be clicked");
    }
    
  }
}