package {
	import flash.events.*;
	import flash.display.*;
	import flash.ui.*;
	public class pack extends MovieClip {
		var hip;
		public var way,alv,ori,obj,lin,t,posi;
		public function pack(o) {
			obj=o;
			way=alv=null;
			addEventListener(Event.ENTER_FRAME, enf);
		}
		public function enf(e:Event) {
			if (network.time%network.spd==0) {
				if (way!=null) {
					t++;
					var che=(way.comp.width-5)/(way.spd);
					var ww=(way.width-4);
					if (t<che) {
						if ((way.rotation>0-90)&&(way.rotation<90)) {
							x=way.x+(ww/way.comp.width)*t*way.spd;
						} else {
							x=way.x-(ww/way.comp.width)*t*way.spd;
						}
						if ((way.rotation>0)&&(way.rotation<180)) {
							y=way.y+(way.height/way.comp.width)*t*way.spd;
						} else {
							y=way.y-(way.height/way.comp.width)*t*way.spd;
						}
					} else {
						alv=way.des;
						if (alv.limt>alv.pacs.length) {							
							alv.pacs.push(this);
						}
						x=99999;
						way.np--;
						way=null;
					}
				}
			}
		}
	}
}