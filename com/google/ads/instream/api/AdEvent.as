package com.google.ads.instream.api
{
   import flash.events.Event;
   
   public class AdEvent extends Event
   {
      
      public static const ALL_ADS_COMPLETE:String = "allAdsComplete";
      
      public static const RESTARTED:String = "restarted";
      
      public static const MIDPOINT:String = "midpoint";
      
      public static const FIRST_QUARTILE:String = "firstQuartile";
      
      public static const STARTED:String = "started";
      
      public static const USER_CLOSE:String = "userClose";
      
      public static const VOLUME_MUTED:String = "volumeMuted";
      
      public static const CLICK:String = "click";
      
      public static const CONTENT_RESUME_REQUESTED:String = "contentResumeRequested";
      
      public static const STOPPED:String = "stopped";
      
      public static const PAUSED:String = "paused";
      
      public static const COMPLETE:String = "complete";
      
      public static const THIRD_QUARTILE:String = "thirdQuartile";
      
      public static const CONTENT_PAUSE_REQUESTED:String = "contentPauseRequested";
       
      
      private var adInstance:Ad = null;
      
      public function AdEvent(param1:String, param2:Ad)
      {
         super(param1);
         this.adInstance = param2;
      }
      
      public function get ad() : Ad
      {
         return adInstance;
      }
      
      override public function clone() : Event
      {
         return new AdEvent(this.type,adInstance);
      }
   }
}
