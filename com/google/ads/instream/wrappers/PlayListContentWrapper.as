package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.PlayListContent;
   
   class PlayListContentWrapper extends Wrapper implements PlayListContent
   {
       
      
      function PlayListContentWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function set url(param1:String) : void
      {
         remoteInstance.url = param1;
      }
      
      public function get url() : String
      {
         return remoteInstance.url;
      }
   }
}
