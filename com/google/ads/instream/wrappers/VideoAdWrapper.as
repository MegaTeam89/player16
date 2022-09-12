package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.VideoAd;
   import flash.net.NetStream;
   
   class VideoAdWrapper extends AdWrapper implements VideoAd
   {
       
      
      function VideoAdWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get author() : String
      {
         return remoteInstance.author;
      }
      
      public function get deliveryType() : String
      {
         return remoteInstance.deliveryType;
      }
      
      public function get ISCI() : String
      {
         return remoteInstance.ISCI;
      }
      
      public function get mediaUrl() : String
      {
         return remoteInstance.mediaUrl;
      }
      
      public function get title() : String
      {
         return remoteInstance.title;
      }
      
      public function set netStream(param1:NetStream) : void
      {
         remoteInstance.netStream = param1;
      }
   }
}
