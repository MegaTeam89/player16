package anifire.playerComponent
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class PlayerWatermark__embed_css__styles_player_watermark_new_swf_933208121 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function PlayerWatermark__embed_css__styles_player_watermark_new_swf_933208121()
      {
         this.dataClass = PlayerWatermark__embed_css__styles_player_watermark_new_swf_933208121_dataClass;
         super();
         initialWidth = 2400 / 20;
         initialHeight = 700 / 20;
      }
      
      override public function get movieClipData() : ByteArray
      {
         if(bytes == null)
         {
            bytes = ByteArray(new this.dataClass());
         }
         return bytes;
      }
   }
}
