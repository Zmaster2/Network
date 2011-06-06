package {
	import flash.events.*;
	import flash.display.*;
	import flash.ui.*;
	public class network extends MovieClip {
		public static var verts= new Array();
		public static var cons= new Array();
		public static var Left,Right,Up,Down,sel,conc_sel,m,mos,p,nvert,t,tnvert,time,time_r,val,lastx,lasty,spd,make;
		public var dx,dy;
		public function network() {
			trace("- Start -");
			p=3000;
			tnvert=600;
			sel=conc_sel=null;
			verts[0]=new vert(0);
			amb.addChild(verts[0]);
			verts[0].x=300;
			verts[0].y=300;
			verts[0].num=0;
			/////////
			/*verts[1]=new vert(1);
			amb.addChild(verts[1]);
			verts[1].x=388;
			verts[1].y=297;
			verts[1].num=1;
			
			verts[2]=new vert(2);
			amb.addChild(verts[2]);
			verts[2].x=429;
			verts[2].y=206;
			verts[2].num=2;
			
			verts[3]=new vert(3);
			amb.addChild(verts[3]);
			verts[3].x=340;
			verts[3].y=133;
			verts[3].num=3;
			
			verts[4]=new vert(4);
			amb.addChild(verts[4]);
			verts[4].x=249;
			verts[4].y=199;
			verts[4].num=4;
			
			verts[5]=new vert(5);
			amb.addChild(verts[5]);
			verts[5].x=344;
			verts[5].y=207;
			verts[5].num=5;*/
			
			///////////
			nvert=20;
			m=amb;
			t=time=time_r=val=0;
			/////////////pause
			spd=1/0;
			lastx=-999;
			addEventListener(Event.ENTER_FRAME, enf);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kdon);
			stage.addEventListener(KeyboardEvent.KEY_UP, kup);
			amb.addEventListener(MouseEvent.MOUSE_DOWN, mm_ck);
			amb.addEventListener(MouseEvent.MOUSE_UP, mm_ck_up);
			mos=most;
			most.line_b.addEventListener(MouseEvent.CLICK, line_b_ck);
			most.spd_b.addEventListener(MouseEvent.CLICK, spd_b_ck);
			most.max_b.addEventListener(MouseEvent.CLICK, max_b_ck);
			most.tpro_b.addEventListener(MouseEvent.CLICK, tpro_b_ck);
			most.stok_b.addEventListener(MouseEvent.CLICK, stok_b_ck);

			most.line_b.addEventListener(MouseEvent.MOUSE_OVER, line_b_mv);
			most.spd_b.addEventListener(MouseEvent.MOUSE_OVER, spd_b_mv);
			most.max_b.addEventListener(MouseEvent.MOUSE_OVER, max_b_mv);
			most.tpro_b.addEventListener(MouseEvent.MOUSE_OVER, tpro_b_mv);
			most.stok_b.addEventListener(MouseEvent.MOUSE_OVER, stok_b_mv);

			most.most_back.addEventListener(MouseEvent.MOUSE_OVER, out_mv);
		}
		public function enf(e:Event) {
			time++;
			if (lastx!=-999) {
				amb.x+=(mouseX-lastx);
				amb.y+=(mouseY-lasty);
				lastx=mouseX;
				lasty=mouseY;
			}
			if (val>0) {
				val_m.x=mouseX;
				val_m.y=mouseY;
				val_m.prec.text=Math.floor(val);
			} else {
				val_m.x=9999;
			}
			if (sel!=null) {
				if (sel.cod!="line") {
					most.name_f.text=sel.cod;
					most.level_f.text=sel.lev;
					most.rtm_f.text=sel.rtm;
					most.pro_f.text=sel.tmpro;
					most.lim_f.text=sel.limt;
					most.bar_lev.b.width=170*(sel.p/(Math.pow(2,sel.lev)*15));
				} else {
					most.name_f.text=String(sel.ori.cod+" - "+sel.des.cod);
					most.level_f.text=sel.spd;
					most.rtm_f.text=sel.max;
				}
			} else {
				most.gotoAndStop(3);
			}
			p_f.text=p;
			nvert_f.text=nvert;
			if (conc_sel!=null) {
				dx=-(amb.mouseX-sel.x);
				dy=-(amb.mouseY-sel.y);
				amb.line_t.comp.width=(Math.sqrt((dx*dx)+(dy*dy)))-2;
				if (amb.line_t.comp.width>201) {
					amb.line_t.comp.width=201;
				} else if (amb.line_t.comp.width<49) {
					amb.line_t.comp.width=49;
				}
				if (dx<0) {
					amb.line_t.rotation=Math.atan(dy/dx)*180/Math.PI;
				} else {
					amb.line_t.rotation=Math.atan(dy/dx)*180/Math.PI-180;
				}
				amb.line_t.x=sel.x+(dy/amb.line_t.comp.width)*4;
				amb.line_t.y=sel.y-(dx/amb.line_t.comp.width)*4;
			}
			if (time%spd==0) {
				time_r++;
				time_f.text=String(Math.floor(time_r/30));
				if (t>tnvert) {
					t=0;
					tnvert+=150;
					nvert++;
				} else {
					t++;
				}
			}
		}
		public function kdon(e:KeyboardEvent) {
			switch (e.keyCode) {
				case 37 ://Left
					Left=true;
					break;
				case 38 ://Up
					Up=true;
					break;
				case 39 ://Right
					Right=true;
					break;
				case Keyboard.SPACE :
					make=true;
					break;
				case Keyboard.SHIFT :
					conc_sel=null;
					amb.line_t.x=99999;
					break;
				case Keyboard.BACKSPACE:
					sel=null;
					break;
				case Keyboard.NUMPAD_ADD :
					if (spd>1) {
						if (spd>9) {
							spd=9;
						} else {
							spd/=3;
						}
					}
					break;
				case Keyboard.NUMPAD_SUBTRACT :
					if (spd<9) {
						spd*=3;
					} else {
						spd=1/0;
					}

					break;
			}
		}
		public function kup(e:KeyboardEvent) {
			switch (e.keyCode) {
				case 37 ://Left
					Left=false;
					break;
				case 38 ://Up
					Up=false;
					break;
				case 39 ://Right
					Right=false;
					break;
				case Keyboard.SPACE :
					make=false;
					break;
										
				case 40 :
					if (p>=val) {
						conc_sel=sel;
						amb.line_t.x=sel.x;
						amb.line_t.y=sel.y;
					}
						
					break;
				case Keyboard.SHIFT :
					break;
			}
		}
		public function mm_ck(e:Event) {
			if ((make)&&(nvert>0)) {
				verts.push(new vert(verts.length));
				amb.cont_v.addChild(verts[verts.length-1]);
				verts[verts.length-1].x=amb.mouseX;
				verts[verts.length-1].y=amb.mouseY;
				trace(amb.mouseX+" "+amb.mouseY)
				verts[verts.length-1].num=verts.length-1;
				nvert--;
				
				//var dx=-(network.sel.x-x);
				//var dy=-(network.sel.y-y);
				if(sel!=null){
					var conec=amb.cont_c.addChild(new line(verts[verts.length-1],sel));
					verts[verts.length-1].cone.push(sel);
					verts[verts.length-1].lines.push(conec);
					p-=7;
					var conec=amb.cont_c.addChild(new line(sel,verts[verts.length-1]));
					sel.cone.push(verts[verts.length-1]);
					sel.lines.push(conec);
					p-=7;
				}
			}
			lastx=mouseX;
			lasty=mouseY;

		}
		public function mm_ck_up(e:Event) {
			lastx=-999;
		}
		public function line_b_ck(e:Event) {
			if (p>=val) {
				conc_sel=sel;
				amb.line_t.x=sel.x;
				amb.line_t.y=sel.y;
			}
		}
		public function spd_b_ck(e:Event) {
			if (p>=val) {
				sel.spd*=1.5;
				p-=Math.floor(val);
				val=Math.pow(1.5,sel.spd)*5;
			}
		}
		public function max_b_ck(e:Event) {
			if (p>=val) {
				sel.max++;
				p-=Math.floor(val);
				val=Math.pow(1.2,sel.max)*5;
			}
		}
		public function tpro_b_ck(e:Event) {
			if (p>=val) {
				sel.tmpro*=0.75;
				p-=Math.floor(val);
				val=Math.pow(1.1,(30-sel.tmpro))*7;
			}
		}
		public function stok_b_ck(e:Event) {
			if (p>=val) {
				sel.limt+=2;
				p-=Math.floor(val);
				val=5+(sel.limt-5)/2;
			}
		}
		public function line_b_mv(e:Event) {
			val=7;
		}
		public function spd_b_mv(e:Event) {
			val=Math.pow(1.5,sel.spd)*5;
		}
		public function max_b_mv(e:Event) {
			val=Math.pow(1.2,sel.max)*5;
		}
		public function tpro_b_mv(e:Event) {
			val=Math.pow(1.03,(30-sel.tmpro))*7;
		}
		public function stok_b_mv(e:Event) {
			val=5+(sel.limt-5)/2;
		}
		public function out_mv(e:Event) {
			val=0;
		}
	}
}