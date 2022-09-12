package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.AdError;
   import flash.utils.Dictionary;
   
   public class AdErrorWrapper extends Error implements AdError
   {
       
      
      private var remoteMethodResultsDictionary:Dictionary;
      
      private var localInstanceReference:Object;
      
      private var remoteInstanceReference:Object;
      
      public function AdErrorWrapper(param1:Object, param2:Object = null)
      {
         super();
         remoteMethodResultsDictionary = new Dictionary();
         this.remoteInstanceReference = param1;
         this.localInstanceReference = param2;
      }
      
      protected function get remoteMethodResultsStore() : Dictionary
      {
         return remoteMethodResultsDictionary;
      }
      
      public function get errorType() : String
      {
         return remoteInstance.errorType;
      }
      
      public function get localInstance() : Object
      {
         return localInstanceReference;
      }
      
      public function get innerError() : Error
      {
         return remoteInstance.innerError;
      }
      
      public function get errorCode() : int
      {
         return remoteInstance.errorCode;
      }
      
      public function get remoteInstance() : Object
      {
         return remoteInstanceReference;
      }
      
      public function get errorMessage() : String
      {
         return remoteInstance.errorMessage;
      }
   }
}
