package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.AdsLoadedEvent;
   import com.google.ads.instream.api.AdsManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   class AdsLoadedEventWrapper extends AdsLoadedEvent
   {
       
      
      private var localInstance:Object = null;
      
      private var remoteMethodResultsStore:Dictionary;
      
      private var remoteInstance:Object = null;
      
      function AdsLoadedEventWrapper(param1:Object, param2:Object = null)
      {
         remoteMethodResultsStore = new Dictionary();
         this.remoteInstance = param1;
         this.localInstance = param2;
         super(Wrappers.remoteToLocal(remoteMethodResultsStore,param1.adsManager,localInstance) as AdsManager,param1.userRequestContext);
      }
      
      override public function clone() : Event
      {
         return new AdsLoadedEventWrapper(remoteInstance,localInstance);
      }
   }
}
