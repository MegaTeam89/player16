package
{
   import anifire.playerComponent.OverlayControlPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_playerComponent_OverlayControlPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_playerComponent_OverlayControlPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         OverlayControlPanel.watcherSetupUtil = new _anifire_playerComponent_OverlayControlPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("fadeIn",{"propertyChange":true},[param4[0]],param2);
         param5[1] = new PropertyWatcher("fadeOut",{"propertyChange":true},[param4[1]],param2);
         param5[0].updateParent(param1);
         param5[1].updateParent(param1);
      }
   }
}
