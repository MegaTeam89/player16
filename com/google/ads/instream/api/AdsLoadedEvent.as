package com.google.ads.instream.api
{
   import flash.events.Event;
   
   public class AdsLoadedEvent extends Event
   {
      
      public static const ADS_LOADED:String = "adsLoaded";
       
      
      private var userRequestContextObject:Object = null;
      
      private var adsListManager:AdsManager = null;
      
      public function AdsLoadedEvent(param1:AdsManager, param2:Object)
      {
         super(ADS_LOADED);
         this.adsListManager = param1;
         this.userRequestContextObject = param2;
      }
      
      public function get userRequestContext() : Object
      {
         return userRequestContextObject;
      }
      
      override public function clone() : Event
      {
         return new AdsLoadedEvent(adsListManager,userRequestContext);
      }
      
      public function get adsManager() : AdsManager
      {
         return adsListManager;
      }
   }
}
