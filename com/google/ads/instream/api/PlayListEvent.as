package com.google.ads.instream.api
{
   import flash.events.Event;
   import flash.net.NetStream;
   
   public class PlayListEvent extends Event
   {
      
      public static const AD_STARTED:String = "playListAdStarted";
      
      public static const PLAY_LIST_STARTED:String = "playListStarted";
      
      public static const PLAY_LIST_COMPLETE:String = "playListComplete";
      
      public static const CONTENT_PAUSED:String = "playListContentPaused";
      
      public static const AD_COMPLETE:String = "playListAdComplete";
      
      public static const CONTENT_RESUMED:String = "playListContentResumed";
      
      public static const CONTENT_STARTED:String = "playListContentStarted";
      
      public static const CONTENT_COMPLETE:String = "playListContentComplete";
       
      
      private var netStreamValue:NetStream;
      
      public function PlayListEvent(param1:String, param2:NetStream = null)
      {
         super(param1);
         this.netStreamValue = param2;
      }
      
      public function get netStream() : NetStream
      {
         return netStreamValue;
      }
      
      override public function clone() : Event
      {
         return new PlayListEvent(this.type,this.netStreamValue);
      }
   }
}
