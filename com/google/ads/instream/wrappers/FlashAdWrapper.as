package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.FlashAd;
   import com.google.ads.instream.api.FlashAsset;
   import flash.utils.Dictionary;
   
   class FlashAdWrapper extends AdWrapper implements FlashAd
   {
       
      
      function FlashAdWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get asset() : FlashAsset
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.asset,localInstance) as FlashAsset;
      }
      
      public function reportCustomKeysAndValues(param1:Dictionary) : void
      {
         remoteInstance.reportCustomKeysAndValues(param1);
      }
      
      public function enableManualEventsReporting() : void
      {
         remoteInstance.enableManualEventsReporting();
      }
      
      public function reportEvents() : void
      {
         remoteInstance.reportEvents();
      }
   }
}
