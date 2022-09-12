package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.VastWrapper;
   
   class VastWrapperWrapper extends Wrapper implements VastWrapper
   {
       
      
      function VastWrapperWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get adSystem() : String
      {
         return remoteInstance.adSystem;
      }
      
      public function get customClicks() : Array
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.customClicks,localInstance) as Array;
      }
   }
}
