package anifire.playback.asset.view
{
   import anifire.interfaces.IPlayerAssetView;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class AbstractAssetView extends MovieClip implements IPlayerAssetView
   {
       
      
      public function AbstractAssetView()
      {
         super();
      }
      
      public function set bundle(param1:DisplayObject) : void
      {
         this.addChild(param1);
      }
      
      public function get assetView() : DisplayObject
      {
         return this;
      }
   }
}
