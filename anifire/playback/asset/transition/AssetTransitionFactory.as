package anifire.playback.asset.transition
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.AssetTransitionNode;
   
   public class AssetTransitionFactory
   {
       
      
      public function AssetTransitionFactory()
      {
         super();
      }
      
      public static function createTransition(param1:AssetTransitionNode) : AssetTransition
      {
         var _loc2_:AssetTransition = null;
         switch(String(param1.xml.@type))
         {
            case AssetTransitionConstants.TYPE_SLIDE:
               _loc2_ = new AssetSlideTransition();
               break;
            case AssetTransitionConstants.TYPE_WIPE:
               _loc2_ = new AssetWipeTransition();
               break;
            default:
               _loc2_ = new AssetTransition();
         }
         if(_loc2_)
         {
            _loc2_.init(param1);
         }
         return _loc2_;
      }
   }
}
