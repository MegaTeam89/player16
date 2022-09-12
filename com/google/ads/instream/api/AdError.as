package com.google.ads.instream.api
{
   public interface AdError
   {
       
      
      function get errorType() : String;
      
      function get innerError() : Error;
      
      function get errorCode() : int;
      
      function get errorMessage() : String;
   }
}
