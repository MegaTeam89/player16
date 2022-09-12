package anifire.interfaces
{
   import anifire.core.CCManager;
   import anifire.util.UtilHashArray;
   import flash.events.EventDispatcher;
   
   public interface ICharacter
   {
       
      
      function get CCM() : CCManager;
      
      function get ver() : Number;
      
      function getColorByName(param1:String) : uint;
      
      function get eventDispatcher() : EventDispatcher;
      
      function insertColor(param1:UtilHashArray) : void;
      
      function addLibrary(param1:String, param2:String, param3:String) : void;
      
      function removeLibrary(param1:String) : void;
      
      function reloadSkin() : void;
      
      function speak(param1:Number) : void;
   }
}
