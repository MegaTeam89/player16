package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.CustomContentAd;
   
   class CustomContentAdWrapper extends AdWrapper implements CustomContentAd
   {
       
      
      function CustomContentAdWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get content() : String
      {
         return remoteInstance.content;
      }
   }
}
