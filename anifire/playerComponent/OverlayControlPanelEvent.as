package anifire.playerComponent
{
   import anifire.event.ExtraDataEvent;
   
   public class OverlayControlPanelEvent extends ExtraDataEvent
   {
      
      public static const CREATE_CLICK:String = "create_click";
      
      public static const EMAIL_CLICK:String = "email_click";
      
      public static const SHARE_CLICK:String = "share_click";
       
      
      public function OverlayControlPanelEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
