package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.Ad;
   
   class AdWrapper extends Wrapper implements Ad
   {
       
      
      function AdWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get type() : String
      {
         return remoteInstance.type;
      }
      
      public function get id() : String
      {
         return remoteInstance.id;
      }
      
      public function getCompanionAdUrl(param1:String, param2:String = null) : String
      {
         return remoteInstance.getCompanionAdUrl(param1,param2);
      }
      
      public function get surveyUrl() : String
      {
         return remoteInstance.surveyUrl;
      }
      
      public function get traffickingParameters() : Object
      {
         return remoteInstance.traffickingParameters;
      }
   }
}
