package com.google.ads.instream.api
{
   import flash.display.InteractiveObject;
   
   public interface VideoAdsManager extends AdsManager
   {
       
      
      function set clickTrackingElement(param1:InteractiveObject) : void;
      
      function get mediaSelectionSettings() : MediaSelectionSettings;
      
      function get clickTrackingElement() : InteractiveObject;
      
      function set mediaSelectionSettings(param1:MediaSelectionSettings) : void;
   }
}
