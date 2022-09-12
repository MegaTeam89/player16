package com.google.ads.instream.api
{
   import flash.utils.Dictionary;
   
   public interface FlashAd extends Ad
   {
       
      
      function get asset() : FlashAsset;
      
      function enableManualEventsReporting() : void;
      
      function reportEvents() : void;
      
      function reportCustomKeysAndValues(param1:Dictionary) : void;
   }
}
