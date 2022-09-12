package com.google.ads.instream.api
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   
   public class PlayListErrorEvent extends ErrorEvent
   {
      
      public static const PLAY_LIST_ERROR:String = "playListError";
       
      
      private var userRequestContextObject:Object = null;
      
      public function PlayListErrorEvent(param1:String, param2:Object = null)
      {
         super(PLAY_LIST_ERROR,false,false,param1);
         this.userRequestContextObject = param2;
      }
      
      public function get userRequestContext() : Object
      {
         return userRequestContextObject;
      }
      
      override public function clone() : Event
      {
         return new PlayListErrorEvent(text,userRequestContextObject);
      }
   }
}
