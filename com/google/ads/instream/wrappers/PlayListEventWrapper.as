package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.PlayListEvent;
   import flash.events.Event;
   
   class PlayListEventWrapper extends PlayListEvent
   {
       
      
      private var localInstance:Object;
      
      private var remoteInstance:Object;
      
      function PlayListEventWrapper(param1:Object, param2:Object = null)
      {
         this.remoteInstance = param1;
         this.localInstance = param2;
         super(param1.type,param1.netStream);
      }
      
      override public function clone() : Event
      {
         return new PlayListEventWrapper(remoteInstance,localInstance);
      }
   }
}
