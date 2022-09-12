package mx.core
{
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import mx.events.RSLEvent;
   import mx.utils.LoaderUtil;
   import mx.utils.SHA256;
   
   use namespace mx_internal;
   
   public class CrossDomainRSLItem extends RSLItem
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var rslUrls:Array;
      
      private var policyFileUrls:Array;
      
      private var digests:Array;
      
      private var isSigned:Array;
      
      private var hashTypes:Array;
      
      private var urlIndex:int = 0;
      
      private var loadBytesLoader:Loader;
      
      public function CrossDomainRSLItem(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array, param6:String = null, param7:IFlexModuleFactory = null)
      {
         super(param1[0],param6,param7);
         this.rslUrls = param1;
         this.policyFileUrls = param2;
         this.digests = param3;
         this.hashTypes = param4;
         this.isSigned = param5;
      }
      
      override public function load(param1:Function, param2:Function, param3:Function, param4:Function, param5:Function) : void
      {
         var _loc7_:ErrorEvent = null;
         chainedProgressHandler = param1;
         chainedCompleteHandler = param2;
         chainedIOErrorHandler = param3;
         chainedSecurityErrorHandler = param4;
         chainedRSLErrorHandler = param5;
         urlRequest = new URLRequest(LoaderUtil.createAbsoluteURL(rootURL,this.rslUrls[this.urlIndex]));
         var _loc6_:URLLoader;
         (_loc6_ = new URLLoader()).dataFormat = URLLoaderDataFormat.BINARY;
         _loc6_.addEventListener(ProgressEvent.PROGRESS,itemProgressHandler);
         _loc6_.addEventListener(Event.COMPLETE,this.itemCompleteHandler);
         _loc6_.addEventListener(IOErrorEvent.IO_ERROR,this.itemErrorHandler);
         _loc6_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.itemErrorHandler);
         if(this.policyFileUrls.length > this.urlIndex && this.policyFileUrls[this.urlIndex] != "")
         {
            Security.loadPolicyFile(this.policyFileUrls[this.urlIndex]);
         }
         if(this.isSigned[this.urlIndex])
         {
            if(!urlRequest.hasOwnProperty("digest"))
            {
               if(this.hasFailover())
               {
                  this.loadFailover();
                  return;
               }
               (_loc7_ = new ErrorEvent(RSLEvent.RSL_ERROR)).text = "Flex Error #1002: Flash Player 9.0.115 and above is required to support signed RSLs. Problem occurred when trying to load the RSL " + urlRequest.url + ".  Upgrade your Flash Player and try again.";
               super.itemErrorHandler(_loc7_);
               return;
            }
            urlRequest.digest = this.digests[this.urlIndex];
         }
         _loc6_.load(urlRequest);
      }
      
      private function completeCdRslLoad(param1:URLLoader) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc6_:ErrorEvent = null;
         if(param1 == null || param1.data == null || ByteArray(param1.data).bytesAvailable == 0)
         {
            return true;
         }
         this.loadBytesLoader = new Loader();
         var _loc2_:LoaderContext = new LoaderContext();
         if(moduleFactory != null)
         {
            _loc2_.applicationDomain = moduleFactory.info()["currentDomain"];
         }
         else
         {
            _loc2_.applicationDomain = ApplicationDomain.currentDomain;
         }
         _loc2_.securityDomain = null;
         if("allowLoadBytesCodeExecution" in _loc2_)
         {
            _loc2_["allowLoadBytesCodeExecution"] = true;
         }
         if(this.digests[this.urlIndex] != null && String(this.digests[this.urlIndex]).length > 0)
         {
            _loc3_ = false;
            if(!this.isSigned[this.urlIndex])
            {
               if(this.hashTypes[this.urlIndex] == SHA256.TYPE_ID)
               {
                  _loc4_ = null;
                  if(param1.data != null)
                  {
                     _loc4_ = SHA256.computeDigest(param1.data);
                  }
                  if(_loc4_ == this.digests[this.urlIndex])
                  {
                     _loc3_ = true;
                  }
               }
            }
            else
            {
               _loc3_ = true;
            }
            if(!_loc3_)
            {
               _loc5_ = this.hasFailover();
               (_loc6_ = new ErrorEvent(RSLEvent.RSL_ERROR)).text = "Flex Error #1001: Digest mismatch with RSL " + urlRequest.url + ". Redeploy the matching RSL or relink your application with the matching library.";
               this.itemErrorHandler(_loc6_);
               return !_loc5_;
            }
         }
         this.loadBytesLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadBytesCompleteHandler);
         this.loadBytesLoader.loadBytes(param1.data,_loc2_);
         return true;
      }
      
      public function hasFailover() : Boolean
      {
         return this.rslUrls.length > this.urlIndex + 1;
      }
      
      public function loadFailover() : void
      {
         if(this.urlIndex < this.rslUrls.length)
         {
            trace("Failed to load RSL " + this.rslUrls[this.urlIndex]);
            trace("Failing over to RSL " + this.rslUrls[this.urlIndex + 1]);
            ++this.urlIndex;
            url = this.rslUrls[this.urlIndex];
            this.load(chainedProgressHandler,chainedCompleteHandler,chainedIOErrorHandler,chainedSecurityErrorHandler,chainedRSLErrorHandler);
         }
      }
      
      override public function itemCompleteHandler(param1:Event) : void
      {
         this.completeCdRslLoad(param1.target as URLLoader);
      }
      
      override public function itemErrorHandler(param1:ErrorEvent) : void
      {
         if(this.hasFailover())
         {
            trace(decodeURI(param1.text));
            this.loadFailover();
         }
         else
         {
            super.itemErrorHandler(param1);
         }
      }
      
      private function loadBytesCompleteHandler(param1:Event) : void
      {
         this.loadBytesLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadBytesCompleteHandler);
         this.loadBytesLoader = null;
         super.itemCompleteHandler(param1);
      }
   }
}
