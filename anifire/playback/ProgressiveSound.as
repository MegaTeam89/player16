package anifire.playback
{
   import anifire.constant.AnimeConstants;
   import anifire.core.AssetLinkage;
   import anifire.event.AVM2SoundEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.interfaces.ISoundAsset;
   import anifire.sound.SoundFactory;
   import anifire.sound.SoundHelper;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundLoaderContext;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class ProgressiveSound extends AnimeSound implements ISoundAsset
   {
      
      private static var STATE_NULL:int = 0;
      
      private static var STATE_PLAYING:int = 1;
      
      private static var STATE_PAUSED:int = 2;
       
      
      private var _state:int;
      
      private var _sound:Sound;
      
      private var _soundChannel:SoundChannel;
      
      private var _currentPlayingMilliSecond:Number;
      
      private var _soundTransform:SoundTransform;
      
      private var _isSoundCompletelyDownload:Boolean;
      
      private var _skipSpeechDispatch:Boolean = false;
      
      private var _numTry:Number = 0;
      
      private var _urlRequest:URLRequest;
      
      public function ProgressiveSound()
      {
         super();
      }
      
      private function get isSoundCompletelyDownload() : Boolean
      {
         return this._isSoundCompletelyDownload;
      }
      
      private function set isSoundCompletelyDownload(param1:Boolean) : void
      {
         this._isSoundCompletelyDownload = param1;
      }
      
      private function get state() : Number
      {
         return this._state;
      }
      
      private function set state(param1:Number) : void
      {
         this._state = param1;
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      public function set sound(param1:Sound) : void
      {
         if(param1 && param1 != this._sound)
         {
            if(this._sound != null)
            {
               this._sound.removeEventListener(Event.COMPLETE,this.onSoundCompletelyDownloaded);
               this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onSoundDownloading);
               this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onSoundLoadFailed);
            }
            this._sound = param1;
            this._sound.addEventListener(Event.COMPLETE,this.onSoundCompletelyDownloaded);
            this._sound.addEventListener(ProgressEvent.PROGRESS,this.onSoundDownloading);
            this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onSoundLoadFailed);
            this._isSoundCompletelyDownload = false;
         }
      }
      
      public function load() : void
      {
         var _loc1_:SoundLoaderContext = null;
         if(this._sound && this._urlRequest)
         {
            _loc1_ = new SoundLoaderContext();
            _loc1_.bufferTime = 0;
            this._sound.load(this._urlRequest,_loc1_);
         }
      }
      
      public function close() : void
      {
         try
         {
            if(this._sound)
            {
               this._sound.close();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onSoundLoadFailed(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundLoadFailed);
         if(this._numTry < 3)
         {
            this.sound = SoundFactory.createSound();
            this.load();
            ++this._numTry;
         }
         else
         {
            this.isSoundCompletelyDownload = true;
            dispatchEvent(param1);
         }
      }
      
      private function onSoundDownloading(param1:ProgressEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function processSound(param1:Event) : void
      {
      }
      
      private function get soundChannel() : SoundChannel
      {
         return this._soundChannel;
      }
      
      private function set soundChannel(param1:SoundChannel) : void
      {
         this._soundChannel = param1;
      }
      
      private function get soundTransform() : SoundTransform
      {
         return this._soundTransform;
      }
      
      private function set soundTransform(param1:SoundTransform) : void
      {
         this._soundTransform = param1;
      }
      
      override public function init(param1:XML, param2:UtilHashArray, param3:String, param4:PlayerDataStock) : Boolean
      {
         if(!super.init(param1,param2,param3,param4))
         {
            return false;
         }
         this.state = STATE_NULL;
         return true;
      }
      
      override public function initDependency(param1:Number, param2:Number, param3:DownloadManager) : void
      {
         super.initDependency(param1,param2,param3);
         var _loc4_:String = UtilXmlInfo.getThemeIdFromFileName(this.file);
         var _loc5_:String = UtilXmlInfo.getThumbIdFromFileName(this.file);
         this._urlRequest = UtilNetwork.getGetSoundAssetRequest(_loc4_,_loc5_,AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE);
         this.sound = SoundFactory.createSound();
         param3.registerSoundChannel(this._urlRequest,this.startMilliSec,this.endMilliSec,this);
         this.soundTransform = new SoundTransform(this.volume * this.fadeFactor * this.inner_volume);
         this.fadeVolumeBySubtype(this.startMilliSec);
      }
      
      private function onSoundCompletelyDownloaded(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundCompletelyDownloaded);
         this.isSoundCompletelyDownload = true;
         dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,1,1));
         dispatchEvent(param1);
      }
      
      private function onBufferExhaust(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onBufferExhaust);
         this.dispatchBufferExhaustEvent(this.soundChannel.position);
      }
      
      private function dispatchBufferExhaustEvent(param1:Number) : void
      {
         this._currentPlayingMilliSecond = param1;
         this.dispatchEvent(new AVM2SoundEvent(PlayerEvent.BUFFER_EXHAUST,this));
      }
      
      override public function getBufferProgress() : Number
      {
         return 100;
      }
      
      override public function setVolume(param1:Number) : void
      {
         this.volume = param1;
         this.soundTransform.volume = this.fadeFactor * this.volume * this.inner_volume;
         if(this.soundChannel !== null)
         {
            this.soundChannel.soundTransform = this.soundTransform;
         }
      }
      
      override public function fadeVolume(param1:Number) : void
      {
         this.fadeFactor = param1;
         this.soundTransform.volume = this.fadeFactor * this.volume * this.inner_volume;
         if(this.soundChannel !== null)
         {
            this.soundChannel.soundTransform = this.soundTransform;
         }
      }
      
      override public function play(param1:Number) : void
      {
         var loopSound:int = 0;
         var samples:ByteArray = null;
         var extract:Number = NaN;
         var lng:Number = NaN;
         var step:Number = NaN;
         var left:Number = NaN;
         var right:Number = NaN;
         var total:Number = NaN;
         var c:int = 0;
         var event:SpeechPitchEvent = null;
         var curMilliSec:Number = param1;
         try
         {
            loopSound = !!speechData ? 0 : int(int.MAX_VALUE);
            if(this._state != STATE_PLAYING)
            {
               if(SoundHelper.isSoundBufferReadyAtTime(this.sound,curMilliSec - this.startMilliSec,this.isSoundCompletelyDownload))
               {
                  this.soundChannel = this.sound.play((curMilliSec - this.startMilliSec) % this.sound.length,loopSound,this.soundTransform);
                  if(!this.isSoundCompletelyDownload)
                  {
                     SoundHelper.addBufferExhaustEventListenerToSoundChannel(this.soundChannel,this.sound,this.startMilliSec,this.endMilliSec,this.onBufferExhaust);
                  }
                  this.state = STATE_PLAYING;
               }
               else
               {
                  this._currentPlayingMilliSecond = curMilliSec;
                  this.dispatchBufferExhaustEvent(curMilliSec);
               }
            }
            else
            {
               this.fadeVolumeBySubtype(curMilliSec);
            }
            if(speechData)
            {
               samples = new ByteArray();
               extract = Math.floor(1 / AnimeConstants.FRAME_PER_SEC * 44100);
               lng = this.sound.extract(samples,extract);
               samples.position = 0;
               step = 64;
               total = 0;
               try
               {
                  c = 0;
                  while(c < 56)
                  {
                     left = samples.readFloat() * 128;
                     right = samples.readFloat() * 128;
                     left = Math.abs(left);
                     right = Math.abs(right);
                     total += left + right;
                     samples.position = c * step;
                     c++;
                  }
               }
               catch(e:Error)
               {
               }
               if(!this._skipSpeechDispatch)
               {
                  event = new SpeechPitchEvent(SpeechPitchEvent.PITCH);
                  event.sceneId = AssetLinkage.getSceneIdFromLinkage(speechData);
                  event.charId = AssetLinkage.getCharIdFromLinkage(speechData);
                  event.soundId = this.id;
                  event.value = total;
                  this.dispatchEvent(event);
               }
               this._skipSpeechDispatch = !this._skipSpeechDispatch;
               if(samples.bytesAvailable == 0)
               {
                  this.sound.extract(samples,1,0);
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function goToAndPause(param1:Number) : void
      {
         var targetMilliSec:Number = param1;
         try
         {
            this._currentPlayingMilliSecond = targetMilliSec;
            if(this.soundChannel != null)
            {
               this.soundChannel.removeEventListener(AVM2SoundEvent.BUFFER_EXHAUST,this.onBufferExhaust);
               this.soundChannel.stop();
               this.soundChannel = null;
            }
            this.state = STATE_PAUSED;
         }
         catch(e:Error)
         {
         }
      }
      
      override public function resume() : void
      {
         try
         {
            if(this._state != STATE_PLAYING)
            {
               if(SoundHelper.isSoundBufferReadyAtTime(this.sound,this._currentPlayingMilliSecond - this.startMilliSec,this.isSoundCompletelyDownload))
               {
                  this.soundChannel = this.sound.play((this._currentPlayingMilliSecond - this.startMilliSec) % this.sound.length,int.MAX_VALUE,this.soundTransform);
                  if(!this.isSoundCompletelyDownload)
                  {
                     SoundHelper.addBufferExhaustEventListenerToSoundChannel(this.soundChannel,this.sound,this.startMilliSec,this.endMilliSec,this.onBufferExhaust);
                  }
                  this.state = STATE_PLAYING;
               }
               else
               {
                  this.dispatchEvent(new AVM2SoundEvent(AVM2SoundEvent.BUFFER_EXHAUST,this));
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function pause(param1:Number) : void
      {
         var currentTimeInMilliSecond:Number = param1;
         try
         {
            if(this.soundChannel != null)
            {
               this._currentPlayingMilliSecond = this.soundChannel.position + this.startMilliSec;
               this.soundChannel.removeEventListener(AVM2SoundEvent.BUFFER_EXHAUST,this.onBufferExhaust);
               this.soundChannel.stop();
               this.soundChannel = null;
            }
            this.state = STATE_PAUSED;
         }
         catch(e:Error)
         {
         }
      }
   }
}
