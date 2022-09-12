package com.google.ads.instream.api
{
   import flash.events.IEventDispatcher;
   
   public interface FlashAsset extends IEventDispatcher
   {
       
      
      function get expandedHeight() : Number;
      
      function set y(param1:Number) : void;
      
      function get expandedWidth() : Number;
      
      function get width() : Number;
      
      function get height() : Number;
      
      function get x() : Number;
      
      function get y() : Number;
      
      function get type() : String;
      
      function get frameRate() : Number;
      
      function set x(param1:Number) : void;
   }
}
