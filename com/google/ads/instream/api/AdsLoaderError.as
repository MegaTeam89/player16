package com.google.ads.instream.api
{
   class AdsLoaderError extends Error implements AdError
   {
       
      
      private var flashError:Error = null;
      
      private var type:String = null;
      
      function AdsLoaderError(param1:String = "", param2:int = 0)
      {
         super(param1,param2);
      }
      
      public function get errorType() : String
      {
         return type;
      }
      
      public function set innerError(param1:Error) : void
      {
         this.flashError = param1;
      }
      
      public function set errorType(param1:String) : void
      {
         this.type = param1;
      }
      
      public function get innerError() : Error
      {
         return flashError;
      }
      
      public function get errorCode() : int
      {
         return super.errorID;
      }
      
      public function get errorMessage() : String
      {
         return super.message;
      }
   }
}
