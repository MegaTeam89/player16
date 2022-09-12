package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.VastVideoAd;
   
   class VastVideoAdWrapper extends VideoAdWrapper implements VastVideoAd
   {
       
      
      function VastVideoAdWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get wrappers() : Array
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.wrappers,localInstance) as Array;
      }
      
      public function get customClicks() : Array
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.customClicks,localInstance) as Array;
      }
      
      public function get companionAdXMLList() : XMLList
      {
         return remoteInstance.companionAdXMLList;
      }
      
      public function get description() : String
      {
         return remoteInstance.description;
      }
      
      public function get nonLinearAdXMLList() : XMLList
      {
         return remoteInstance.nonLinearAdXMLList;
      }
      
      public function get adSystem() : String
      {
         return remoteInstance.adSystem;
      }
   }
}
