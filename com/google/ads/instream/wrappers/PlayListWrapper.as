package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.AdRule;
   import com.google.ads.instream.api.PlayList;
   import com.google.ads.instream.api.PlayListContent;
   
   class PlayListWrapper extends Wrapper implements PlayList
   {
       
      
      function PlayListWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get content() : PlayListContent
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.content,localInstance) as PlayListContent;
      }
      
      public function get adRule() : AdRule
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.adRule,localInstance) as AdRule;
      }
   }
}
