package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.FlashAdsManager;
   
   class FlashAdsManagerWrapper extends AdsManagerWrapper implements FlashAdsManager
   {
       
      
      function FlashAdsManagerWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function set x(param1:Number) : void
      {
         remoteInstance.x = param1;
      }
      
      public function set y(param1:Number) : void
      {
         remoteInstance.y = param1;
      }
      
      public function set decoratedAd(param1:Boolean) : void
      {
         remoteInstance.decoratedAd = param1;
      }
      
      public function get x() : Number
      {
         return remoteInstance.x;
      }
      
      public function get y() : Number
      {
         return remoteInstance.y;
      }
      
      public function set volumeAd(param1:Number) : void
      {
         remoteInstance.volumeAd = param1;
      }
      
      public function get volumeAd() : Number
      {
         return remoteInstance.volumeAd;
      }
   }
}
