package com.google.ads.instream.wrappers
{
   import com.google.ads.instream.api.FlashAsset;
   
   class FlashAssetWrapper extends Wrapper implements FlashAsset
   {
       
      
      function FlashAssetWrapper(param1:Object, param2:Object = null)
      {
         super(param1,param2);
      }
      
      public function get expandedHeight() : Number
      {
         return remoteInstance.expandedHeight;
      }
      
      public function get expandedWidth() : Number
      {
         return remoteInstance.expandedWidth;
      }
      
      public function get width() : Number
      {
         return remoteInstance.width;
      }
      
      public function get y() : Number
      {
         return remoteInstance.y;
      }
      
      public function get height() : Number
      {
         return remoteInstance.height;
      }
      
      public function set x(param1:Number) : void
      {
         remoteInstance.x = param1;
      }
      
      public function set y(param1:Number) : void
      {
         remoteInstance.y = param1;
      }
      
      public function get x() : Number
      {
         return remoteInstance.x;
      }
      
      public function get type() : String
      {
         return remoteInstance.type;
      }
      
      public function get frameRate() : Number
      {
         return remoteInstance.frameRate;
      }
   }
}
