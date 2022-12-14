package anifire.component
{
   import anifire.util.UtilHashArray;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class SkinnedHeadMaker extends SkinnedAssetMaker
   {
       
      
      public function SkinnedHeadMaker()
      {
         super();
         this.eventDispatcher = new EventDispatcher();
      }
      
      public function init(param1:XML, param2:ByteArray, param3:UtilHashArray, param4:Boolean = false, param5:Boolean = false, param6:String = "", param7:String = "default") : void
      {
         var _loc8_:CcActionLoader = null;
         destroy();
         this.visible = false;
         charXML = param1;
         figure = param2;
         if(param3)
         {
            charSwfs = param3.clone();
            prepareXML(charXML);
            doLoadMainImage(null);
         }
         else
         {
            (_loc8_ = CcActionLoader.getActionLoader(param6)).addEventListener(Event.COMPLETE,this.onCcActionLoaded);
            _loc8_.loadCcComponents(param1,0,0,param3,null,ver,param5,param6,param7);
         }
      }
      
      private function onCcActionLoaded(param1:Event) : void
      {
         var _loc2_:CcActionLoader = param1.target as CcActionLoader;
         charSwfs = _loc2_.imageData["imageData"] as UtilHashArray;
         prepareXML(charXML);
         doLoadMainImage(null);
      }
   }
}
