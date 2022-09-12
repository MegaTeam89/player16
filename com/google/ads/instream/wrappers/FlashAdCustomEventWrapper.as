package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.FlashAd;
   import com.google.ads.instream.api.FlashAdCustomEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   class FlashAdCustomEventWrapper extends FlashAdCustomEvent
   {
       
      
      private var localInstance:Object = null;
      
      private var remoteMethodResultsStore:Dictionary;
      
      private var remoteInstance:Object = null;
      
      function FlashAdCustomEventWrapper(param1:Object, param2:Object = null)
      {
         remoteMethodResultsStore = new Dictionary();
         this.remoteInstance = param1;
         this.localInstance = param2;
         super(Wrappers.remoteToLocal(remoteMethodResultsStore,param1.ad,localInstance) as FlashAd,{
            "eventObject":param1.eventContext,
            "eventName":param1.eventName
         });
      }
      
      override public function clone() : Event
      {
         return new FlashAdCustomEventWrapper(remoteInstance,localInstance);
      }
   }
}
