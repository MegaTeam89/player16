package anifire.util
{
   import anifire.constant.ServerConstants;
   
   public class UtilSite
   {
      
      public static const GOANIMATE:Number = 0;
      
      public static const CN:Number = 1;
      
      public static const DOMO:Number = 2;
      
      public static const SCHOOL:Number = 3;
      
      public static const YOUTUBE:Number = 4;
      
      public static const SKOLETUBE:Number = 12;
      
      public static const ED:Number = 14;
      
      private static var _id:Number = -1;
      
      private static var _apiServer:String;
       
      
      public function UtilSite()
      {
         super();
      }
      
      public static function get siteId() : uint
      {
         if(_id == -1)
         {
            if(String(Util.getFlashVar().getValueByKey("apiserver")).search("youtube") > 0)
            {
               _id = YOUTUBE;
            }
            else if(String(Util.getFlashVar().getValueByKey("apiserver")).search("skoletube") > 0)
            {
               _id = SKOLETUBE;
            }
            else
            {
               switch(Util.getFlashVar().getValueByKey("siteId"))
               {
                  case "8":
                     _id = CN;
                     break;
                  case "7":
                     _id = DOMO;
                     break;
                  case "11":
                  case "school":
                     _id = SCHOOL;
                     break;
                  case "14":
                     _id = ED;
                     break;
                  default:
                     _id = GOANIMATE;
               }
            }
         }
         return _id;
      }
      
      public static function get domainName() : String
      {
         if(_apiServer == null)
         {
            _apiServer = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER);
         }
         return _apiServer;
      }
      
      public static function get isDevelopmentSite() : Boolean
      {
         var _loc1_:String = UtilSite.domainName;
         if(_loc1_)
         {
            return _loc1_.search("staging") > 0 || _loc1_.search("demo") > 0 || _loc1_.search("alvin") > 0;
         }
         return true;
      }
   }
}
