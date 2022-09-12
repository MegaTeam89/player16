package anifire.component
{
   import anifire.constant.CcLibConstant;
   import anifire.constant.ServerConstants;
   import anifire.interfaces.IRegulatedProcess;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   
   public class CcComponentLoader extends EventDispatcher implements IRegulatedProcess
   {
      
      private static var _loaders:UtilHashArray = new UtilHashArray();
       
      
      private const NUM_TRY:Number = 3;
      
      private var _stream:URLStream;
      
      private var _swfBytes:ByteArray;
      
      private var _url:String;
      
      private var _numTry:int;
      
      private var _key:String;
      
      public function CcComponentLoader(param1:String, param2:String)
      {
         super();
         this._key = param1;
         this._url = param2;
      }
      
      public static function getComponentLoader(param1:String, param2:String) : CcComponentLoader
      {
         var _loc3_:CcComponentLoader = _loaders.getValueByKey(param1 + param2);
         if(!_loc3_)
         {
            _loc3_ = new CcComponentLoader(param1,param2);
            _loaders.push(param1 + param2,_loc3_);
         }
         return _loc3_;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function get swfBytes() : ByteArray
      {
         return this._swfBytes;
      }
      
      public function get componentId() : String
      {
         return this._key;
      }
      
      public function startProcess(param1:Boolean = false, param2:Number = 0) : void
      {
         this.load();
      }
      
      public function load() : void
      {
         if(this._swfBytes)
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else if(!this._stream)
         {
            this._numTry = 0;
            this.reload();
         }
      }
      
      private function reload() : void
      {
         try
         {
            if(this._url)
            {
               this.removeListeners();
               this._stream = new URLStream();
               this._stream.addEventListener(Event.COMPLETE,this.onSwfLoaded);
               this._stream.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
               this._stream.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
               this._stream.load(new URLRequest(this._url));
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         ++this._numTry;
         if(this._numTry < this.NUM_TRY)
         {
            this.reload();
         }
         else
         {
            this.removeListeners();
            this._stream = null;
            this.dispatchEvent(param1);
         }
      }
      
      private function removeListeners() : void
      {
         if(this._stream)
         {
            this._stream.removeEventListener(Event.COMPLETE,this.onSwfLoaded);
            this._stream.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._stream.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         }
      }
      
      private function onSwfLoaded(param1:Event) : void
      {
         var cType:String = null;
         var flashVars:UtilHashArray = null;
         var decryptEngine:UtilCrypto = null;
         var e:Event = param1;
         try
         {
            this.removeListeners();
            this._swfBytes = new ByteArray();
            this._stream.readBytes(this._swfBytes);
            this._stream = null;
            cType = this._key.split(".")[1];
            flashVars = Util.getFlashVar();
            if(flashVars.getValueByKey(ServerConstants.PARAM_ISOFFLINE) != "1")
            {
               if(CcLibConstant.ALL_LIBRARY_TYPES.indexOf(cType) == -1)
               {
                  decryptEngine = new UtilCrypto();
                  decryptEngine.decrypt(this._swfBytes);
                  decryptEngine = null;
               }
            }
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         catch(e:Error)
         {
         }
      }
   }
}
