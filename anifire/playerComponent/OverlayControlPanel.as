package anifire.playerComponent
{
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class OverlayControlPanel extends VBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1282133823fadeIn:Fade;
      
      private var _1091436750fadeOut:Fade;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function OverlayControlPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "effects":["showEffect","hideEffect"],
            "stylesFactory":function():void
            {
               this.verticalGap = 0;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":180,
                  "height":216,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Button,
                     "events":{"click":"___OverlayControlPanel_Button1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnOverlayPanelEmail",
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "events":{"click":"___OverlayControlPanel_Button2_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnOverlayPanelShare",
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "events":{"click":"___OverlayControlPanel_Button3_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnOverlayPanelCreate",
                           "buttonMode":true
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._OverlayControlPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_playerComponent_OverlayControlPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return OverlayControlPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 180;
         this.height = 216;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._OverlayControlPanel_Fade2_i();
         this._OverlayControlPanel_Fade1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         OverlayControlPanel._watcherSetupUtil = param1;
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
            this.verticalGap = 0;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function doDispatchCreateClick() : void
      {
         var _loc1_:OverlayControlPanelEvent = new OverlayControlPanelEvent(OverlayControlPanelEvent.CREATE_CLICK,this);
         this.dispatchEvent(_loc1_);
      }
      
      private function doDispatchEmailClick() : void
      {
         var _loc1_:OverlayControlPanelEvent = new OverlayControlPanelEvent(OverlayControlPanelEvent.EMAIL_CLICK,this);
         this.dispatchEvent(_loc1_);
      }
      
      private function doDispatchShareClick() : void
      {
         var _loc1_:OverlayControlPanelEvent = new OverlayControlPanelEvent(OverlayControlPanelEvent.SHARE_CLICK,this);
         this.dispatchEvent(_loc1_);
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      private function _OverlayControlPanel_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 200;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         this.fadeIn = _loc1_;
         BindingManager.executeBindings(this,"fadeIn",this.fadeIn);
         return _loc1_;
      }
      
      private function _OverlayControlPanel_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 300;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         this.fadeOut = _loc1_;
         BindingManager.executeBindings(this,"fadeOut",this.fadeOut);
         return _loc1_;
      }
      
      public function ___OverlayControlPanel_Button1_click(param1:MouseEvent) : void
      {
         this.doDispatchEmailClick();
      }
      
      public function ___OverlayControlPanel_Button2_click(param1:MouseEvent) : void
      {
         this.doDispatchShareClick();
      }
      
      public function ___OverlayControlPanel_Button3_click(param1:MouseEvent) : void
      {
         this.doDispatchCreateClick();
      }
      
      private function _OverlayControlPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,null,function(param1:*):void
         {
            this.setStyle("showEffect",param1);
         },"this.showEffect","fadeIn");
         result[1] = new Binding(this,null,function(param1:*):void
         {
            this.setStyle("hideEffect",param1);
         },"this.hideEffect","fadeOut");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOut() : Fade
      {
         return this._1091436750fadeOut;
      }
      
      public function set fadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._1091436750fadeOut;
         if(_loc2_ !== param1)
         {
            this._1091436750fadeOut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOut",_loc2_,param1));
            }
         }
      }
   }
}
