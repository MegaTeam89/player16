package com.google.ads.instream.wrappers
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   class Wrapper extends EventDispatcher
   {
       
      
      private var remoteInstanceReference:Object;
      
      private var remoteMethodResultsDictionary:Dictionary;
      
      private var localInstanceReference:Object;
      
      function Wrapper(param1:Object, param2:Object = null)
      {
         remoteMethodResultsDictionary = new Dictionary();
         super();
         remoteMethodResultsDictionary = new Dictionary();
         this.remoteInstanceReference = param1;
         this.localInstanceReference = param2;
      }
      
      public function get remoteInstance() : Object
      {
         return remoteInstanceReference;
      }
      
      protected function get remoteMethodResultsStore() : Dictionary
      {
         return remoteMethodResultsDictionary;
      }
      
      public function get localInstance() : Object
      {
         return localInstanceReference;
      }
   }
}
