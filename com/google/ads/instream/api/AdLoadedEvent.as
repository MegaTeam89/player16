package com.google.ads.instream.api
{
   import flash.events.Event;
   import flash.net.NetStream;
   
   public class AdLoadedEvent extends Event
   {
      
      public static const LOADED:String = "loaded";
       
      
      private var netStreamInstance:NetStream = null;
      
      private var adInstance:Ad = null;
      
      private var adTypeValue:String = null;
      
      public function AdLoadedEvent(param1:Ad, param2:String, param3:NetStream = null)
      {
         super(LOADED);
         this.adInstance = param1;
         this.adTypeValue = param2;
         this.netStreamInstance = param3;
      }
      
      override public function clone() : Event
      {
         return new AdLoadedEvent(ad,adType,netStream);
      }
      
      public function get ad() : Ad
      {
         return adInstance;
      }
      
      public function get adType() : String
      {
         return adTypeValue;
      }
      
      public function get netStream() : NetStream
      {
         return netStreamInstance;
      }
   }
}
