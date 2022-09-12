package com.google.ads.instream.wrappers
{
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   class Wrappers
   {
      
      private static const INTERFACE_IMPLEMENTS_NUM_OF_INTERFACES:Object = {};
      
      private static var remoteApplicationDomainProxyValue:Object;
      
      private static const LOCAL_TO_REMOTE_CLASSES:Object = {
         "AdSlot":adSlotRemoteInstanceFactory,
         "AdsRequest":defaultRemoteInstanceFactory,
         "MediaSelectionSettings":defaultRemoteInstanceFactory,
         "PlayListRequest":defaultRemoteInstanceFactory,
         "YoutubeAdsRequest":defaultRemoteInstanceFactory
      };
      
      private static var remoteAppDomainProxyCreateInstanceArgumentsCount:int;
      
      private static const WRAPPED_CLASSES:Object = {
         "AdEvent":AdEventWrapper,
         "AdErrorEvent":AdErrorEventWrapper,
         "AdLoadedEvent":AdLoadedEventWrapper,
         "AdsLoadedEvent":AdsLoadedEventWrapper,
         "AdSizeChangedEvent":AdSizeChangedEventWrapper,
         "FlashAdCustomEvent":FlashAdCustomEventWrapper,
         "MediaSelectionSettings":MediaSelectionSettingsWrapper
      };
      
      private static const WRAPPED_INTERFACES:Object = {
         "Ad":AdWrapper,
         "AdError":AdErrorWrapper,
         "AdsManager":AdsManagerWrapper,
         "CustomContentAd":CustomContentAdWrapper,
         "DoubleClickStudioFlashAsset":DoubleClickStudioFlashAssetWrapper,
         "FlashAd":FlashAdWrapper,
         "FlashAdsManager":FlashAdsManagerWrapper,
         "FlashAsset":FlashAssetWrapper,
         "VastCustomClick":VastCustomClickWrapper,
         "VastVideoAd":VastVideoAdWrapper,
         "VastWrapper":VastWrapperWrapper,
         "VideoAd":VideoAdWrapper,
         "VideoAdsManager":VideoAdsManagerWrapper
      };
      
      private static const API_NAMESPACE:String = "com.google.ads.instream.api";
      
      {
         WRAPPED_CLASSES["PlayListEvent"] = PlayListEventWrapper;
         WRAPPED_CLASSES["PlayListErrorEvent"] = PlayListErrorEventWrapper;
         WRAPPED_CLASSES["PlayListLoadedEvent"] = PlayListLoadedEventWrapper;
         WRAPPED_INTERFACES["AdRule"] = AdRuleWrapper;
         WRAPPED_INTERFACES["AdRuleAdBreak"] = AdRuleAdBreakWrapper;
         WRAPPED_INTERFACES["PlayList"] = PlayListWrapper;
         WRAPPED_INTERFACES["PlayListContent"] = PlayListContentWrapper;
         WRAPPED_INTERFACES["PlayListManager"] = PlayListManagerWrapper;
      }
      
      function Wrappers()
      {
         super();
      }
      
      private static function isProxyObject(param1:Object) : Boolean
      {
         return remoteApplicationDomainProxy.isProxyObject(param1);
      }
      
      private static function filterByNamespace(param1:XML, param2:String) : Boolean
      {
         return param1.@type.indexOf(param2) == 0;
      }
      
      private static function countProxyCreateInstanceArguments() : int
      {
         var remoteApplicationDomainProxyInstanceXml:XML = null;
         if(remoteAppDomainProxyCreateInstanceArgumentsCount == 0)
         {
            remoteApplicationDomainProxyInstanceXml = describeType(remoteApplicationDomainProxy);
            remoteAppDomainProxyCreateInstanceArgumentsCount = remoteApplicationDomainProxyInstanceXml..method.(@name == "createInstance").parameter.length();
         }
         return remoteAppDomainProxyCreateInstanceArgumentsCount;
      }
      
      public static function remoteToLocal(param1:Dictionary, param2:Object, param3:Object = null) : Object
      {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:Class = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         if(param2 == null)
         {
            return null;
         }
         if(!param1[param2])
         {
            _loc4_ = !!isProxyObject(param2) ? remoteDescribeType(param2) : describeType(param2);
            _loc5_ = getTypeName(param2);
            if((_loc6_ = getWrapperType(_loc4_,_loc5_)) != null)
            {
               param1[param2] = new _loc6_(param2,param3);
            }
            else if((_loc7_ = getLocalDefinition(getQualifiedClassName(param2)) as Class) === Array)
            {
               _loc8_ = new _loc7_();
               for each(_loc9_ in param2)
               {
                  _loc8_.push(remoteToLocal(param1,_loc9_,param3));
               }
               param1[param2] = _loc8_;
            }
            else
            {
               param1[param2] = param2;
            }
         }
         return param1[param2];
      }
      
      private static function remoteDescribeType(param1:Object) : XML
      {
         return remoteApplicationDomainProxy.describeTypeOfProxyObject(param1);
      }
      
      private static function getWrapperTypeByInterface(param1:XML) : Object
      {
         var _loc4_:XML = null;
         var _loc5_:Object = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc11_:uint = 0;
         var _loc2_:Array = [];
         var _loc3_:XMLList = getApiInterfaces(param1);
         for each(_loc4_ in _loc3_)
         {
            _loc8_ = getTypeNameFromFullyQualifiedName(_loc4_);
            if(WRAPPED_INTERFACES[_loc8_])
            {
               _loc2_.push(_loc8_);
            }
         }
         _loc5_ = null;
         _loc6_ = 0;
         for each(_loc7_ in _loc2_)
         {
            _loc9_ = API_NAMESPACE + "." + _loc7_;
            _loc10_ = getLocalDefinition(_loc9_);
            _loc11_ = getImplementedInterfacesCount(_loc10_);
            if(!_loc5_ || _loc11_ > _loc6_)
            {
               _loc5_ = _loc10_;
               _loc6_ = _loc11_;
            }
         }
         if(_loc5_)
         {
            return WRAPPED_INTERFACES[getTypeName(_loc5_)];
         }
         return null;
      }
      
      private static function adSlotRemoteInstanceFactory(param1:Object, param2:Object) : Object
      {
         return new param1(param2.width,param2.height);
      }
      
      public static function get remoteApplicationDomainProxy() : Object
      {
         return remoteApplicationDomainProxyValue;
      }
      
      private static function defaultRemoteInstanceFactory(param1:Object, param2:Object) : Object
      {
         return new param1();
      }
      
      public static function set remoteApplicationDomainProxy(param1:Object) : void
      {
         remoteApplicationDomainProxyValue = param1;
      }
      
      private static function getRemoteInstanceFactoryForType(param1:String, param2:Object) : Function
      {
         var typeName:String = param1;
         var localInstance:Object = param2;
         var factory:Object = LOCAL_TO_REMOTE_CLASSES[typeName] as Function;
         if(factory != null)
         {
            return function(param1:Object):Object
            {
               return factory(param1,localInstance);
            };
         }
         return null;
      }
      
      private static function getTypeName(param1:Object) : String
      {
         var _loc2_:String = getQualifiedClassNameHelper(param1);
         return getTypeNameFromFullyQualifiedName(_loc2_);
      }
      
      public static function unwrappedRemoteToLocal(param1:Dictionary, param2:Object, param3:Object = null) : Object
      {
         return remoteToLocal(param1,remoteApplicationDomainProxy.wrapRemoteObject(param2),param3);
      }
      
      private static function getApiInterfaces(param1:Object) : XMLList
      {
         var interfacesSource:Object = param1;
         return interfacesSource.implementsInterface.(filterByNamespace(valueOf(),API_NAMESPACE)).@type;
      }
      
      private static function getTypeNameFromFullyQualifiedName(param1:String) : String
      {
         var _loc2_:Array = param1.split("::");
         var _loc3_:String = null;
         if(_loc2_.length == 2)
         {
            _loc3_ = _loc2_[1];
         }
         else
         {
            _loc3_ = _loc2_[0];
         }
         return _loc3_;
      }
      
      private static function getWrapperTypeByClass(param1:String) : Object
      {
         return WRAPPED_CLASSES[param1];
      }
      
      private static function getQualifiedClassNameHelper(param1:*) : String
      {
         var _loc2_:String = getQualifiedClassName(param1);
         if(_loc2_ == "com.google.ads.loader::ProxyObject")
         {
            return remoteApplicationDomainProxy.getQualifiedClassNameOfProxyObject(param1);
         }
         return _loc2_;
      }
      
      private static function getInstanceProperties(param1:Object) : Array
      {
         var node:XML = null;
         var instance:Object = param1;
         var typeXml:XML = describeType(instance);
         var propertyNames:Array = [];
         for each(node in typeXml..variable)
         {
            propertyNames.push(node.@name);
         }
         for each(node in typeXml..accessor.(@access == "readwrite"))
         {
            propertyNames.push(node.@name);
         }
         return propertyNames;
      }
      
      public static function getLocalDefinition(param1:String) : Object
      {
         var fullyQualifiedName:String = param1;
         var applicationDomain:ApplicationDomain = ApplicationDomain.currentDomain;
         if(applicationDomain.hasDefinition(fullyQualifiedName))
         {
            try
            {
               return applicationDomain.getDefinition(fullyQualifiedName);
            }
            catch(error:Error)
            {
            }
         }
         return null;
      }
      
      private static function getImplementedInterfacesCount(param1:Object) : uint
      {
         var _loc2_:XML = null;
         var _loc3_:XMLList = null;
         if(!INTERFACE_IMPLEMENTS_NUM_OF_INTERFACES[param1])
         {
            _loc2_ = describeType(param1);
            _loc3_ = getApiInterfaces(_loc2_.factory);
            INTERFACE_IMPLEMENTS_NUM_OF_INTERFACES[param1] = _loc3_.length();
         }
         return INTERFACE_IMPLEMENTS_NUM_OF_INTERFACES[param1];
      }
      
      public static function copy(param1:Object, param2:Object) : void
      {
         var _loc3_:String = null;
         for each(_loc3_ in getInstanceProperties(param1))
         {
            param2[_loc3_] = localToRemote(param1[_loc3_]);
         }
      }
      
      private static function getWrapperType(param1:XML, param2:String) : Object
      {
         var _loc3_:Object = getWrapperTypeByClass(param2);
         if(!_loc3_)
         {
            _loc3_ = getWrapperTypeByInterface(param1);
         }
         return _loc3_;
      }
      
      public static function localToRemote(param1:Object) : Object
      {
         var _loc3_:Function = null;
         var _loc4_:Object = null;
         var _loc2_:String = getTypeName(param1);
         if(LOCAL_TO_REMOTE_CLASSES[_loc2_] != null)
         {
            _loc3_ = getRemoteInstanceFactoryForType(_loc2_,param1);
            if(countProxyCreateInstanceArguments() == 2)
            {
               _loc4_ = remoteApplicationDomainProxy.createInstance(API_NAMESPACE + "." + _loc2_,_loc3_);
            }
            else if(countProxyCreateInstanceArguments() == 1)
            {
               _loc4_ = remoteApplicationDomainProxy.createInstance(API_NAMESPACE + "." + _loc2_);
            }
            Wrappers.copy(param1,_loc4_);
            return _loc4_;
         }
         return param1;
      }
   }
}
