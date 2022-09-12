package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.PlayListErrorEvent;
   import flash.events.Event;
   
   class PlayListErrorEventWrapper extends PlayListErrorEvent
   {
       
      
      private var localInstance:Object;
      
      private var remoteInstance:Object;
      
      function PlayListErrorEventWrapper(param1:Object, param2:Object = null)
      {
         this.remoteInstance = param1;
         this.localInstance = param2;
         super(param1.text,param1.userRequestContext);
      }
      
      override public function clone() : Event
      {
         return new PlayListErrorEventWrapper(remoteInstance,localInstance);
      }
   }
}
