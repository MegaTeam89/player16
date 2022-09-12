package anifire.component
{
   import anifire.constant.CcLibConstant;
   import anifire.constant.ServerConstants;
   import anifire.core.CCLipSyncController;
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   
   public class CcActionLoader extends EventDispatcher
   {
      
      private static var _loaders:UtilHashArray = new UtilHashArray();
       
      
      private const STATE_NULL:String = "STATE_NULL";
      
      private const STATE_LOADING:String = "STATE_LOADING";
      
      private const STATE_LOADED:String = "STATE_LOADED";
      
      private var _imageData:Object;
      
      private var _regulator:ProcessRegulator;
      
      private var _state:String = "STATE_NULL";
      
      public function CcActionLoader()
      {
         super();
      }
      
      public static function getActionLoader(param1:String) : CcActionLoader
      {
         var _loc2_:CcActionLoader = null;
         if(param1 && param1 != "")
         {
            _loc2_ = _loaders.getValueByKey(param1);
            if(!_loc2_)
            {
               _loc2_ = new CcActionLoader();
               _loaders.push(param1,_loc2_);
            }
            return _loc2_;
         }
         return new CcActionLoader();
      }
      
      public static function getStoreUrl(param1:String, param2:String = "", param3:Number = 1) : String
      {
         var _loc5_:String = null;
         var _loc7_:RegExp = null;
         var _loc4_:UtilHashArray = Util.getFlashVar();
         switch(param3)
         {
            case 3:
               _loc5_ = "";
               break;
            default:
               _loc5_ = "cc_store/";
         }
         var _loc6_:String;
         if((_loc6_ = _loc4_.getValueByKey(ServerConstants.FLASHVAR_STORE_PATH) as String) == "" || _loc6_ == null)
         {
            _loc6_ = (_loc6_ = _loc4_.getValueByKey(ServerConstants.FLASHVAR_APISERVER) as String) + ("static/store/" + _loc5_ + param1);
         }
         else
         {
            _loc7_ = new RegExp(ServerConstants.FLASHVAR_STORE_PLACEHOLDER,"g");
            _loc6_ = _loc6_.replace(_loc7_,_loc5_ + param1);
         }
         return _loc6_;
      }
      
      public function get imageData() : Object
      {
         return this._imageData;
      }
      
      public function load(param1:String, param2:String = "", param3:String = "", param4:Boolean = false) : void
      {
         var request:URLRequest = null;
         var stream:UtilURLStream = null;
         var aid:String = param1;
         var actionId:String = param2;
         var facialId:String = param3;
         var isDefault:Boolean = param4;
         try
         {
            if(aid)
            {
               stream = new UtilURLStream();
               request = UtilNetwork.getGetCcActionRequest(aid,actionId,facialId,isDefault);
               stream.addEventListener(Event.COMPLETE,this.onXmlLoaded);
               stream.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
               stream.addEventListener(UtilURLStream.TIME_OUT,this.timeoutHandler);
               stream.load(request);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onXmlLoaded(param1:Event) : void
      {
         var stream:URLStream = null;
         var bytes:ByteArray = null;
         var xmlCC:XML = null;
         var e:Event = param1;
         try
         {
            IEventDispatcher(e.target).removeEventListener(e.type,this.onXmlLoaded);
            stream = URLStream(e.target);
            bytes = new ByteArray();
            stream.readBytes(bytes);
            xmlCC = XML(bytes);
            this.loadCcComponents(xmlCC);
         }
         catch(e:Error)
         {
            dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
         }
      }
      
      public function loadCcComponents(param1:XML, param2:Number = 0, param3:Number = 0, param4:UtilHashArray = null, param5:UtilHashArray = null, param6:Number = 1, param7:Boolean = false, param8:String = "", param9:String = "", param10:Boolean = false) : void
      {
         var stream:URLStream = null;
         var url:String = null;
         var node:XML = null;
         var loader:CcComponentLoader = null;
         var isVideoRecord:String = null;
         var componentId:String = null;
         var freeActionShape:String = null;
         var themeId:String = null;
         var type:String = null;
         var xml:XML = param1;
         var startMilliSec:Number = param2;
         var endMilliSec:Number = param3;
         var data:UtilHashArray = param4;
         var skins:UtilHashArray = param5;
         var ver:Number = param6;
         var isPlayer:Boolean = param7;
         var key:String = param8;
         var actionId:String = param9;
         var isHead:Boolean = param10;
         if(this._state == this.STATE_LOADED)
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         else if(this._state == this.STATE_LOADING)
         {
            return;
         }
         this._state = this.STATE_LOADING;
         try
         {
            if(xml)
            {
               isVideoRecord = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_VIDEO_RECORD_MODE) as String;
               this._imageData = new Object();
               this._imageData["imageData"] = !!data ? data : new UtilHashArray();
               this._imageData["xml"] = xml;
               this._regulator = new ProcessRegulator();
               for each(node in xml..library)
               {
                  themeId = node.@theme_id;
                  type = node.@type;
                  if(ver == 3)
                  {
                     if(node.@type == CcLibConstant.COMPONENT_TYPE_MOUTH)
                     {
                        this.doLoadExtraComponent(node,actionId,ver);
                        continue;
                     }
                     url = getStoreUrl(themeId + "/charparts" + "/" + type + "/" + node.@path + ".swf",themeId,ver);
                     type = CcLibConstant.LIBRARY_TYPE_GOHANDS;
                  }
                  else
                  {
                     url = getStoreUrl(themeId + "/" + type + "/" + node.@path + ".swf",themeId);
                  }
                  componentId = themeId + "." + type + "." + node.@path + ".swf";
                  if(UtilHashArray(this._imageData["imageData"]).getValueByKey(componentId) == null)
                  {
                     loader = CcComponentLoader.getComponentLoader(componentId,url);
                     loader.addEventListener(Event.COMPLETE,this.onCcComponentLoaded);
                     loader.addEventListener(IOErrorEvent.IO_ERROR,this.onCcComponentFailed);
                     this._regulator.addProcess(loader,Event.COMPLETE);
                  }
               }
               freeActionShape = "default";
               for each(node in xml..component)
               {
                  if(node.@type == "bodyshape")
                  {
                     freeActionShape = node.@path;
                  }
               }
               for each(node in xml..component)
               {
                  if(node.hasOwnProperty("@file"))
                  {
                     url = getStoreUrl(node.@theme_id + "/" + node.@type + "/" + node.@path + "/" + node.@file);
                  }
                  else
                  {
                     if(!(node.@type == "freeaction" && node.@path != "default" && !isHead))
                     {
                        continue;
                     }
                     url = getStoreUrl(node.@theme_id + "/" + node.@type + "/" + freeActionShape + "/" + node.@path + ".swf");
                  }
                  componentId = node.@theme_id + "." + node.@type + "." + node.@path + ".swf";
                  if(UtilHashArray(this._imageData["imageData"]).getValueByKey(componentId) == null)
                  {
                     loader = CcComponentLoader.getComponentLoader(componentId,url);
                     loader.addEventListener(Event.COMPLETE,this.onCcComponentLoaded);
                     loader.addEventListener(IOErrorEvent.IO_ERROR,this.onCcComponentFailed);
                     this._regulator.addProcess(loader,Event.COMPLETE);
                  }
                  this.doLoadExtraComponent(node);
               }
               this._regulator.startProcess();
               if(this._regulator.numProcess == 0)
               {
                  this._state = this.STATE_LOADED;
                  this.dispatchEvent(new Event(Event.COMPLETE));
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onCcComponentLoaded(param1:Event) : void
      {
         var loader:CcComponentLoader = null;
         var e:Event = param1;
         try
         {
            loader = CcComponentLoader(e.target);
            if(loader)
            {
               loader.removeEventListener(e.type,this.onCcComponentLoaded);
               this.addComponent(loader.componentId,loader.swfBytes);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function addComponent(param1:String, param2:ByteArray) : void
      {
         UtilHashArray(this._imageData["imageData"]).push(param1,param2);
         this.progress();
      }
      
      private function progress() : void
      {
         var _loc1_:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
         _loc1_.bytesLoaded = UtilHashArray(this._imageData["imageData"]).length;
         _loc1_.bytesTotal = this._regulator.numProcess;
         this.dispatchEvent(_loc1_);
         if(UtilHashArray(this._imageData["imageData"]).length == this._regulator.numProcess)
         {
            this._state = this.STATE_LOADED;
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function doLoadExtraComponent(param1:XML, param2:String = "", param3:Number = 1) : void
      {
         var _loc4_:CcComponentLoader = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc5_:UtilHashArray = new UtilHashArray();
         if(param1.@type == CcLibConstant.COMPONENT_TYPE_MOUTH)
         {
            _loc7_ = CCLipSyncController.getLipSyncComponentItems(param1,param2,param3);
            _loc5_.insert(0,_loc7_);
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc8_ = _loc5_.getKey(_loc6_);
            _loc9_ = _loc5_.getValueByIndex(_loc6_);
            if(UtilHashArray(this._imageData["imageData"]).getValueByKey(_loc9_) == null)
            {
               (_loc4_ = CcComponentLoader.getComponentLoader(_loc9_,_loc8_)).addEventListener(Event.COMPLETE,this.onCcComponentLoaded);
               _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onCcComponentFailed);
               this._regulator.addProcess(_loc4_,Event.COMPLETE);
            }
            _loc6_++;
         }
      }
      
      private function onCcComponentFailed(param1:IOErrorEvent) : void
      {
         var _loc2_:CcComponentLoader = CcComponentLoader(param1.target);
         if(_loc2_)
         {
            _loc2_.removeEventListener(param1.type,this.onCcComponentFailed);
            this.addComponent(_loc2_.componentId,_loc2_.swfBytes);
         }
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function timeoutHandler(param1:Event) : void
      {
         this.dispatchEvent(param1);
      }
      
      public function clearImageData() : void
      {
         this._imageData = null;
      }
   }
}
