package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.AdRule;
   
   class AdRuleWrapper extends Wrapper implements AdRule
   {
       
      
      function AdRuleWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get adBreaks() : Array
      {
         return Wrappers.remoteToLocal(remoteMethodResultsStore,remoteInstance.adBreaks,localInstance) as Array;
      }
   }
}
