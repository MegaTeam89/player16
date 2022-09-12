package anifire.component
{
   import anifire.constant.ServerConstants;
   import anifire.util.Util;
   import com.google.ads.instream.api.AdErrorEvent;
   import com.google.ads.instream.api.AdEvent;
   import com.google.ads.instream.api.AdsLoadedEvent;
   import com.google.ads.instream.api.AdsLoader;
   import com.google.ads.instream.api.AdsManager;
   import com.google.ads.instream.api.AdsManagerTypes;
   import com.google.ads.instream.api.AdsRequest;
   import com.google.ads.instream.api.FlashAdsManager;
   import com.google.ads.instream.api.VideoAdsManager;
   import fl.video.FLVPlayback;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Timer;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   
   public class AdSenseDisplay extends UIComponent
   {
      
      private static const PLAYER_WIDTH:Number = 550;
      
      private static const PLAYER_HEIGHT:Number = 384;
      
      private static const VIDEO_HEIGHT:Number = 354;
      
      private static const VIDEO_SCALE:Number = 0.9;
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var FLVHolder:FLVPlayback;
      
      private var params:Object;
      
      private var adsLoader:AdsLoader;
      
      private var _adSlotX:Number;
      
      private var _adSlotY:Number;
      
      private var _topLabelY:Number;
      
      private var _topLabelRight:Number;
      
      private var _bottomLabelY:Number;
      
      private var _googleAdsShown:Boolean = false;
      
      private var _adType:String;
      
      private var adsManager:AdsManager;
      
      public function AdSenseDisplay()
      {
         this.FLVHolder = new FLVPlayback();
         this.adsLoader = new AdsLoader();
         super();
         this.width = 550;
         this.height = 384;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      public function get topLabelY() : Number
      {
         return this._topLabelY;
      }
      
      public function get topLabelRight() : Number
      {
         return this._topLabelRight;
      }
      
      public function get bottomLabelY() : Number
      {
         return this._bottomLabelY;
      }
      
      public function getParams() : Object
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this.params = {};
         var _loc1_:String = ExternalInterface.call("window.location.search.substring",1);
         if(_loc1_)
         {
            _loc2_ = _loc1_.split("&");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if((_loc4_ = _loc2_[_loc3_].indexOf("=")) != -1)
               {
                  _loc5_ = _loc2_[_loc3_].substring(0,_loc4_);
                  _loc6_ = _loc2_[_loc3_].substring(_loc4_ + 1);
                  this.params[_loc5_] = _loc6_;
               }
               _loc3_++;
            }
         }
         return this.params;
      }
      
      public function loadAdSense(param1:Number = 0) : void
      {
         this.addChild(this.adsLoader);
         this.adsLoader.addEventListener(AdsLoadedEvent.ADS_LOADED,this.onAdSenseLoaded);
         this.adsLoader.addEventListener(AdErrorEvent.AD_ERROR,this.onAdSenseError);
         this._adSlotX = PLAYER_WIDTH * ((1 - VIDEO_SCALE) / 2);
         this._adSlotY = PLAYER_HEIGHT * ((1 - VIDEO_SCALE) / 2) + PLAYER_WIDTH * VIDEO_SCALE / 16 * 9 * ((1 - VIDEO_SCALE) / 2);
         this._topLabelY = this._adSlotY - 2;
         this._bottomLabelY = PLAYER_HEIGHT - 25;
         this._topLabelRight = this._adSlotX + PLAYER_WIDTH * VIDEO_SCALE - 87;
         var _loc2_:AdsRequest = new AdsRequest();
         var _loc3_:String = Util.getFlashVar().getValueByKey("playcount") as String;
         var _loc4_:String = Util.getFlashVar().getValueByKey("duration") as String;
         var _loc5_:String = Util.getFlashVar().getValueByKey("movieId") as String;
         var _loc6_:String = this.parentApplication.name.toString();
         var _loc7_:String = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISEMBED_ID) as String;
         if((_loc4_ == null || _loc4_ == "" || Number(_loc4_) == 0) && _loc7_ == "1" && param1 != 0)
         {
            _loc4_ = param1.toString();
         }
         if((_loc3_ || _loc7_ == "1") && Number(_loc4_) > 29 && _loc6_ != "rssplayer" && this._googleAdsShown == false)
         {
            if((_loc3_ == "2" || _loc3_ == "4") && param1 > 0 || _loc7_ == "1")
            {
               _loc2_.adSlotWidth = PLAYER_WIDTH;
               _loc2_.adSlotHeight = VIDEO_HEIGHT;
               _loc2_.publisherId = "ca-video-pub-9090384317741239";
               _loc2_.adType = "text_overlay";
               _loc2_.channels = ["text_overlay"];
               _loc2_.contentId = "1362916595";
               _loc2_.maxTotalAdDuration = 1500;
               _loc2_.descriptionUrl = "http://goanimate.com/showMovieInfo/" + _loc5_;
               this.adsLoader.requestAds(_loc2_);
               this._adType = "overlay";
               this._googleAdsShown = true;
            }
         }
      }
      
      private function onAdSenseLoaded(param1:AdsLoadedEvent) : void
      {
         var _loc2_:VideoAdsManager = null;
         var _loc3_:FlashAdsManager = null;
         var _loc4_:Timer = null;
         this.adsManager = param1.adsManager;
         this.adsManager.addEventListener(AdErrorEvent.AD_ERROR,this.onAdSenseError);
         this.adsManager.addEventListener(AdEvent.STARTED,this.onAdSenseStarted);
         if(this.adsManager.type == AdsManagerTypes.VIDEO)
         {
            this.adsManager.addEventListener(AdEvent.CONTENT_RESUME_REQUESTED,this.onAdSenseComplete);
            _loc2_ = this.adsManager as VideoAdsManager;
            _loc2_.clickTrackingElement = this;
            this.addChild(this.FLVHolder);
            this.FLVHolder.x = this._adSlotX;
            this.FLVHolder.y = this._adSlotY;
            this.FLVHolder.align = "middle";
            this.FLVHolder.width = PLAYER_WIDTH * VIDEO_SCALE;
            this.FLVHolder.height = VIDEO_HEIGHT * VIDEO_SCALE;
            this.FLVHolder.volume = 0.2;
            this.adsManager.load(this.FLVHolder);
            this.adsManager.play(this.FLVHolder);
         }
         else if(this.adsManager.type == AdsManagerTypes.FLASH)
         {
            _loc3_ = this.adsManager as FlashAdsManager;
            _loc3_.x = 0;
            _loc3_.y = 0;
            (_loc4_ = new Timer(15000,1)).addEventListener("timer",this.unloadFlashAds);
            _loc4_.start();
            _loc3_.load();
            _loc3_.play();
         }
      }
      
      public function unloadFlashAds(param1:TimerEvent) : void
      {
         this.adsManager.unload();
      }
      
      private function onAdSenseStarted(param1:AdEvent) : void
      {
         if(this._adType == "video")
         {
            this.dispatchEvent(new Event("ADS_FINISH_LOADING"));
         }
      }
      
      private function onAdSenseComplete(param1:AdEvent) : void
      {
         this.dispatchEvent(new Event("ADS_COMPELTED"));
         if(this.contains(this.FLVHolder))
         {
            this.removeChild(this.FLVHolder);
         }
         if(this.contains(this.adsLoader))
         {
            this.removeChild(this.adsLoader);
         }
         if(this.adsManager)
         {
            this.adsManager.unload();
            this.adsManager = null;
         }
      }
      
      private function onAdSenseError(param1:AdErrorEvent) : void
      {
         this.adsLoader.removeEventListener(AdErrorEvent.AD_ERROR,this.onAdSenseError);
         this._googleAdsShown = false;
         if(this._adType == "video")
         {
            this.dispatchEvent(new Event("ADS_FINISH_LOADING"));
         }
      }
   }
}
