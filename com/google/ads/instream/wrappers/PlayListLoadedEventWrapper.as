package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.PlayListLoadedEvent;
   import com.google.ads.instream.api.PlayListManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   class PlayListLoadedEventWrapper extends PlayListLoadedEvent
   {
       
      
      private var localInstance:Object;
      
      private var remoteMethodResultsStore:Dictionary;
      
      private var remoteInstance:Object;
      
      function PlayListLoadedEventWrapper(param1:Object, param2:Object = null)
      {
         remoteMethodResultsStore = new Dictionary();
         this.remoteInstance = param1;
         this.localInstance = param2;
         super(Wrappers.remoteToLocal(remoteMethodResultsStore,param1.playListManager,localInstance) as PlayListManager,param1.userRequestContext);
      }
      
      override public function clone() : Event
      {
         return new PlayListLoadedEventWrapper(remoteInstance,localInstance);
      }
   }
}
