package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.AdRuleAdBreak;
   
   class AdRuleAdBreakWrapper extends Wrapper implements AdRuleAdBreak
   {
       
      
      function AdRuleAdBreakWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get adType() : String
      {
         return remoteInstance.adType;
      }
      
      public function get adBreakType() : String
      {
         return remoteInstance.adBreakType;
      }
      
      public function get adTagUrl() : String
      {
         return remoteInstance.adTagUrl;
      }
      
      public function get duration() : int
      {
         return remoteInstance.duration;
      }
      
      public function get startTime() : int
      {
         return remoteInstance.startTime;
      }
   }
}
