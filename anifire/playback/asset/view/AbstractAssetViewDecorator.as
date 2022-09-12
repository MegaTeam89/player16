package anifire.playback.asset.view
{
   import anifire.interfaces.IPlayback;
   import anifire.interfaces.IPlayerAssetView;
   import flash.display.DisplayObject;
   
   public class AbstractAssetViewDecorator extends AbstractAssetView implements IPlayback
   {
       
      
      private var _decorated:IPlayerAssetView;
      
      public function AbstractAssetViewDecorator(param1:IPlayerAssetView)
      {
         super();
         this._decorated = param1;
         this.addChild(param1 as DisplayObject);
      }
      
      public function playFrame(param1:uint, param2:uint) : void
      {
         if(this.decorated is IPlayback)
         {
            IPlayback(this.decorated).playFrame(param1,param2);
         }
      }
      
      protected function get decorated() : IPlayerAssetView
      {
         return this._decorated;
      }
      
      override public function set bundle(param1:DisplayObject) : void
      {
         if(this._decorated)
         {
            this._decorated.bundle = param1;
         }
      }
      
      override public function get assetView() : DisplayObject
      {
         if(this._decorated)
         {
            return this._decorated.assetView;
         }
         return null;
      }
      
      protected function getFactor(param1:uint, param2:uint) : Number
      {
         return param1 / param2;
      }
   }
}
