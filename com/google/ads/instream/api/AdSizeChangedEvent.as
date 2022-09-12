package com.google.ads.instream.api
{
   import flash.events.Event;
   
   public class AdSizeChangedEvent extends Event
   {
      
      public static const REGULAR_SIZE_STATE:String = "regular";
      
      public static const EXPANDED_SIZE_STATE:String = "expanded";
      
      public static const MINIMIZED_SIZE_STATE:String = "minimized";
      
      public static const SIZE_CHANGED:String = "sizeChanged";
      
      public static const CLOSED_STATE:String = "closed";
       
      
      private var adWidth:Number = 0;
      
      private var adState:String = "regular";
      
      private var adHeight:Number = 0;
      
      private var adInstance:Ad = null;
      
      private var adTypeValue:String = null;
      
      public function AdSizeChangedEvent(param1:Ad, param2:String, param3:String, param4:Number, param5:Number)
      {
         super(SIZE_CHANGED);
         this.adInstance = param1;
         this.adTypeValue = param2;
         this.adState = param3;
         this.adWidth = param4;
         this.adHeight = param5;
      }
      
      public function get state() : String
      {
         return adState;
      }
      
      override public function clone() : Event
      {
         return new AdSizeChangedEvent(ad,adType,state,width,height);
      }
      
      public function get height() : Number
      {
         return adHeight;
      }
      
      public function get ad() : Ad
      {
         return adInstance;
      }
      
      public function get width() : Number
      {
         return adWidth;
      }
      
      public function get adType() : String
      {
         return adTypeValue;
      }
   }
}
