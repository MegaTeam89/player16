package com.google.ads.instream.api
{
   import flash.net.NetStream;
   
   public interface VideoAd extends Ad
   {
       
      
      function get ISCI() : String;
      
      function get author() : String;
      
      function get title() : String;
      
      function set netStream(param1:NetStream) : void;
      
      function get mediaUrl() : String;
      
      function get deliveryType() : String;
   }
}
