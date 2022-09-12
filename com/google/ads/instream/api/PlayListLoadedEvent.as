package com.google.ads.instream.api
{
   import flash.events.Event;
   
   public class PlayListLoadedEvent extends Event
   {
      
      public static const PLAY_LIST_LOADED:String = "playListLoaded";
       
      
      private var playListManagerValue:PlayListManager;
      
      private var userRequestContextObject:Object;
      
      public function PlayListLoadedEvent(param1:PlayListManager, param2:Object)
      {
         super(PLAY_LIST_LOADED);
         this.playListManagerValue = param1;
         this.userRequestContextObject = param2;
      }
      
      public function get userRequestContext() : Object
      {
         return userRequestContextObject;
      }
      
      public function get playListManager() : PlayListManager
      {
         return this.playListManagerValue;
      }
      
      override public function clone() : Event
      {
         return new PlayListLoadedEvent(this.playListManagerValue,this.userRequestContextObject);
      }
   }
}
