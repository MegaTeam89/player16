package anifire.playback
{
   import anifire.component.ProgressMonitor;
   import anifire.component.ThemeLoader;
   import anifire.constant.CcLibConstant;
   import anifire.constant.ServerConstants;
   import anifire.event.LoadMgrEvent;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import br.com.stimuli.loading.BulkLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class PlayerDataStock extends EventDispatcher
   {
       
      
      public var embedCredit:Class;
      
      private var _playerDataArray:Object;
      
      private var _playerDataIsDecryptedArray:Object;
      
      private var _filmXmlArray:Array;
      
      private var _themeXMLs:UtilHashArray;
      
      private var urlRequestArray:Array;
      
      private var bulkLoader:BulkLoader;
      
      private var _licensedSoundInfo:String = "";
      
      private var _themeListXmlArray:Array;
      
      private var _fontListXmlArray:Array;
      
      public function PlayerDataStock()
      {
         this.embedCredit = PlayerDataStock_embedCredit;
         this._filmXmlArray = new Array();
         this._themeListXmlArray = new Array();
         this._fontListXmlArray = new Array();
         super();
         this._playerDataArray = new Object();
         this._playerDataIsDecryptedArray = new Object();
         this._themeXMLs = new UtilHashArray();
      }
      
      public function getFilmXmlArray() : Array
      {
         return this._filmXmlArray;
      }
      
      private function addFilmXML(param1:XML) : void
      {
         this._filmXmlArray.push(param1);
      }
      
      public function getThemeXMLs() : UtilHashArray
      {
         return this._themeXMLs;
      }
      
      private function addPlayerData(param1:String, param2:Object, param3:Boolean = false) : void
      {
         this._playerDataArray[param1] = param2;
         this._playerDataIsDecryptedArray[param1] = param3;
      }
      
      public function initByHashArray(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         var _loc4_:int = 0;
         this.addFilmXML(param1.copy());
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            this.addPlayerData(param3.getKey(_loc4_),param3.getValueByIndex(_loc4_),true);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            this.addThemeXML(XML(param2.getValueByIndex(_loc4_)).copy());
            _loc4_++;
         }
      }
      
      private function addThemeXML(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc2_:String = UtilXmlInfo.getThemeIdFromThemeXML(param1);
         if(!this._themeXMLs.containsKey(_loc2_))
         {
            this._themeXMLs.push(_loc2_,param1);
         }
         else
         {
            _loc3_ = UtilXmlInfo.merge2ThemeXml(this._themeXMLs.getValueByKey(_loc2_) as XML,param1,_loc2_,"",false);
            this._themeXMLs.push(_loc2_,_loc3_);
         }
      }
      
      public function initByLoadMovieZip(param1:Array) : void
      {
         var urlRequest:URLRequest = null;
         var urlRequestArray:Array = param1;
         try
         {
            this.urlRequestArray = urlRequestArray;
            this.bulkLoader = new BulkLoader(new Date().toString() + Math.random().toString());
            for each(urlRequest in urlRequestArray)
            {
               this.bulkLoader.add(urlRequest,{"type":BulkLoader.TYPE_BINARY});
            }
            this.bulkLoader.addEventListener(BulkLoader.ERROR,this.onLoadMovieZipCompleted);
            this.bulkLoader.addEventListener(BulkLoader.COMPLETE,this.onLoadMovieZipCompleted);
            this.bulkLoader.addEventListener(BulkLoader.PROGRESS,this.onLoadMovieProgress);
            ProgressMonitor.getInstance().reset();
            ProgressMonitor.getInstance().addProgressEventDispatcher(this.bulkLoader);
            this.bulkLoader.start();
         }
         catch(e:TypeError)
         {
         }
         catch(e:Error)
         {
         }
      }
      
      public function destroy() : void
      {
         if(this.bulkLoader != null)
         {
            this.bulkLoader.removeAll();
         }
      }
      
      private function onLoadMovieProgress(param1:Event) : void
      {
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_PROGRESS,param1));
      }
      
      private function onLoadMovieZipCompleted(param1:Event) : void
      {
         var errorEvent:Event = null;
         var urlRequest:URLRequest = null;
         var chain_movie_ids_str:String = null;
         var movie_id_array:Array = null;
         var byteArray:ByteArray = null;
         var contentByteArr:ByteArray = null;
         var zipFile:ZipFile = null;
         var i:int = 0;
         var zipEntry:ZipEntry = null;
         var fileBytes:ByteArray = null;
         var j:int = 0;
         var ccZipEntry:ZipEntry = null;
         var ccZipFile:ZipFile = null;
         var ccFileBytes:ByteArray = null;
         var object:Object = null;
         var soundXML:XML = null;
         var ii:int = 0;
         var errorXML:XML = null;
         var animeXML:XML = null;
         var e:Event = param1;
         var hasEndMovie:Boolean = false;
         var isVisualRecord:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_VIDEO_RECORD_MODE) as String;
         if(isVisualRecord == "1")
         {
            chain_movie_ids_str = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CHAIN_MOVIE_ID);
            if(chain_movie_ids_str != null && chain_movie_ids_str != "")
            {
               movie_id_array = chain_movie_ids_str.split(",");
               if(movie_id_array[movie_id_array.length - 1] == ServerConstants.END_CREDIT_MOVIE_ID)
               {
                  hasEndMovie = true;
               }
            }
         }
         var bulkLoader:BulkLoader = e.target as BulkLoader;
         var returnCode:int = 0;
         var errorMsg:String = "";
         var errorCode:String = "";
         var currentCount:int = 1;
         if(e.type != BulkLoader.COMPLETE)
         {
            errorMsg += "Error loading file by url. The type of event returned is: " + e.toString() + ".";
            errorEvent = new PlayerEvent(PlayerEvent.ERROR_LOADING_MOVIE,"");
            this.dispatchEvent(errorEvent);
            return;
         }
         for each(urlRequest in this.urlRequestArray)
         {
            byteArray = bulkLoader.getBinary(urlRequest,true);
            returnCode = byteArray.readByte();
            contentByteArr = new ByteArray();
            byteArray.readBytes(contentByteArr);
            if(returnCode != 0)
            {
               errorMsg += "Downloading file completed with non-zero returnCode: " + returnCode + ". " + contentByteArr.toString();
               try
               {
                  errorXML = new XML(contentByteArr.toString());
                  errorCode = errorXML.child("code");
               }
               catch(e:Error)
               {
               }
            }
            if(errorMsg != "")
            {
               errorEvent = new PlayerEvent(PlayerEvent.ERROR_LOADING_MOVIE,errorCode);
               this.dispatchEvent(errorEvent);
               return;
            }
            zipFile = new ZipFile(contentByteArr);
            i = 0;
            while(i < zipFile.size)
            {
               zipEntry = zipFile.entries[i];
               if(zipEntry.name == PlayerConstant.FILM_XML_FILENAME)
               {
                  if(isVisualRecord == "1")
                  {
                     animeXML = new XML(zipFile.getInput(zipEntry).toString());
                     ii = 0;
                     while(ii < animeXML.child("sound").length())
                     {
                        soundXML = animeXML.child("sound")[ii];
                        if(soundXML.hasOwnProperty("info"))
                        {
                           this._licensedSoundInfo += soundXML.info.title + " - Author: " + soundXML.info.author + "\n";
                        }
                        ii++;
                     }
                  }
                  this.addFilmXML(new XML(zipFile.getInput(zipEntry).toString()));
                  if(this._licensedSoundInfo != "" && (currentCount == this.urlRequestArray.length - 1 && hasEndMovie == true || currentCount == this.urlRequestArray.length && hasEndMovie == false))
                  {
                     this.addCreditScreen();
                  }
               }
               else if(zipEntry.name.indexOf("ugc.char") > -1 && zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "xml")
               {
                  object = zipFile.getInput(zipEntry);
                  this.addPlayerData(zipEntry.name,object);
               }
               else if(zipEntry.name.indexOf("ugc.prop") > -1 && zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "xml")
               {
                  object = zipFile.getInput(zipEntry);
                  this.addPlayerData(zipEntry.name,object);
               }
               else if(zipEntry.name == "themelist.xml")
               {
                  object = zipFile.getInput(zipEntry);
                  this._themeListXmlArray.push(new XML(object.toString()));
               }
               else if(zipEntry.name == "fontlist.xml")
               {
                  object = zipFile.getInput(zipEntry);
                  this._fontListXmlArray.push(new XML(object.toString()));
               }
               else if(zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "xml")
               {
                  if(zipEntry.name == "ugc.xml")
                  {
                     object = zipFile.getInput(zipEntry);
                     this.addThemeXML(new XML(object.toString()));
                  }
               }
               else if(zipEntry.name.indexOf(CcLibConstant.NODE_LIBRARY) > -1 && zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "zip")
               {
                  fileBytes = zipFile.getInput(zipEntry);
                  ccZipFile = new ZipFile(fileBytes);
                  j = 0;
                  while(j < ccZipFile.size)
                  {
                     ccZipEntry = ccZipFile.entries[j];
                     if(ccZipEntry.name.substr(ccZipEntry.name.length - 3,3).toLowerCase() == "swf")
                     {
                        ccFileBytes = ccZipFile.getInput(ccZipEntry);
                        this.addPlayerData(ccZipEntry.name,ccFileBytes);
                     }
                     j++;
                  }
               }
               else if(zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "zip")
               {
                  fileBytes = zipFile.getInput(zipEntry);
                  ccZipFile = new ZipFile(fileBytes);
                  this.addPlayerData(zipEntry.name,UtilPlain.convertZipAsImagedataObject(ccZipFile));
               }
               else
               {
                  fileBytes = zipFile.getInput(zipEntry);
                  this.addPlayerData(zipEntry.name,fileBytes);
               }
               i++;
            }
            currentCount++;
         }
         this.loadAllThemeXmls();
      }
      
      private function loadMovieXml() : void
      {
         var _loc1_:URLRequest = new URLRequest("https://s3.amazonaws.com/schoolcloudfront/xml/movie/movie/33/0P0PDv0XN3zE/1269236357.gz.xml");
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc2_.addEventListener(Event.COMPLETE,this.onLoadMovieXmlComplete);
         _loc2_.load(_loc1_);
      }
      
      private function onLoadMovieXmlComplete(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onLoadMovieXmlComplete);
         if(param1.target is URLLoader)
         {
            this.addFilmXML(new XML(URLLoader(param1.target).data));
         }
         this.loadAllThemeXmls();
      }
      
      private function loadAllThemeXmls() : void
      {
         var _loc1_:UtilLoadMgr = null;
         var _loc2_:ThemeLoader = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:XML = null;
         if(this._themeListXmlArray && this._themeListXmlArray.length > 0)
         {
            _loc1_ = new UtilLoadMgr();
            _loc1_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onAllThemeXmlLoaded);
            _loc3_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < this._themeListXmlArray.length)
            {
               if(this._themeListXmlArray[_loc5_])
               {
                  for each(_loc6_ in this._themeListXmlArray[_loc5_].theme)
                  {
                     _loc4_ = _loc6_.toString();
                     if(_loc6_.toString() != "ugc" && _loc3_.indexOf(_loc4_) == -1)
                     {
                        _loc2_ = ThemeLoader.getThemeLoader(_loc4_);
                        _loc2_.addEventListener(Event.COMPLETE,this.onThemeXmlLoaded);
                        _loc1_.addEventDispatcher(_loc2_,Event.COMPLETE);
                        _loc2_.load(_loc4_);
                        _loc3_.push(_loc4_);
                     }
                  }
               }
               _loc5_++;
            }
            _loc1_.commit();
         }
         else
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_COMPLETE));
         }
      }
      
      private function onThemeXmlLoaded(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onThemeXmlLoaded);
         this.addThemeXML(ThemeLoader(param1.target).xml);
      }
      
      private function onAllThemeXmlLoaded(param1:Event) : void
      {
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_COMPLETE));
      }
      
      private function addCreditScreen() : void
      {
         var _loc1_:XML = new XML(<film copyable="0" duration="1" published="0" pshare="1">
				  <meta>
				    <title>credit screen</title>
				    <tag>credit screen</tag>
				    <hiddenTag/>
				    <desc></desc>
				    <mver>3</mver>
				  </meta>
				  <scene id="SCENE0" adelay="60" lock="Y" index="0">
				    <bg id="BG7" index="0">
				      <file>ugc.credit.png</file>
				    </bg>
				    <bubbleAsset id="BUBBLE8" index="1">
				      <x>234</x>
				      <y>85</y>
				      <bubble x="-119.1" y="32.3" w="418.3" h="25.7" rotate="0" type="BLANK">
				        <body rgb="16777215" alpha="1" linergb="0" tailx="180" taily="110"/>
				        <text rgb="13421772" font="Arial" size="16" align="center" bold="true" italic="false" embed="false">Music licensed under Creative Commons Share Alike:</text>
				        <url/>
				      </bubble>
				    </bubbleAsset>
				  </scene>
				</film>);
         var _loc2_:XML = <bubbleAsset id="BUBBLE9" index="2">
			      <x>233.5</x>
			      <y>123</y>
			      <bubble x="-152.3" y="27.1" w="484.8" h="40" rotate="0" type="BLANK">
			        <body rgb="16777215" alpha="1" linergb="0" tailx="180" taily="110"/>
			        <text rgb="13421772" font="Arial" size="18" align="center" bold="false" italic="false" embed="false"></text>
			        <url/>
			      </bubble>
			    </bubbleAsset>;
         _loc2_.bubble.text = this._licensedSoundInfo;
         var _loc3_:Array = this._licensedSoundInfo.split("\n");
         _loc2_.bubble.@h = 30 * _loc3_.length;
         _loc1_.scene.appendChild(_loc2_);
         var _loc4_:ByteArray = new this.embedCredit();
         this.addPlayerData("ugc.bg.credit.png",_loc4_);
         this.addFilmXML(_loc1_);
      }
      
      private function onInitPlayerDataStockDone(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitPlayerDataStockDone);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_COMPLETE));
      }
      
      public function getPlayerData(param1:String) : Object
      {
         return this._playerDataArray[param1] as Object;
      }
      
      public function decryptPlayerData(param1:String) : void
      {
         var _loc2_:UtilCrypto = null;
         if(!this._playerDataIsDecryptedArray[param1])
         {
            _loc2_ = new UtilCrypto();
            _loc2_.decrypt(this._playerDataArray[param1] as ByteArray);
            this._playerDataIsDecryptedArray[param1] = true;
         }
      }
   }
}
