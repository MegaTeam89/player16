package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.AdsManager;
   
   class AdsManagerWrapper extends EventDispatcherWrapper implements AdsManager
   {
       
      
      function AdsManagerWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get adSlotWidth() : Number
      {
         return remoteInstance.adSlotWidth;
      }
      
      public function get adSlotHeight() : Number
      {
         return remoteInstance.adSlotHeight;
      }
      
      public function set adSlotWidth(param1:Number) : void
      {
         remoteInstance.adSlotWidth = param1;
      }
      
      public function load(param1:Object = null) : void
      {
         remoteInstance.load(param1);
      }
      
      public function unload() : void
      {
         remoteInstance.unload();
      }
      
      public function get ads() : Array
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.ads,localInstance) as Array;
      }
      
      public function set adSlotHeight(param1:Number) : void
      {
         remoteInstance.adSlotHeight = param1;
      }
      
      public function play(param1:Object = null) : void
      {
         remoteInstance.play(param1);
      }
      
      public function get type() : String
      {
         return remoteInstance.type;
      }
   }
}
