package
{
   import anifire.component.AdSenseDisplay;
   import anifire.component.SharingPanel;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.playback.PlayerEvent;
   import anifire.playerComponent.OverlayControlPanel;
   import anifire.playerComponent.OverlayControlPanelEvent;
   import anifire.playerComponent.PreviewPlayer;
   import anifire.playerComponent.playerEndScreen.PlayerEndScreen;
   import anifire.playerComponent.playerEndScreen.PlayerEndScreenEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import anifire.util.UtilPreviewMovie;
   import anifire.util.UtilSharing;
   import flash.display.Loader;
   import flash.display.StageQuality;
   import flash.display.StageScaleMode;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.StatusEvent;
   import flash.external.ExternalInterface;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.Security;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.TextArea;
   import mx.core.Application;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.CursorManager;
   import mx.styles.CSSStyleDeclaration;
   
   public class player extends Application
   {
      
      private static const SHARE_OPTION_EMAIL:String = "email";
      
      private static const SHARE_OPTION_GOEMAIL:String = "goemail";
      
      private static const SHARE_OPTION_EMBED:String = "embed";
      
      private static const SHARE_OPTION_CREATE:String = "create";
      
      private static const SHARE_OPTION_SHARE:String = "share";
      
      private static const PLAYER_WIDTH:Number = 550;
      
      private static const PLAYER_HEIGHT:Number = 384;
      
      private static var _logger:ILogger = Log.getLogger("testing");
      
      {
         Security.allowDomain("*.goanimate.org","*.goanimate.com","goanimate.com","demo.cdn.goanimate.com","demo.goanimate.com","es.goanimate.com","fr.goanimate.com","de.goanimate.com","br.goanimate.com","tooncreator.cartoonnetworkhq.com","prelaunch.tooncreator.cartoonnetworkhq.com","staging.goanimate.org","staging.goanimate.com","cn.goanimate.com","goanimate.cartoonnetworkhq.org","lightspeed.goanimate.com","staging.school.goanimate.org","*.goanimate4schools.com","goanimate4schools.com","lightspeed.goanimate4schools.com","staging-school-cdn.com","lightspeed.youtube.goanimate.com","youtube.goanimate.org","youtube.goanimate.com","demo.youtube.goanimate.com","demo.cdn.youtube.goanimate.com","skoletube.goanimate.org","skoletube.goanimate.com","lightspeed.edplatform.goanimate.com","edplatform.goanimate.com","edplatform.goanimate.org","sandbox.edplatform.goanimate.com","sandbox.edplatform.goanimate.org");
      }
      
      private var _95458899debug:TextArea;
      
      private var _1840541266movieStage:Canvas;
      
      private var _271374569overlayControlPanel:OverlayControlPanel;
      
      private var _493601107playBut:Button;
      
      private var _269776073previewPlayer:PreviewPlayer;
      
      private var _173763403thumbContainer:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _gigyaConfigObj:Object = null;
      
      private var _overlayControlPanelTimeoutTicket:int = -1;
      
      private var adSense:AdSenseDisplay;
      
      private var _sceneNum:Number;
      
      private var connSend:LocalConnection;
      
      private var connReceive:LocalConnection;
      
      private var urlRequest:URLRequest;
      
      private var _embedplayer_height:Number;
      
      mx_internal var _player_StylesInit_done:Boolean = false;
      
      public function player()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Application,
            "events":{
               "applicationComplete":"___player_Application1_applicationComplete",
               "initialize":"___player_Application1_initialize",
               "preinitialize":"___player_Application1_preinitialize"
            },
            "stylesFactory":function():void
            {
               this.backgroundAlpha = 0;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "creationPolicy":"none",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"movieStage",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "percentWidth":100,
                           "percentHeight":100,
                           "creationPolicy":"auto",
                           "clipContent":false,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":PreviewPlayer,
                              "id":"previewPlayer",
                              "events":{
                                 "logo_click":"__previewPlayer_logo_click",
                                 "playhead_user_start_play":"__previewPlayer_playhead_user_start_play",
                                 "info_load_complete":"__previewPlayer_info_load_complete"
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":TextArea,
                     "id":"debug",
                     "stylesFactory":function():void
                     {
                        this.borderStyle = "none";
                        this.backgroundAlpha = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":550,
                           "height":354,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"thumbContainer",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"playBut",
                     "events":{"click":"__playBut_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "buttonMode":true,
                           "horizontalCenter":0,
                           "verticalCenter":0,
                           "styleName":"btnPlayBig"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":OverlayControlPanel,
                     "id":"overlayControlPanel",
                     "events":{
                        "create_click":"__overlayControlPanel_create_click",
                        "email_click":"__overlayControlPanel_email_click",
                        "share_click":"__overlayControlPanel_share_click"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":365,
                           "y":10,
                           "visible":false
                        };
                     }
                  })]
               };
            }
         });
         this.adSense = new AdSenseDisplay();
         this._sceneNum = new Number();
         this.connSend = new LocalConnection();
         this.connReceive = new LocalConnection();
         super();
         mx_internal::_document = this;
         this.layout = "absolute";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.creationPolicy = "none";
         this.addEventListener("applicationComplete",this.___player_Application1_applicationComplete);
         this.addEventListener("initialize",this.___player_Application1_initialize);
         this.addEventListener("preinitialize",this.___player_Application1_preinitialize);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundAlpha = 0;
         };
         mx_internal::_player_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function loadClientLocale() : void
      {
         Util.loadClientLocale("player",this.onClientLocaleComplete);
      }
      
      private function onClientLocaleComplete(param1:Event) : void
      {
         this.loadClientTheme();
      }
      
      private function initConn() : void
      {
         this.connSend.allowDomain("*");
         this.connSend.addEventListener(StatusEvent.STATUS,this.onStatus);
         this.connReceive.allowDomain("*");
         this.connReceive.client = this;
         try
         {
            this.connReceive.connect("taskConnection2");
         }
         catch(error:ArgumentError)
         {
         }
      }
      
      private function LCStudioGetSceneNum() : void
      {
         this.connSend.send("taskConnection","LCHandlerInitial","success");
      }
      
      private function onStatus(param1:StatusEvent) : void
      {
         switch(param1.level)
         {
            case "error":
         }
      }
      
      public function LCHandlerScenePreview(param1:String) : void
      {
         this.getSceneNum(Number(param1));
         this.connSend = new LocalConnection();
         this.connReceive = new LocalConnection();
      }
      
      private function initAdSense() : void
      {
         this.addChild(this.adSense);
         this.adSense.addEventListener("ADS_COMPELTED",this.previewPlayer.adSenseComplete);
         this.adSense.addEventListener("ADS_FINISH_LOADING",this.previewPlayer.adSenseStarted);
         this.previewPlayer.loadingText.y = this.adSense.bottomLabelY;
         this.previewPlayer.googleAdsAttribution.y = this.adSense.topLabelY;
         this.previewPlayer.googleAdsAttribution.x = this.adSense.topLabelRight;
         this.previewPlayer.addEventListener("info_load_complete",this.onInfoLoadComplete);
         this.adSense.addEventListener("ADS_ERROR",this.setGoogleAdsAttributionXAndY);
      }
      
      private function onInfoLoadComplete(param1:Event) : void
      {
         this.adSense.loadAdSense(this.previewPlayer.getMovieDuration());
      }
      
      private function setGoogleAdsAttributionXAndY(param1:Event) : void
      {
         param1.target.removeEventListener("ADS_ERROR",this.setGoogleAdsAttributionXAndY);
         this.previewPlayer.googleAdsAttribution.x = 400;
         this.previewPlayer.googleAdsAttribution.y = 14;
      }
      
      public function get cfg() : Object
      {
         var embedCode:String = null;
         var plainHtmlEmbedCode:String = null;
         var getVariable:URLVariables = null;
         var urlVar:URLVariables = null;
         var movieOwnerName:String = null;
         var movieOwnerId:String = null;
         var movieLicenseId:String = null;
         var chainMovieIds:String = null;
         var movieId:String = null;
         var movieTitle:String = null;
         var movieDesc:String = null;
         var userId:String = null;
         var apiServer:String = null;
         var appCode:String = null;
         var movieThumbnailUrl:String = null;
         var smallMovieThumbnailUrl:String = null;
         var fbAppUrl:String = null;
         var isCopyable:Boolean = false;
         var isPublished:Boolean = false;
         var client_theme_code:String = null;
         var client_language_code:String = null;
         var isPrivateShared:Boolean = false;
         var cfg:Object = null;
         if(this._gigyaConfigObj == null)
         {
            getVariable = new URLVariables();
            urlVar = new URLVariables();
            Util.addFlashVarsToURLvar(urlVar);
            movieOwnerName = urlVar["movieOwner"];
            movieOwnerId = !!urlVar["movieOwnerId"] ? urlVar["movieOwnerId"] : null;
            movieLicenseId = !!urlVar[ServerConstants.FLASHVAR_MOVIE_LICENSE_ID] ? urlVar[ServerConstants.FLASHVAR_MOVIE_LICENSE_ID] : "";
            chainMovieIds = !!urlVar[ServerConstants.FLASHVAR_CHAIN_MOVIE_ID] ? urlVar[ServerConstants.FLASHVAR_CHAIN_MOVIE_ID] : "";
            movieId = !!urlVar["movieId"] ? urlVar["movieId"] : "";
            if(movieId == "")
            {
               movieId = FlexGlobals.topLevelApplication.parameters["movieId"];
            }
            movieTitle = !!urlVar["movieTitle"] ? urlVar["movieTitle"] : "";
            movieDesc = !!urlVar["movieDesc"] ? urlVar["movieDesc"] : "";
            userId = !!urlVar["userId"] ? urlVar["userId"] : "";
            apiServer = urlVar["apiserver"];
            appCode = urlVar["appCode"];
            movieThumbnailUrl = !!urlVar["thumbnailURL"] ? Util.getMovieThumbnailUrl() : "";
            smallMovieThumbnailUrl = movieThumbnailUrl.replace("L.jpg",".jpg");
            fbAppUrl = urlVar["fb_app_url"];
            isCopyable = !!urlVar[ServerConstants.FLASHVAR_IS_COPYABLE] ? (urlVar[ServerConstants.FLASHVAR_IS_COPYABLE] == "1" ? true : false) : false;
            isPublished = true;
            client_theme_code = urlVar[ServerConstants.FLASHVAR_CLIENT_THEME_CODE];
            client_language_code = urlVar[ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE];
            if(!UtilPlain.get_isMoviePublished_by_flashVar(urlVar["isPublished"],urlVar["is_private_shared"]))
            {
               isPublished = false;
            }
            isPrivateShared = !!UtilPlain.get_isMoviePrivateShare_by_flashVar(urlVar["is_private_shared"]) ? true : false;
            if(UtilLicense.isBoxEnvironment())
            {
               embedCode = UtilSharing.buildBoxEmbedTag(movieOwnerName,movieId,movieTitle,movieDesc,userId,apiServer,appCode,movieThumbnailUrl,fbAppUrl,isCopyable,isPublished,isPrivateShared,"gigyaembed",movieOwnerId,movieLicenseId,client_theme_code,client_language_code,chainMovieIds);
            }
            else
            {
               embedCode = UtilSharing.buildEmbedTag(movieOwnerName,movieId,movieTitle,movieDesc,userId,apiServer,appCode,movieThumbnailUrl,fbAppUrl,isCopyable,isPublished,isPrivateShared,"gigyaembed",movieOwnerId,movieLicenseId,client_theme_code,client_language_code,chainMovieIds);
            }
            if(UtilLicense.isBoxEnvironment())
            {
               plainHtmlEmbedCode = UtilSharing.buildBoxPlainHtmlEmbedTag(movieId,movieTitle,smallMovieThumbnailUrl,userId,"gigyaembed",movieOwnerName,movieOwnerId);
            }
            else
            {
               plainHtmlEmbedCode = UtilSharing.buildPlainHtmlEmbedTag(movieId,movieTitle,smallMovieThumbnailUrl,userId,"gigyaembed",movieOwnerName,movieOwnerId);
            }
            if(userId != "")
            {
               getVariable["uid"] = userId;
            }
            cfg = new Object();
            this._gigyaConfigObj = cfg;
            cfg["width"] = 500;
            cfg["height"] = 180;
            cfg["showCloseButton"] = "true";
            cfg["contentIsLayout"] = "false";
            cfg["advancedTracking"] = "true";
            cfg["partner"] = ServerConstants.GIGYA_ACCOUNT_ID;
            cfg["UIConfig"] = "<config><display showDesktop=\"true\" showEmail=\"false\" useTransitions=\"true\" showBookmark=\"true\" codeBoxHeight=\"auto\" showCodeBox=\"false\" showCloseButton=\"true\" bulletinChecked=\"false\" networksToHide=\"facebook, myspace\" networksWithCodeBox=\"\" networksToShow=\"friendster, orkut, bebo, tagged, hi5, livespaces, piczo, freewebs, livejournal, blackplanet, myyearbook, wordpress, vox, typepad, xanga, multiply, igoogle, netvibes, pageflakes, migente, *\"></display><body corner-roundness=\"8;8;8;8\"><background frame-color=\"Transparent\" gradient-color-begin=\"#353535\" gradient-color-end=\"#606060\"></background><controls size=\"11\" bold=\"true\"><snbuttons type=\"textUnder\" frame-color=\"#6D0000\" background-color=\"#FFFFFF\" over-background-color=\"#FFFFFF\" color=\"#CACACA\" corner-roundness=\"0;8;8;8\" gradient-color-begin=\"#8A8A8A\" gradient-color-end=\"#000000\" font=\"Arial\" size=\"11\" bold=\"false\" over-gradient-color-begin=\"#AAAAAA\" over-gradient-color-end=\"#000000\" over-color=\"#F4F4F4\" down-color=\"#000000\"><more frame-color=\"Transparent\"></more></snbuttons><textboxes frame-color=\"#000000\" color=\"#AAAAAA\" corner-roundness=\"0;0;0;0\" gradient-color-begin=\"#202020\" gradient-color-end=\"#0B0B0B\" font=\"Arial\" bold=\"false\"><codeboxes color=\"#EAEAEA\" frame-color=\"#8A8A8A\" gradient-color-begin=\"#000000\" font=\"Arial\" bold=\"false\"></codeboxes><inputs frame-color=\"#6D0000\"></inputs><dropdowns frame-color=\"#6D0000\" handle-gradient-color-begin=\"#B60000\" handle-gradient-color-end=\"#6D0000\" handle-over-gradient-color-begin=\"#FF0000\" handle-over-gradient-color-end=\"#DA0000\" handle-down-gradient-color-begin=\"#FF0000\" handle-down-gradient-color-end=\"#6D0000\" background-color=\"#6D0000\" gradient-color-begin=\"#000000\" font=\"Arial\" bold=\"false\"></dropdowns></textboxes><buttons frame-color=\"#FF0000\" gradient-color-begin=\"#FF2424\" gradient-color-end=\"#6D0000\" color=\"#F4F4F4\" corner-roundness=\"0;8;8;8\" font=\"Arial\" size=\"10\" bold=\"false\" down-frame-color=\"#000000\" over-gradient-color-begin=\"#DA0000\" down-gradient-color-begin=\"#910000\" over-gradient-color-end=\"#DA0000\" down-gradient-color-end=\"#FF0000\" over-color=\"#F4F4F4\"><post-buttons gradient-color-begin=\"#FF4949\" gradient-color-end=\"#6D0000\"></post-buttons></buttons><listboxes corner-roundness=\"5;5;5;5\"></listboxes><servicemarker gradient-color-begin=\"#DA0000\" gradient-color-end=\"#DA0000\"></servicemarker></controls><texts color=\"#FFFFFF\" font=\"Arial\" size=\"10\"><privacy color=\"#959595\" size=\"11\"></privacy><headers size=\"11\" bold=\"true\"></headers><labels size=\"11\" bold=\"true\"></labels><messages color=\"#D5D5D5\" frame-thickness=\"0\" corner-roundness=\"0;0;0;0\" gradient-color-begin=\"#B60000\" gradient-color-end=\"#000000\" size=\"11\" bold=\"true\"></messages><links color=\"#DFDFDF\" underline=\"false\" size=\"11\" bold=\"true\" over-color=\"#FFFFFF\"></links></texts></body></config>";
            cfg["defaultContent"] = embedCode;
            getVariable["utm_source"] = "gigyabookmark";
            getVariable["utm_campaign"] = UtilLicense.boxCustomerID;
            cfg["defaultBookmarkURL"] = !!UtilLicense.isBoxEnvironment() ? UtilSharing.getBoxMovieUrl(movieId,getVariable) : UtilSharing.getMovieUrl(movieId,getVariable);
            cfg["widgetTitle"] = UtilLicense.getCurrentLicensorDisplayName() + ": " + movieTitle;
            cfg["friendsterContent"] = plainHtmlEmbedCode;
            cfg["bloggerContent"] = plainHtmlEmbedCode;
            cfg["hi5Content"] = plainHtmlEmbedCode;
            cfg["wordpressContent"] = plainHtmlEmbedCode;
            cfg["onPostProfile"] = function(param1:Object):void
            {
            };
            cfg["onLoad"] = function(param1:Object):void
            {
            };
            cfg["onClose"] = function(param1:Object):void
            {
               onGigyaClose();
            };
         }
         return this._gigyaConfigObj;
      }
      
      private function loadClientTheme() : void
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_THEME_COLOR);
         var _loc3_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE) || "en_US";
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         _loc4_.push("player");
         _loc5_.push(_loc3_);
         _loc6_.push(_loc2_);
         _loc4_.push("player");
         _loc5_.push("lang_common");
         _loc6_.push(_loc2_);
         Util.loadClientTheming(_loc4_,_loc5_,_loc6_,this.onClientThemeComplete);
      }
      
      private function onClientThemeComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onClientThemeComplete);
         createComponentsFromDescriptors();
      }
      
      private function onGigyaClose() : void
      {
         UtilSharing.closeObjectWhenGigyaClose();
      }
      
      public function jsShare(param1:String, param2:Boolean = true) : String
      {
         this.playBut.visible = false;
         this.deleteThumbnail();
         this.previewPlayer.showSharingPanel(param2);
         if(param1 == SHARE_OPTION_EMAIL)
         {
            this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_EMAIL);
         }
         else if(param1 == SHARE_OPTION_EMBED)
         {
            this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_EMBED);
         }
         else if(param1 == SHARE_OPTION_GOEMAIL)
         {
            this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_GOEMAIL);
         }
         else if(param1 == SHARE_OPTION_CREATE)
         {
            this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_CREATE);
         }
         else if(param1 == SHARE_OPTION_SHARE)
         {
            this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_SHARE);
         }
         return "0{}";
      }
      
      public function addContact(param1:String, param2:Boolean = false) : void
      {
         this.jsShare("email",false);
         this.callLater(this.previewPlayer.endScreen._sharingPanel.addContact,[param1,param2]);
      }
      
      public function shareMovie() : void
      {
         this.previewPlayer.pause();
         this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_SHARE);
      }
      
      public function emailMovie() : void
      {
         this.previewPlayer.pause();
         this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_EMAIL);
      }
      
      public function embedMovie() : void
      {
         this.previewPlayer.pause();
         this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_EMBED);
      }
      
      public function createMovie() : void
      {
         this.previewPlayer.pause();
         this.previewPlayer.endScreen.showSharingPanel(SharingPanel.TAB_CREATE);
      }
      
      public function destroy() : void
      {
         this.previewPlayer.destroy();
      }
      
      private function traceLocal(param1:String) : void
      {
         this.debug.text += param1 + "\n";
      }
      
      private function get playerEndScreen() : PlayerEndScreen
      {
         return this.previewPlayer.endScreen;
      }
      
      private function getServerUrl() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         return _loc1_.getValueByKey("fb_app_url");
      }
      
      private function getMovieId() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         return _loc1_.getValueByKey("movieId");
      }
      
      private function updateSize() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:UtilHashArray = Util.getFlashVar();
         if(_loc1_.getValueByKey(ServerConstants.FLASHVAR_IS_WIDE) == "1")
         {
            this.previewPlayer.switchToWideScreen();
         }
         else
         {
            this.previewPlayer.switchToNormalScreen();
         }
         if(Util.isVideoRecording())
         {
            this.previewPlayer.screenMode = PreviewPlayer.RECORDING_SCREEN_MODE;
            _loc3_ = Number(_loc1_.getValueByKey(ServerConstants.FLASHVAR_CUSTOM_PLAYER_WIDTH));
            _loc4_ = Number(_loc1_.getValueByKey(ServerConstants.FLASHVAR_CUSTOM_PLAYER_HEIGHT));
            if(_loc3_ <= 0 || _loc4_ <= 0)
            {
               _loc3_ = AnimeConstants.CONVERT_TO_AVI_WIDTH;
               _loc4_ = AnimeConstants.CONVERT_TO_AVI_HEIGHT;
            }
            this.width = _loc3_;
            this.height = _loc4_;
         }
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.PARAM_ISEMBED_ID);
         if(_loc2_ == "1")
         {
            this.previewPlayer.screenMode = PreviewPlayer.FULL_SCREEN_MODE;
         }
      }
      
      private function onCreationCompleted(... rest) : void
      {
         var autoStart:Boolean = false;
         var movie_id_array:Array = null;
         var chain_movie_id:String = null;
         var previewDataXml:String = null;
         var filmXmlArray:Array = null;
         var imageData:UtilHashArray = null;
         var themeXmlArr:UtilHashArray = null;
         var filmXml:XML = null;
         var isGmailRefresh:String = null;
         var Args:Array = rest;
         Util.initLog();
         this.stage.scaleMode = StageScaleMode.NO_SCALE;
         this.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.fullScreenHandler);
         var flashVars:UtilHashArray = Util.getFlashVar(this);
         var chainUrlRequestArray:Array = new Array();
         this.urlRequest = UtilNetwork.getGetMovieRequest(flashVars,flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String);
         var chain_movie_ids_str:String = flashVars.getValueByKey(ServerConstants.FLASHVAR_CHAIN_MOVIE_ID);
         if(chain_movie_ids_str != null && chain_movie_ids_str != "")
         {
            movie_id_array = chain_movie_ids_str.split(",");
            for each(chain_movie_id in movie_id_array)
            {
               chainUrlRequestArray.push(UtilNetwork.getGetMovieRequest(flashVars,chain_movie_id));
            }
         }
         else
         {
            chainUrlRequestArray.push(this.urlRequest);
         }
         this.updateSize();
         if(flashVars.getValueByKey("isInitFromExternal") == "1")
         {
            previewDataXml = ExternalInterface.call("retrievePreviewPlayerData");
            this.LCStudioGetSceneNum();
            filmXmlArray = new Array();
            imageData = new UtilHashArray();
            themeXmlArr = new UtilHashArray();
            UtilPreviewMovie.deserializePreviewMovieData(previewDataXml,filmXmlArray,imageData,themeXmlArr);
            filmXml = filmXmlArray[0] as XML;
            this.previewPlayer.initAndPreview(filmXml,imageData,themeXmlArr);
         }
         else
         {
            this.previewPlayer.init(this.urlRequest,chainUrlRequestArray,flashVars);
         }
         this.initEndScreen();
         this.initOverlayControlPanel();
         if(flashVars.containsKey(ServerConstants.FLASHVAR_AUTOSTART))
         {
            if(flashVars.getValueByKey(ServerConstants.FLASHVAR_AUTOSTART) as String == "1")
            {
               autoStart = true;
            }
            else
            {
               autoStart = false;
            }
         }
         else
         {
            autoStart = false;
         }
         if(flashVars.containsKey(ServerConstants.FLASHVAR_SHOWSHARE) && flashVars.getValueByKey(ServerConstants.FLASHVAR_SHOWSHARE) == "1")
         {
            autoStart = false;
            this.jsShare(flashVars.getValueByKey(ServerConstants.FLASHVAR_SHOWSHARE) as String);
         }
         if(flashVars.getValueByKey(ServerConstants.PARAM_ISEMBED_ID) as String == "0")
         {
            isGmailRefresh = ExternalInterface.call("get_cookie","gmaillogin");
            autoStart = isGmailRefresh == "1" ? false : Boolean(autoStart);
            if(autoStart)
            {
               this.previewPlayer.play();
            }
            ExternalInterface.addCallback("addContact",this.addContact);
            ExternalInterface.addCallback("share",this.jsShare);
            this.previewPlayer.turnOnLogo(false);
         }
         else
         {
            if(autoStart)
            {
               this.previewPlayer.play();
            }
            this.previewPlayer.turnOnLogo(true);
            this._embedplayer_height = this.height;
         }
         var item:ContextMenuItem = new ContextMenuItem(UtilDict.toDisplay("player","player_menu"));
         var doGoToGoanimate:Function = function(param1:Event):void
         {
            navigateToGoanimate("right_click_menu");
         };
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,doGoToGoanimate);
         var contextMenu:ContextMenu = new ContextMenu();
         contextMenu.customItems.push(item);
         contextMenu.hideBuiltInItems();
         this.contextMenu = contextMenu;
         this.traceLocal("url: " + this.urlRequest.url);
         this.traceLocal("variables: " + this.urlRequest.data.toString());
         if(flashVars.getValueByKey(ServerConstants.PARAM_ISSLIDE) == "1")
         {
            this.stage.quality = StageQuality.MEDIUM;
         }
      }
      
      private function fullScreenHandler(param1:FullScreenEvent) : void
      {
         if(param1.fullScreen)
         {
            this.previewPlayer.width = this.stage.fullScreenWidth;
            this.previewPlayer.height = this.stage.fullScreenHeight;
         }
         else
         {
            this.previewPlayer.width = this.width;
            this.previewPlayer.height = this.height;
         }
         dispatchEvent(param1);
      }
      
      private function startScenePreview(param1:Number = 0) : void
      {
         if(param1 && param1 > 0)
         {
            this.previewPlayer.loadScenePreview(param1);
         }
      }
      
      private function getSceneNum(param1:Number = 0) : void
      {
         this._sceneNum = param1;
         if(param1 && param1 > 0)
         {
            this.previewPlayer.turnOnPauseFirstStart(param1);
         }
      }
      
      private function loadSceneExternally(param1:Event) : void
      {
         ExternalInterface.call("scenePreview");
      }
      
      private function loadSceneInternally(param1:Event) : void
      {
         this.startScenePreview(this._sceneNum);
      }
      
      private function callSceneNum() : void
      {
         ExternalInterface.call("callSceneNum");
      }
      
      private function onInitialize(... rest) : void
      {
         this.loadThumbnail();
      }
      
      private function doGoToMoviePage(param1:Event) : void
      {
         this.navigateToGoanimate("embed-logo");
      }
      
      private function navigateToGoanimate(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["utm_source"] = param1;
         var _loc3_:URLRequest = new URLRequest(ServerConstants.HOST_PATH + "?" + _loc2_.toString());
         navigateToURL(_loc3_,"_blank");
      }
      
      private function loadThumbnail() : void
      {
         var flashVar:UtilHashArray = null;
         var shouldLoadThumbnail:Boolean = false;
         var url:String = null;
         var urlReq:URLRequest = null;
         var loader:Loader = null;
         flashVar = Util.getFlashVar();
         if(!flashVar.containsKey(ServerConstants.FLASHVAR_THUMBNAIL))
         {
            shouldLoadThumbnail = false;
         }
         else
         {
            url = flashVar.getValueByKey(ServerConstants.FLASHVAR_THUMBNAIL) as String;
            if(url == null || url == "")
            {
               shouldLoadThumbnail = false;
            }
            else
            {
               shouldLoadThumbnail = true;
            }
         }
         if(shouldLoadThumbnail)
         {
            urlReq = new URLRequest(Util.getMovieThumbnailUrl());
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadThumbnailComplete);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadThumbnailComplete);
            try
            {
               loader.load(urlReq);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function initOverlayControlPanel() : void
      {
         this.previewPlayer.addEventListener(PlayerEvent.BUFFER_READY_WHEN_MOVIE_START,this.onBufferReadyWhenMovieStart);
         this.previewPlayer.addEventListener(PlayerEvent.PLAYHEAD_MOVIE_END,this.onMovieEnd);
         this.previewPlayer.addEventListener(PlayerEvent.LOAD_MOVIE_PROGRESS,this.onLoadingMovie);
         this.previewPlayer.addEventListener(PlayerEvent.PLAYHEAD_USER_GOTOANDPAUSE,this.onMouseMove);
         this.previewPlayer.addEventListener(PlayerEvent.PLAYHEAD_USER_PAUSE,this.onMouseMove);
         this.previewPlayer.addEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.onMouseMove);
      }
      
      private function onLoadingMovie(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadingMovie);
         if(UtilLicense.playerOverlayControlPanelEnabled)
         {
            this.overlayControlPanel.show();
         }
      }
      
      private function onBufferReadyWhenMovieStart(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onBufferReadyWhenMovieStart);
         this.overlayControlPanel.hide();
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMovieEnd(param1:Event) : void
      {
         this.overlayControlPanel.hide();
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseMove(param1:Event) : void
      {
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         if(UtilLicense.playerOverlayControlPanelEnabled)
         {
            this.overlayControlPanel.show();
         }
         if(this._overlayControlPanelTimeoutTicket >= 0)
         {
            clearTimeout(this._overlayControlPanelTimeoutTicket);
         }
         this._overlayControlPanelTimeoutTicket = setTimeout(this.overlayControlPanel.hide,2000);
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function initEndScreen() : void
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_IS_COPYABLE);
         var _loc3_:String = _loc1_.getValueByKey("showButtons");
         var _loc4_:* = _loc1_.getValueByKey("isPreview") == "1";
         var _loc5_:* = Util.getFlashVar(this).getValueByKey("isTemplate") == "1";
         if(_loc4_ || _loc5_)
         {
            this.playerEndScreen.isPreviewMode = true;
            this.previewPlayer.playerControl.fullScreenControl.fullBut.but1.visible = false;
            this.previewPlayer.playerControl.fullScreenControl.fullBut.but2.visible = false;
            this.overlayControlPanel.scaleX = this.overlayControlPanel.scaleY = 0;
         }
         this.playerEndScreen.addEventListener(PlayerEndScreenEvent.BTN_NEW_ANIMATION_CLICK,this.onNewAnimationClick);
         this.playerEndScreen.addEventListener(PlayerEndScreenEvent.BTN_SHARE_CLICK,this.onShareClick);
         this.playerEndScreen.addEventListener(PlayerEndScreenEvent.BTN_CHANGE_CLICK,this.onChangeClick);
      }
      
      private function deleteThumbnail() : void
      {
         UtilPlain.removeAllSon(this.thumbContainer);
         this.thumbContainer.visible = false;
      }
      
      private function onLoadThumbnailComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:UIComponent = null;
         if(param1.type == Event.COMPLETE)
         {
            _loc2_ = param1.target.loader as Loader;
            _loc2_.width = this.width;
            _loc2_.height = this.height;
            _loc3_ = new UIComponent();
            _loc3_.addChild(_loc2_);
            this.thumbContainer.addChild(_loc3_);
         }
      }
      
      private function onPlayButClick(param1:Event) : void
      {
         this.playBut.visible = false;
         this.previewPlayer.play();
         this.deleteThumbnail();
      }
      
      private function onPreviewPlayerStartPlay(param1:Event) : void
      {
         this.playBut.visible = false;
         this.deleteThumbnail();
      }
      
      private function onNewAnimationClick(param1:PlayerEndScreenEvent) : void
      {
         var _loc2_:Object = param1.eventCreator;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(_loc2_ is PlayerEndScreen)
         {
            _loc3_ = this.getServerUrl();
            _loc4_ = this.getMovieId();
         }
         if(_loc3_ != null && _loc3_ != "" && _loc4_ != null && _loc4_ != "")
         {
            if(_loc3_.indexOf("facebook.com") == -1)
            {
               _loc3_ = "http://goanimate.com/";
               navigateToURL(new URLRequest(_loc3_ + "studio/?utm_source=facebook"),"_top");
            }
            else
            {
               navigateToURL(new URLRequest(_loc3_ + "studio/"),"_top");
            }
            CursorManager.setBusyCursor();
         }
      }
      
      private function onShareClick(param1:PlayerEndScreenEvent) : void
      {
         var _loc2_:Object = param1.eventCreator;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(_loc2_ is PlayerEndScreen)
         {
            _loc3_ = this.getServerUrl();
            _loc4_ = this.getMovieId();
         }
         if(_loc3_ != null && _loc3_ != "" && _loc4_ != null && _loc4_ != "")
         {
            navigateToURL(new URLRequest(_loc3_ + "share/" + _loc4_),"_top");
            CursorManager.setBusyCursor();
         }
      }
      
      private function onChangeClick(param1:PlayerEndScreenEvent) : void
      {
         var _loc2_:Object = param1.eventCreator;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(_loc2_ is PlayerEndScreen)
         {
            _loc3_ = this.getServerUrl();
            _loc4_ = this.getMovieId();
         }
         if(_loc3_ != null && _loc3_ != "" && _loc4_ != null && _loc4_ != "")
         {
            navigateToURL(new URLRequest(_loc3_ + "studio/copy/" + _loc4_),"_top");
            CursorManager.setBusyCursor();
         }
      }
      
      public function ___player_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.onCreationCompleted();
      }
      
      public function ___player_Application1_initialize(param1:FlexEvent) : void
      {
         this.onInitialize(param1);
      }
      
      public function ___player_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.loadClientLocale();
         this.initConn();
      }
      
      public function __previewPlayer_logo_click(param1:PlayerEvent) : void
      {
         this.doGoToMoviePage(param1);
      }
      
      public function __previewPlayer_playhead_user_start_play(param1:PlayerEvent) : void
      {
         this.onPreviewPlayerStartPlay(param1);
      }
      
      public function __previewPlayer_info_load_complete(param1:Event) : void
      {
         this.loadSceneInternally(param1);
      }
      
      public function __playBut_click(param1:MouseEvent) : void
      {
         this.onPlayButClick(param1);
      }
      
      public function __overlayControlPanel_create_click(param1:OverlayControlPanelEvent) : void
      {
         this.jsShare(SHARE_OPTION_CREATE);
      }
      
      public function __overlayControlPanel_email_click(param1:OverlayControlPanelEvent) : void
      {
         this.jsShare(SHARE_OPTION_EMAIL);
      }
      
      public function __overlayControlPanel_share_click(param1:OverlayControlPanelEvent) : void
      {
         this.jsShare(SHARE_OPTION_SHARE);
      }
      
      mx_internal function _player_StylesInit() : void
      {
         var _loc1_:CSSStyleDeclaration = null;
         var _loc2_:Array = null;
         if(mx_internal::_player_StylesInit_done)
         {
            return;
         }
         mx_internal::_player_StylesInit_done = true;
         styleManager.initProtoChainRoots();
      }
      
      [Bindable(event="propertyChange")]
      public function get debug() : TextArea
      {
         return this._95458899debug;
      }
      
      public function set debug(param1:TextArea) : void
      {
         var _loc2_:Object = this._95458899debug;
         if(_loc2_ !== param1)
         {
            this._95458899debug = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"debug",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieStage() : Canvas
      {
         return this._1840541266movieStage;
      }
      
      public function set movieStage(param1:Canvas) : void
      {
         var _loc2_:Object = this._1840541266movieStage;
         if(_loc2_ !== param1)
         {
            this._1840541266movieStage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieStage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get overlayControlPanel() : OverlayControlPanel
      {
         return this._271374569overlayControlPanel;
      }
      
      public function set overlayControlPanel(param1:OverlayControlPanel) : void
      {
         var _loc2_:Object = this._271374569overlayControlPanel;
         if(_loc2_ !== param1)
         {
            this._271374569overlayControlPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"overlayControlPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playBut() : Button
      {
         return this._493601107playBut;
      }
      
      public function set playBut(param1:Button) : void
      {
         var _loc2_:Object = this._493601107playBut;
         if(_loc2_ !== param1)
         {
            this._493601107playBut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playBut",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get previewPlayer() : PreviewPlayer
      {
         return this._269776073previewPlayer;
      }
      
      public function set previewPlayer(param1:PreviewPlayer) : void
      {
         var _loc2_:Object = this._269776073previewPlayer;
         if(_loc2_ !== param1)
         {
            this._269776073previewPlayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"previewPlayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get thumbContainer() : Canvas
      {
         return this._173763403thumbContainer;
      }
      
      public function set thumbContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._173763403thumbContainer;
         if(_loc2_ !== param1)
         {
            this._173763403thumbContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"thumbContainer",_loc2_,param1));
            }
         }
      }
   }
}
