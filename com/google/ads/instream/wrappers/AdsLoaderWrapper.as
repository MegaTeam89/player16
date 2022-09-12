package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.AdsLoaderInterface;
   import com.google.ads.instream.api.AdsRequest;
   
   public class AdsLoaderWrapper extends EventDispatcherWrapper implements AdsLoaderInterface
   {
       
      
      public function AdsLoaderWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public static function set remoteApplicationDomainProxy(param1:Object) : void
      {
         Wrappers.remoteApplicationDomainProxy = param1;
      }
      
      public function requestAds(param1:AdsRequest, param2:Object = null) : void
      {
         remoteInstance.requestAds(Wrappers.localToRemote(param1),param2);
      }
      
      public function unload() : void
      {
         remoteInstance.unload();
      }
   }
}
