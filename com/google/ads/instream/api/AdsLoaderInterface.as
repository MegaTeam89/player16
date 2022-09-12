package com.google.ads.instream.api
{
   import flash.events.IEventDispatcher;
   
   public interface AdsLoaderInterface extends IEventDispatcher
   {
       
      
      function requestAds(param1:AdsRequest, param2:Object = null) : void;
      
      function unload() : void;
   }
}
