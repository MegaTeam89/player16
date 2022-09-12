package com.google.ads.instream.wrappers
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class EventDispatcherWrapper extends EventDispatcher
   {
       
      
      private var remoteMethodResultsDictionary:Dictionary;
      
      private var localInstanceReference:Object;
      
      private var remoteInstanceReference:Object;
      
      private var listenersMap:Object;
      
      public function EventDispatcherWrapper(param1:Object, param2:Object = null)
      {
         listenersMap = {};
         super();
         remoteMethodResultsDictionary = new Dictionary();
         this.remoteInstanceReference = param1;
         this.localInstanceReference = param2;
      }
      
      private function listenerRemoved(param1:String) : void
      {
         if(listenersMap[param1])
         {
            --listenersMap[param1].count;
            if(listenersMap[param1].count == 0)
            {
               remoteInstance.removeEventListener(param1,listenersMap[param1].listener);
               listenersMap[param1] = null;
            }
         }
      }
      
      public function get localInstance() : Object
      {
         return localInstanceReference;
      }
      
      private function listenerAdded(param1:String) : void
      {
         var type:String = param1;
         if(!listenersMap[type])
         {
            listenersMap[type] = {};
            listenersMap[type].count = 0;
            listenersMap[type].listener = function(param1:Event):void
            {
               dispatchEvent(Wrappers.unwrappedRemoteToLocal(remoteMethodResultsStore,param1) as Event);
               delete remoteMethodResultsStore[param1];
            };
            remoteInstance.addEventListener(type,listenersMap[type].listener);
         }
         ++listenersMap[type].count;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         listenerAdded(param1);
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         super.removeEventListener(param1,param2,param3);
         listenerRemoved(param1);
      }
      
      protected function get remoteMethodResultsStore() : Dictionary
      {
         return remoteMethodResultsDictionary;
      }
      
      public function get remoteInstance() : Object
      {
         return remoteInstanceReference;
      }
   }
}
