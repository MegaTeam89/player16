package com.google.ads.instream.api
{
   public class AdsRequest
   {
       
      
      public var size:String = null;
      
      public var adSlotWidth:Number = 0;
      
      public var minTotalAdDuration:int = 0;
      
      public var disableCompanionAds:Boolean = false;
      
      public var adServerHost:String = "ad.doubleclick.net";
      
      public var adSlotHorizontalAlignment:String = "center";
      
      public var protocol:String = "http";
      
      public var adCommand:String = "pfadx";
      
      public var adsResponse:String;
      
      public var zone:String = null;
      
      public var uniqueAds:Boolean = false;
      
      public var numRedirects:uint = 4;
      
      public var maxTotalAdDuration:int = 100000;
      
      public var hostChannels:Array;
      
      public var publisherId:String = null;
      
      public var gender:uint;
      
      public var site:String = null;
      
      public var adSlotHeight:Number = 0;
      
      public var host:String;
      
      public var adSlotVerticalAlignment:String = "bottom";
      
      public var descriptionUrl:String = null;
      
      public var adTest:String = "off";
      
      public var channels:Array = null;
      
      public var adTimePosition:int = 1;
      
      public var adSafe:String = "high";
      
      public var extraTargetingKeyValues:Object = null;
      
      public var hostTierId:Number;
      
      public var language:String;
      
      public var mediaUrl:String = null;
      
      public var ordinal:String;
      
      public var contentId:String = null;
      
      public var adTagUrl:String = null;
      
      public var adType:String = "video";
      
      public var age:uint;
      
      public function AdsRequest()
      {
         ordinal = new Date().getTime().toString();
         super();
      }
   }
}
