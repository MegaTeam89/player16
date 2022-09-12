package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.DoubleClickStudioFlashAsset;
   
   class DoubleClickStudioFlashAssetWrapper extends FlashAssetWrapper implements DoubleClickStudioFlashAsset
   {
       
      
      function DoubleClickStudioFlashAssetWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function call(param1:String, ... rest) : void
      {
         rest.unshift(param1);
         remoteInstance.call.apply(remoteInstance,rest);
      }
   }
}
