package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.PlayList;
   import com.google.ads.instream.api.PlayListManager;
   import flash.display.InteractiveObject;
   import flash.system.ApplicationDomain;
   
   class PlayListManagerWrapper extends EventDispatcherWrapper implements PlayListManager
   {
       
      
      function PlayListManagerWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
         remoteInstance.publisherApplicationDomain = ApplicationDomain.currentDomain;
      }
      
      public function load(param1:Object) : void
      {
         remoteInstance.load(param1);
      }
      
      public function set adSlotX(param1:Number) : void
      {
         remoteInstance.adSlotX = param1;
      }
      
      public function set adSlotY(param1:Number) : void
      {
         remoteInstance.adSlotY = param1;
      }
      
      public function get playList() : PlayList
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.playList,localInstance) as PlayList;
      }
      
      public function play(param1:Object) : void
      {
         remoteInstance.play(param1);
      }
      
      public function get adSlotX() : Number
      {
         return remoteInstance.adSlotX;
      }
      
      public function get adSlotY() : Number
      {
         return remoteInstance.adSlotY;
      }
      
      public function set clickTrackingElement(param1:InteractiveObject) : void
      {
         remoteInstance.clickTrackingElement = param1;
      }
      
      public function get clickTrackingElement() : InteractiveObject
      {
         return remoteInstance.clickTrackingElement;
      }
   }
}
