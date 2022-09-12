package com.google.ads.instream.api
{
   import flash.events.IEventDispatcher;
   
   public interface AdsManager extends IEventDispatcher
   {
       
      
      function get ads() : Array;
      
      function set adSlotWidth(param1:Number) : void;
      
      function play(param1:Object = null) : void;
      
      function get adSlotWidth() : Number;
      
      function load(param1:Object = null) : void;
      
      function set adSlotHeight(param1:Number) : void;
      
      function get adSlotHeight() : Number;
      
      function get type() : String;
      
      function unload() : void;
   }
}
