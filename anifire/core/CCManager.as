package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.constant.AnimeConstants;
   import anifire.event.ByteLoaderEvent;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class CCManager extends EventDispatcher
   {
       
      
      private var _styleCollection:UtilHashArray;
      
      private var _cacheCollection:UtilHashArray;
      
      private var _styleName:Array;
      
      private var _partName:Array;
      
      private var _colors:UtilHashArray;
      
      private var _leftHandCache:Class;
      
      private var _rightHandCache:Class;
      
      private var _propHandStyle:String = "";
      
      public function CCManager()
      {
         this._styleCollection = new UtilHashArray();
         this._cacheCollection = new UtilHashArray();
         this._styleName = new Array();
         this._partName = new Array();
         this._colors = new UtilHashArray();
         super();
      }
      
      public function get colors() : UtilHashArray
      {
         return this._colors;
      }
      
      public function set colors(param1:UtilHashArray) : void
      {
         this._colors = param1;
      }
      
      public function addColor(param1:String, param2:SelectedColor) : void
      {
         this._colors.push(param1,param2);
      }
      
      public function deleteColor(param1:String) : void
      {
         this._colors.removeByKey(param1);
      }
      
      public function init() : void
      {
      }
      
      private function get leftHandCache() : Class
      {
         return this._leftHandCache;
      }
      
      private function get rightHandCache() : Class
      {
         return this._rightHandCache;
      }
      
      private function onLoadStyleDone(param1:Event) : void
      {
      }
      
      public function getColorByName(param1:String) : uint
      {
         if(this._colors.getValueByKey(param1) != null)
         {
            return SelectedColor(this._colors.getValueByKey(param1)).dstColor;
         }
         return uint.MAX_VALUE;
      }
      
      private function doPrepareFinished(param1:Event) : void
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function addStyle(param1:String, param2:LoaderInfo) : void
      {
         this._styleCollection.push(param1,param2);
      }
      
      public function removeStyle(param1:String) : void
      {
         this._styleCollection.removeByKey(param1);
      }
      
      public function loadPropThumbAsStyle(param1:Object, param2:String) : void
      {
         var _loc3_:Loader = null;
         this._propHandStyle = param2;
         if(param1)
         {
            _loc3_ = new Loader();
            if(param1 is ByteArray)
            {
               _loc3_.loadBytes(param1 as ByteArray);
            }
            else
            {
               _loc3_.loadBytes(param1["figure"] as ByteArray);
            }
            _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadPropThumbDone);
         }
      }
      
      private function onLoadPropThumbDone(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this._styleCollection.push(AnimeConstants.CLASS_GOPROP,_loc2_);
         this.dispatchEvent(new ByteLoaderEvent(ByteLoaderEvent.LOAD_BYTES_COMPLETE));
      }
      
      public function updatePropInfo(param1:LoaderInfo, param2:String) : void
      {
         this._propHandStyle = param2;
         this._styleCollection.push(AnimeConstants.CLASS_GOPROP,param1);
         this.dispatchEvent(new ByteLoaderEvent(ByteLoaderEvent.LOAD_BYTES_COMPLETE));
      }
      
      private function haveProp() : Boolean
      {
         if(this._styleCollection.getValueByKey(AnimeConstants.CLASS_GOPROP) != null)
         {
            return true;
         }
         return false;
      }
      
      private function isOneOfHandClass(param1:String) : Boolean
      {
         return param1.indexOf(AnimeConstants.HAND) > 0;
      }
      
      private function isOneOfRightHandClass(param1:String) : Boolean
      {
         return param1.indexOf(AnimeConstants.RIGHT) > 0 && this.isOneOfHandClass(param1);
      }
      
      private function cacheExist(param1:String) : Boolean
      {
         return this._cacheCollection.containsKey(param1);
      }
      
      private function getClassReferenceBySkinName(param1:String, param2:LoaderInfo = null, param3:Boolean = false) : Class
      {
         var _loc4_:Class = null;
         if(param3 || !this.cacheExist(param1))
         {
            _loc4_ = param2.applicationDomain.getDefinition(param1) as Class;
            this._cacheCollection.push(param1,_loc4_);
            return _loc4_;
         }
         return this._cacheCollection.getValueByKey(param1) as Class;
      }
      
      public function getSkin(param1:String, param2:String, param3:Boolean = false) : DisplayObjectContainer
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:Class = null;
         var _loc7_:Class = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:Array = null;
         var _loc11_:uint = 0;
         var _loc4_:LoaderInfo;
         if((_loc4_ = this._styleCollection.getValueByKey(!!this.isOneOfHandClass(param2) ? AnimeConstants.CLASS_GOHAND : param2) as LoaderInfo) != null)
         {
            if(this.haveProp() && this.isOneOfRightHandClass(param2))
            {
               param1 = AnimeConstants.ASSET_TYPE_PROP + this._propHandStyle + param1;
            }
            if(this.cacheExist(param1) || _loc4_.applicationDomain.hasDefinition(param1))
            {
               _loc6_ = this.getClassReferenceBySkinName(param1,_loc4_,param3);
               if(param2 == AnimeConstants.CLASS_GOLEFTLOWERHAND)
               {
                  this._leftHandCache = _loc6_;
               }
               if(param2 == AnimeConstants.CLASS_GORIGHTLOWERHAND)
               {
                  this._rightHandCache = _loc6_;
               }
               _loc5_ = new _loc6_() as DisplayObjectContainer;
            }
            else
            {
               if(param2 == AnimeConstants.CLASS_GOLEFTLOWERHAND)
               {
                  _loc7_ = this._leftHandCache;
               }
               if(param2 == AnimeConstants.CLASS_GORIGHTLOWERHAND)
               {
                  _loc7_ = this._rightHandCache;
               }
               if(_loc7_ != null)
               {
                  _loc5_ = new _loc7_() as DisplayObjectContainer;
               }
            }
            if(_loc5_ != null)
            {
               _loc8_ = UtilPlain.getColorItem(_loc5_);
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  _loc10_ = DisplayObject(_loc8_[_loc9_]).name.split("_");
                  if((_loc11_ = this.getColorByName(_loc10_[1])) != uint.MAX_VALUE)
                  {
                     UtilColor.setRGB(_loc8_[_loc9_],_loc11_);
                  }
                  _loc9_++;
               }
               return _loc5_;
            }
         }
         return null;
      }
   }
}
