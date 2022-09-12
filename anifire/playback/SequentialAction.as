package anifire.playback
{
   import anifire.component.ActionSequence;
   import anifire.interfaces.ISequentialAction;
   import anifire.util.UtilPlain;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class SequentialAction extends Action implements ISequentialAction
   {
       
      
      private var _actionSequence:ActionSequence;
      
      public function SequentialAction()
      {
         super();
         this._actionSequence = new ActionSequence();
      }
      
      public function get actionSequence() : ActionSequence
      {
         return this._actionSequence;
      }
      
      override protected function setContent(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         super.setContent(param1);
         if(param1)
         {
            _loc2_ = UtilPlain.getCharacter(param1);
            if(_loc2_)
            {
               this._actionSequence.initByFrameLabels(_loc2_.currentLabels,_loc2_.totalFrames);
            }
         }
      }
      
      override protected function onEnterFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = null;
         if(this.getIsLoop())
         {
            _loc2_ = UtilPlain.getCharacter(this.getContent());
            if(_loc2_ && this._actionSequence.shouldChangeSubAction(_loc2_.currentFrame))
            {
               _loc2_.gotoAndPlay(this._actionSequence.getNextSubActionStartFrame(_loc2_.currentFrame));
            }
         }
      }
      
      override public function behaviourToClipFrame(param1:Number) : Number
      {
         return this._actionSequence.behaviourToClipFrame(param1);
      }
   }
}
