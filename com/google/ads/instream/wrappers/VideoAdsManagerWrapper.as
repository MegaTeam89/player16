package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.MediaSelectionSettings;
   import com.google.ads.instream.api.VideoAdsManager;
   import flash.display.InteractiveObject;
   
   class VideoAdsManagerWrapper extends AdsManagerWrapper implements VideoAdsManager
   {
       
      
      private var localMediaSelectionSettings:MediaSelectionSettings;
      
      function VideoAdsManagerWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get y() : Number
      {
         return remoteInstance.y;
      }
      
      public function set mediaSelectionSettings(param1:MediaSelectionSettings) : void
      {
         localMediaSelectionSettings = param1;
         remoteInstance.mediaSelectionSettings = Wrappers.localToRemote(param1);
      }
      
      public function set x(param1:Number) : void
      {
         remoteInstance.x = param1;
      }
      
      public function get mediaSelectionSettings() : MediaSelectionSettings
      {
         if(localMediaSelectionSettings == null)
         {
            localMediaSelectionSettings = new MediaSelectionSettings();
         }
         if(remoteInstance.mediaSelectionSettings != null)
         {
            Wrappers.copy(remoteInstance.mediaSelectionSettings,localMediaSelectionSettings);
         }
         return localMediaSelectionSettings;
      }
      
      public function get x() : Number
      {
         return remoteInstance.x;
      }
      
      public function set y(param1:Number) : void
      {
         remoteInstance.y = param1;
      }
      
      public function set clickTrackingElement(param1:InteractiveObject) : void
      {
         remoteInstance.clickTrackingElement = param1;
      }
      
      public function get clickTrackingElement() : InteractiveObject
      {
         return remoteInstance.clickTrackingElement;
      }
      
      public function get isRenderedAsOverlay() : Boolean
      {
         return remoteInstance.isRenderedAsOverlay;
      }
   }
}
