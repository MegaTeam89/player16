package anifire.playback.transitions
{
   import anifire.constant.AnimeConstants;
   import anifire.playback.AnimeScene;
   import anifire.playback.GoTransition;
   import anifire.util.UtilPlain;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class SlideTransition extends GoTransition
   {
       
      
      private var effectee:DisplayObject;
      
      public function SlideTransition()
      {
         super();
      }
      
      override public function init(param1:XML, param2:AnimeScene, param3:Sprite) : Boolean
      {
         if(super.init(param1,param2,param3))
         {
            this.getBundle().x = -initPos.x;
            this.getBundle().y = -initPos.y;
            return true;
         }
         return false;
      }
      
      override public function play(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Number = NaN;
         if(param3 <= param1 + dur)
         {
            if(param1 <= param3 && this.getBundle().numChildren == 0)
            {
               _loc4_ = new BitmapData(AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
               _loc4_ = prevScene.endSceneCapture;
               prevSceneCapture.bitmapData = _loc4_;
               prevSceneCapture.x = AnimeConstants.SCREEN_X;
               prevSceneCapture.y = AnimeConstants.SCREEN_Y;
               transMovieBody.x = initPos.x;
               transMovieBody.y = initPos.y;
               if(!currSMC.contains(this.getBundle()))
               {
                  currSMC.addChild(this.getBundle());
                  this.getBundle().x = 0;
                  this.getBundle().y = 0;
               }
               this.getBundle().addChild(prevSceneCapture);
               this.getBundle().alpha = 1;
            }
            else if(param3 < param1 + dur)
            {
               transMovieBody.x = easeFx(param3 - param1,initPos.x,-initPos.x,dur - 1);
               transMovieBody.y = easeFx(param3 - param1,initPos.y,-initPos.y,dur - 1);
               this.getBundle().x = transMovieBody.x - initPos.x;
               this.getBundle().y = transMovieBody.y - initPos.y;
               if((_loc5_ = (param3 - param1) / ((dur - 1) / 2)) > 1)
               {
                  _loc5_ = Math.abs(_loc5_ - 2);
               }
            }
            else if(param3 == param1 + dur)
            {
               UtilPlain.removeAllSon(this.getBundle());
            }
         }
      }
   }
}
