package {
	import flash.events.*;
	import flash.display.*;
	import flash.ui.*;
	public class line extends MovieClip {
		var hip;
		public var cod,des,ori,tip,spd,max,np;
		public function line(o,d) {
			cod="line";
			ori=o;
			des=d;
			max=1;
			spd=1;
			np=0;
			tip=0;
			addEventListener(Event.ENTER_FRAME, enf);
			addEventListener(MouseEvent.CLICK, mm_ck);
		}
		public function enf(e:Event) {
			gotoAndStop(tip+1);
			if (this==network.sel) {
				comp.gotoAndStop(2);
			} else {
				comp.gotoAndStop(1);
			}
			if (network.time%network.spd==0) {
			}
		}
		public function mm_ck(e:Event) {
			network.sel=this;
			network.mos.gotoAndStop(2);
		}
	}
}