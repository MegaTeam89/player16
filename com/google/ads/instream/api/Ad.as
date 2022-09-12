package com.google.ads.instream.api
{
   public interface Ad
   {
       
      
      function get surveyUrl() : String;
      
      function getCompanionAdUrl(param1:String, param2:String = null) : String;
      
      function get type() : String;
      
      function get id() : String;
      
      function get traffickingParameters() : Object;
   }
}
