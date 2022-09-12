package com.google.ads.instream.api
{
   import com.google.ads.instream.wrappers.AdsLoaderWrapper;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.Security;
   import flash.utils.getQualifiedClassName;
   
   class BaseLoader extends Sprite
   {
      
      private static const SHALLOW_SDK_INTEGRATION:String = "shallow";
      
      private static const DOUBLECLICK_MEDIA_SERVER:String = "m1.2mdn.net";
      
      private static const DOUBLE_SANDBOXING_ENABLED:String = "doubleSandboxingEnabled=true";
      
      private static const SDK_HOST:String = "s0.2mdn.net";
      
      private static const SDK_LOCATION:String = "http://" + SDK_HOST + "/instream/adsapi_";
      
      private static const ADSAPI_CLASSNAME:String = "com.google.ads.loader.instream::VersionedSdkLoader";
      
      private static const SDK_INTEGRATION:String = "deep";
      
      private static const SHALLOW_SDK_HOST:String = "pagead2.googlesyndication.com";
      
      private static const SHALLOW_SDK_LOCATION:String = "http://" + SHALLOW_SDK_HOST + "/pagead/adsapi_";
      
      private static const UNLOAD_METHOD:String = "unload";
      
      private static const SDK_FULL_VERSION:String = "2.4.0";
      
      private static const SDK_MAJOR_VERSION:String = SDK_FULL_VERSION.split(".")[0];
       
      
      private var queuedListeners:Array;
      
      private var loader:Loader;
      
      private var queuedRequests:Array;
      
      private var wrapper:IEventDispatcher;
      
      var sdkLoaderFactory:Function;
      
      function BaseLoader()
      {
         queuedRequests = [];
         queuedListeners = [];
         sdkLoaderFactory = createSdkLoader;
         super();
         allowTrustedDomains();
      }
      
      private function onSdkLoaded(param1:Event) : void
      {
         removeSdkLoadListeners();
         var _loc2_:Object = param1;
         AdsLoaderWrapper.remoteApplicationDomainProxy = _loc2_.remoteApplicationDomainProxy;
         wrapper = createWrapper(_loc2_.adsLoader);
         if(wrapper != null)
         {
            processQueuedListeners();
            processQueuedRequests();
         }
         else
         {
            dispatchSdkLoadError("Internal error: remote wrapper is null");
         }
      }
      
      protected function dispatchSdkLoadError(param1:String) : void
      {
         throw new Error("Method must be overridden in a subclass");
      }
      
      private function removeSdkLoadListeners() : void
      {
         loader.removeEventListener(Event.COMPLETE,onSdkLoaded);
         loader.removeEventListener(ErrorEvent.ERROR,onSdkLoadError);
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onSdkLoaderSwfLoadComplete);
         loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onSdkLoadError);
         loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSdkLoadError);
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         var _loc4_:Object = null;
         if(isLocallyDispatchedEvent(param1))
         {
            super.removeEventListener(param1,param2);
         }
         if(wrapper != null)
         {
            wrapper.removeEventListener(param1,param2,param3);
         }
         else
         {
            for each(_loc4_ in queuedListeners)
            {
               if(param1 == _loc4_.type && param2 == _loc4_.listener)
               {
                  queuedListeners.splice(queuedListeners.indexOf(_loc4_),1);
                  break;
               }
            }
         }
      }
      
      protected function isLocallyDispatchedEvent(param1:String) : Boolean
      {
         throw new Error("Method must be overridden in a subclass");
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(isLocallyDispatchedEvent(param1))
         {
            super.addEventListener(param1,param2,param3,param4,param5);
         }
         if(wrapper != null)
         {
            wrapper.addEventListener(param1,param2,param3,param4,param5);
         }
         else
         {
            queuedListeners.push({
               "type":param1,
               "listener":param2,
               "useCapture":param3,
               "priority":param4,
               "useWeakReference":param5
            });
         }
      }
      
      private function createSdkLoader() : Loader
      {
         return new SdkSwfLoader(ApplicationDomain.currentDomain);
      }
      
      private function onSdkLoaderSwfLoadComplete(param1:Event) : void
      {
         var loadedClassName:String = null;
         var event:Event = param1;
         try
         {
            loadedClassName = getQualifiedClassName(loader.content);
            if(loadedClassName != ADSAPI_CLASSNAME)
            {
               handleSdkLoadError("SDK could not be loaded from " + sdkUrl);
            }
            else
            {
               loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onSdkLoaderSwfLoadComplete);
            }
         }
         catch(error:SecurityError)
         {
            handleSdkLoadError("SDK could not be loaded from " + sdkUrl);
         }
      }
      
      private function get sdkUrl() : String
      {
         var _loc1_:String = SDK_MAJOR_VERSION + ".swf?" + DOUBLE_SANDBOXING_ENABLED;
         if(SDK_INTEGRATION == SHALLOW_SDK_INTEGRATION)
         {
            return SHALLOW_SDK_LOCATION + _loc1_;
         }
         return SDK_LOCATION + _loc1_;
      }
      
      protected function invokeRemoteMethod(param1:String, ... rest) : void
      {
         if(wrapper != null)
         {
            invokeWrapperMethod(param1,rest);
         }
         else
         {
            queuedRequests.push({
               "method":param1,
               "args":rest
            });
            load();
         }
      }
      
      private function addSdkLoadListeners() : void
      {
         loader.addEventListener(Event.COMPLETE,onSdkLoaded);
         loader.addEventListener(ErrorEvent.ERROR,onSdkLoadError);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSdkLoaderSwfLoadComplete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onSdkLoadError);
         loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSdkLoadError);
      }
      
      private function allowTrustedDomains() : void
      {
         if(SDK_INTEGRATION == SHALLOW_SDK_INTEGRATION)
         {
            Security.allowDomain(SHALLOW_SDK_HOST);
            Security.allowInsecureDomain(SHALLOW_SDK_HOST);
         }
         else
         {
            Security.allowDomain(SDK_HOST);
            Security.allowInsecureDomain(SDK_HOST);
         }
         Security.allowDomain(DOUBLECLICK_MEDIA_SERVER);
         Security.allowInsecureDomain(DOUBLECLICK_MEDIA_SERVER);
      }
      
      private function processQueuedListeners() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in queuedListeners)
         {
            wrapper.addEventListener(_loc1_.type,_loc1_.listener,_loc1_.useCapture,_loc1_.priority,_loc1_.useWeakReference);
         }
         queuedListeners = [];
      }
      
      private function onSdkLoadError(param1:ErrorEvent) : void
      {
         handleSdkLoadError(param1.text);
      }
      
      private function handleSdkLoadError(param1:String) : void
      {
         removeSdkLoadListeners();
         dispatchSdkLoadError(param1);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         super.removeEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
         unload();
      }
      
      private function load() : void
      {
         var _loc1_:URLRequest = null;
         if(loader == null)
         {
            super.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
            loader = sdkLoaderFactory();
            addSdkLoadListeners();
            if(stage != null)
            {
               addChild(loader);
            }
            _loc1_ = new URLRequest(sdkUrl);
            loader.load(_loc1_);
         }
      }
      
      protected function createWrapper(param1:Object) : IEventDispatcher
      {
         throw new Error("Method must be overridden in a subclass");
      }
      
      private function invokeWrapperMethod(param1:String, param2:Array) : void
      {
         var _loc3_:Function = wrapper[param1];
         if(_loc3_ != null)
         {
            _loc3_.apply(wrapper,param2);
         }
         else
         {
            dispatchSdkLoadError("Internal error: No such method: " + param1);
         }
      }
      
      private function processQueuedRequests() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in queuedRequests)
         {
            invokeWrapperMethod(_loc1_.method,_loc1_.args);
         }
         queuedRequests = [];
      }
      
      public function unload() : void
      {
         if(loader != null)
         {
            invokeRemoteMethod(UNLOAD_METHOD);
            removeSdkLoadListeners();
            if(loader.parent != null)
            {
               loader.parent.removeChild(loader);
            }
            if(loader.hasOwnProperty("unloadAndStop"))
            {
               loader["unloadAndStop"]();
            }
            else
            {
               loader.unload();
            }
            loader = null;
            queuedRequests = [];
            queuedListeners = [];
         }
      }
   }
}
