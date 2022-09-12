package com.google.ads.instream.api
{
   import flash.events.Event;
   
   public class FlashAdCustomEvent extends AdEvent
   {
      
      public static const CUSTOM_EVENT:String = "customEvent";
       
      
      private var customEventContext:Object = null;
      
      public function FlashAdCustomEvent(param1:FlashAd, param2:Object)
      {
         super(CUSTOM_EVENT,param1);
         this.customEventContext = param2;
      }
      
      override public function clone() : Event
      {
         return new FlashAdCustomEvent(ad as FlashAd,customEventContext);
      }
      
      public function get eventContext() : Object
      {
         return customEventContext.eventObject;
      }
      
      public function get eventName() : String
      {
         return customEventContext.eventName;
      }
   }
}
