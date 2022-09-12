package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.VastCustomClick;
   
   class VastCustomClickWrapper extends Wrapper implements VastCustomClick
   {
       
      
      function VastCustomClickWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get id() : String
      {
         return remoteInstance.id;
      }
      
      public function get url() : String
      {
         return remoteInstance.url;
      }
   }
}
