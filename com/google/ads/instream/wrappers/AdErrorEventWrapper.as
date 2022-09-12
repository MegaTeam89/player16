package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.AdError;
   import com.google.ads.instream.api.AdErrorEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   class AdErrorEventWrapper extends AdErrorEvent
   {
       
      
      private var localInstance:Object = null;
      
      private var remoteMethodResultsStore:Dictionary;
      
      private var remoteInstance:Object = null;
      
      function AdErrorEventWrapper(param1:Object, param2:Object = null)
      {
         remoteMethodResultsStore = new Dictionary();
         this.remoteInstance = param1;
         this.localInstance = param2;
         super(Wrappers.remoteToLocal(remoteMethodResultsStore,param1.error,localInstance) as AdError,param1.userRequestContext);
      }
      
      override public function clone() : Event
      {
         return new AdErrorEventWrapper(remoteInstance,localInstance);
      }
   }
}
