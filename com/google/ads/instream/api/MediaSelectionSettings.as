package com.google.ads.instream.api
{
   public class MediaSelectionSettings
   {
       
      
      public var bandwidth:String;
      
      public var delivery:String;
      
      public var mimeTypes:Array;
      
      public function MediaSelectionSettings()
      {
         mimeTypes = VideoMimeTypes.DEFAULT_MIMETYPES;
         delivery = VideoDeliveryTypes.DEFAULT;
         bandwidth = VideoAdBandwidth.DEFAULT;
         super();
      }
   }
}
