package com.google.ads.instream.api
{
   import flash.display.Loader;
   import flash.system.ApplicationDomain;
   
   class SdkSwfLoader extends Loader
   {
       
      
      private var publisherApplicationDomainValue:ApplicationDomain;
      
      function SdkSwfLoader(param1:ApplicationDomain)
      {
         super();
         publisherApplicationDomainValue = param1;
      }
      
      public function get publisherApplicationDomain() : ApplicationDomain
      {
         return publisherApplicationDomainValue;
      }
   }
}
