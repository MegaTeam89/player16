package anifire.assets.transition
{
   import anifire.util.UtilDict;
   
   public class AssetTransitionConstants
   {
      
      public static const DIRECTION_IN:uint = 0;
      
      public static const DIRECTION_OUT:uint = 1;
      
      public static const SOUND_ON:uint = 0;
      
      public static const SOUND_OFF:uint = 1;
      
      public static const TYPE_APPEAR:String = "Appear";
      
      public static const TYPE_BLINDS:String = "Blinds";
      
      public static const TYPE_FADE:String = "Fade";
      
      public static const TYPE_FLY:String = "Fly";
      
      public static const TYPE_IRIS:String = "Iris";
      
      public static const TYPE_SLIDE:String = "Slide";
      
      public static const TYPE_PHOTO:String = "Photo";
      
      public static const TYPE_PIXELDISSOLVE:String = "PixelDissolve";
      
      public static const TYPE_ROTATE:String = "Rotate";
      
      public static const TYPE_SQUEEZE:String = "Squeeze";
      
      public static const TYPE_WIPE:String = "Wipe";
      
      public static const TYPE_ZOOM:String = "Zoom";
      
      public static const TYPE_BLUR:String = "Blur";
      
      public static const TIMING_AFTER_PREVIOUS:uint = 0;
      
      public static const TIMING_AFTER_NARRATION:uint = 1;
      
      public static const TIMING_ON_START:uint = 2;
      
      public static const TIMING_WITH_PREVIOUS:uint = 3;
      
      public static const TIMING_BEFORE_NARRATION:uint = 4;
      
      public static const TIMING_WITH_NARRATION:uint = 5;
      
      public static const DEST_TL:uint = 1;
      
      public static const DEST_TOP:uint = 2;
      
      public static const DEST_TR:uint = 3;
      
      public static const DEST_LEFT:uint = 4;
      
      public static const DEST_CENTER:uint = 5;
      
      public static const DEST_RIGHT:uint = 6;
      
      public static const DEST_BL:uint = 7;
      
      public static const DEST_BOTTOM:uint = 8;
      
      public static const DEST_BR:uint = 9;
      
      public static const TAG_NAME_TRANSITION_SOUND:String = "aTranSound";
      
      public static const TAG_NAME_TRANSITION:String = "aTran";
      
      public static const TAG_NAME_TRANSITION_LIST:String = "aTranList";
      
      public static const TAG_NAME_TRANSITION_SETTING:String = "aTranSetting";
      
      private static var _types:Array;
      
      private static var _directions:Array;
      
      private static var _soundModes:Array;
      
      private static var _timings:Array;
      
      private static var _sections:Array;
      
      private static var _destinations:Array;
       
      
      public function AssetTransitionConstants()
      {
         super();
      }
      
      public static function get directions() : Array
      {
         if(_directions)
         {
            return _directions.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":DIRECTION_IN,
            "label":UtilDict.toDisplay("go","Enter")
         });
         _loc1_.push({
            "id":DIRECTION_OUT,
            "label":UtilDict.toDisplay("go","Exit")
         });
         _directions = _loc1_;
         return _loc1_;
      }
      
      public static function get soundModes() : Array
      {
         if(_soundModes)
         {
            return _soundModes.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":SOUND_ON,
            "label":UtilDict.toDisplay("go","ON")
         });
         _loc1_.push({
            "id":SOUND_OFF,
            "label":UtilDict.toDisplay("go","OFF")
         });
         _soundModes = _loc1_;
         return _loc1_;
      }
      
      public static function get timings() : Array
      {
         if(_timings)
         {
            return _timings.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":TIMING_AFTER_PREVIOUS,
            "label":UtilDict.toDisplay("go","after previous")
         });
         _loc1_.push({
            "id":TIMING_WITH_PREVIOUS,
            "label":UtilDict.toDisplay("go","with previous")
         });
         _timings = _loc1_;
         return _loc1_;
      }
      
      public static function get sections() : Array
      {
         if(_sections)
         {
            return _sections.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":TIMING_BEFORE_NARRATION,
            "label":UtilDict.toDisplay("go","before narration")
         });
         _loc1_.push({
            "id":TIMING_WITH_NARRATION,
            "label":UtilDict.toDisplay("go","with narration")
         });
         _loc1_.push({
            "id":TIMING_AFTER_NARRATION,
            "label":UtilDict.toDisplay("go","after narration")
         });
         _sections = _loc1_;
         return _loc1_;
      }
      
      public static function get destinations() : Array
      {
         if(_destinations)
         {
            return _destinations.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_TL,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_TOP,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_TR,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_LEFT,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_RIGHT,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_BL,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_BOTTOM,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_BR,
            "label":""
         });
         _destinations = _loc1_;
         return _loc1_;
      }
      
      public static function getDestinationLabel(param1:uint) : String
      {
         var _loc2_:Array = AssetTransitionConstants.destinations;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         return "";
      }
      
      public static function getTimingLabel(param1:uint) : String
      {
         var _loc2_:Array = AssetTransitionConstants.timings;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         return "";
      }
      
      public static function getDirectionLabel(param1:uint) : String
      {
         var _loc2_:Array = AssetTransitionConstants.directions;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         return "";
      }
      
      public static function getTypeLabel(param1:String) : String
      {
         var _loc2_:Array = AssetTransitionConstants.types;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         return "";
      }
      
      public static function get types() : Array
      {
         if(_types)
         {
            return _types;
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":TYPE_APPEAR,
            "label":UtilDict.toDisplay("go",TYPE_APPEAR)
         });
         _loc1_.push({
            "id":TYPE_BLINDS,
            "label":UtilDict.toDisplay("go",TYPE_BLINDS)
         });
         _loc1_.push({
            "id":TYPE_BLUR,
            "label":UtilDict.toDisplay("go",TYPE_BLUR)
         });
         _loc1_.push({
            "id":TYPE_FADE,
            "label":UtilDict.toDisplay("go",TYPE_FADE)
         });
         _loc1_.push({
            "id":TYPE_IRIS,
            "label":UtilDict.toDisplay("go",TYPE_IRIS)
         });
         _loc1_.push({
            "id":TYPE_PHOTO,
            "label":UtilDict.toDisplay("go",TYPE_PHOTO)
         });
         _loc1_.push({
            "id":TYPE_PIXELDISSOLVE,
            "label":UtilDict.toDisplay("go",TYPE_PIXELDISSOLVE)
         });
         _loc1_.push({
            "id":TYPE_SLIDE,
            "label":UtilDict.toDisplay("go",TYPE_SLIDE)
         });
         _loc1_.push({
            "id":TYPE_WIPE,
            "label":UtilDict.toDisplay("go",TYPE_WIPE)
         });
         _types = _loc1_;
         return _loc1_;
      }
   }
}
