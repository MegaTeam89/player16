package com.google.ads.instream.api
{
   import flash.display.InteractiveObject;
   import flash.events.IEventDispatcher;
   
   public interface PlayListManager extends IEventDispatcher
   {
       
      
      function set adSlotY(param1:Number) : void;
      
      function get playList() : PlayList;
      
      function play(param1:Object) : void;
      
      function load(param1:Object) : void;
      
      function get adSlotX() : Number;
      
      function get adSlotY() : Number;
      
      function set clickTrackingElement(param1:InteractiveObject) : void;
      
      function get clickTrackingElement() : InteractiveObject;
      
      function set adSlotX(param1:Number) : void;
   }
}
