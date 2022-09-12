package anifire.playback.asset.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IPlayerAssetView;
   import anifire.playback.asset.transition.AssetAppearTransitionView;
   import anifire.playback.asset.transition.AssetBlurTransitionView;
   import anifire.playback.asset.transition.AssetFlexTransitionView;
   import anifire.playback.asset.transition.AssetSlideTransitionView;
   import anifire.playback.asset.transition.AssetTransition;
   import anifire.playback.asset.transition.AssetTransitionCollection;
   import anifire.playback.asset.transition.AssetTransitionView;
   import flash.display.DisplayObject;
   
   public class AssetViewFactory
   {
       
      
      public function AssetViewFactory()
      {
         super();
      }
      
      public static function createAssetView(param1:AssetTransitionCollection) : DisplayObject
      {
         var _loc3_:AssetTransition = null;
         var _loc2_:IIterator = param1.iterator();
         var _loc4_:IPlayerAssetView = new AssetView();
         while(_loc2_.hasNext)
         {
            _loc3_ = _loc2_.next as AssetTransition;
            switch(_loc3_.type)
            {
               case AssetTransitionConstants.TYPE_APPEAR:
                  _loc4_ = new AssetAppearTransitionView(_loc4_);
                  break;
               case AssetTransitionConstants.TYPE_SLIDE:
                  _loc4_ = new AssetSlideTransitionView(_loc4_);
                  break;
               case AssetTransitionConstants.TYPE_BLUR:
                  _loc4_ = new AssetBlurTransitionView(_loc4_);
                  break;
               default:
                  _loc4_ = new AssetFlexTransitionView(_loc4_);
            }
            if(_loc4_ is AssetTransitionView)
            {
               AssetTransitionView(_loc4_).transition = _loc3_;
            }
         }
         return _loc4_ as DisplayObject;
      }
   }
}
