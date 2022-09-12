package com.google.ads.instream.api
{
   import com.google.ads.instream.wrappers.AdsLoaderWrapper;
   import flash.events.IEventDispatcher;
   
   public class AdsLoader extends BaseLoader
   {
      
      private static const REQUEST_ADS_METHOD:String = "requestAds";
       
      
      public function AdsLoader()
      {
         super();
      }
      
      public function requestAds(param1:AdsRequest, param2:Object = null) : void
      {
         super.invokeRemoteMethod(REQUEST_ADS_METHOD,param1,param2);
      }
      
      override protected function dispatchSdkLoadError(param1:String) : void
      {
         var _loc2_:AdsLoaderError = new AdsLoaderError(param1);
         _loc2_.errorType = AdErrorTypes.AD_LOAD_ERROR;
         var _loc3_:AdErrorEvent = new AdErrorEvent(_loc2_);
         dispatchEvent(_loc3_);
      }
      
      override protected function isLocallyDispatchedEvent(param1:String) : Boolean
      {
         return param1 == AdErrorEvent.AD_ERROR;
      }
      
      override protected function createWrapper(param1:Object) : IEventDispatcher
      {
         return new AdsLoaderWrapper(param1);
      }
   }
}
