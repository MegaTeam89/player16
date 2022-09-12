package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.Ad;
   import com.google.ads.instream.api.AdLoadedEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   class AdLoadedEventWrapper extends AdLoadedEvent
   {
       
      
      private var localInstance:Object = null;
      
      private var remoteMethodResultsStore:Dictionary;
      
      private var remoteInstance:Object = null;
      
      function AdLoadedEventWrapper(param1:Object, param2:Object = null)
      {
         remoteMethodResultsStore = new Dictionary();
         this.remoteInstance = param1;
         this.localInstance = param2;
         super(Wrappers.remoteToLocal(remoteMethodResultsStore,param1.ad,localInstance) as Ad,param1.type,param1.netStream);
      }
      
      override public function clone() : Event
      {
         return new AdLoadedEventWrapper(remoteInstance,localInstance);
      }
   }
}
