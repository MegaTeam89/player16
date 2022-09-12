package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.Ad;
   import com.google.ads.instream.api.AdEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   class AdEventWrapper extends AdEvent
   {
       
      
      private var localInstance:Object = null;
      
      private var remoteMethodResultsStore:Dictionary;
      
      private var remoteInstance:Object = null;
      
      function AdEventWrapper(param1:Object, param2:Object = null)
      {
         remoteMethodResultsStore = new Dictionary();
         this.remoteInstance = param1;
         this.localInstance = param2;
         super(param1.type,Wrappers.remoteToLocal(remoteMethodResultsStore,param1.ad,localInstance) as Ad);
      }
      
      override public function clone() : Event
      {
         return new AdEventWrapper(remoteInstance,localInstance);
      }
   }
}
