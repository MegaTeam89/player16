package com.google.ads.instream.api
{
   public interface VastVideoAd extends VideoAd
   {
       
      
      function get nonLinearAdXMLList() : XMLList;
      
      function get adSystem() : String;
      
      function get description() : String;
      
      function get companionAdXMLList() : XMLList;
      
      function get wrappers() : Array;
      
      function get customClicks() : Array;
   }
}
