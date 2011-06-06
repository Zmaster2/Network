package {
	import flash.events.*;
	import flash.display.*;
	import flash.ui.*;
	public class vert extends MovieClip {
		public var pacs=new Array();
		public var cone=new Array();
		public var lines=new Array();
		public var cod,lev,rtm,tm,tm2,tmpro,p,limt,num;
		public function vert(c) {
			cod=c;
			lev=1;
			tmpro=30;
			limt=5;
			tm=tm2=p=0;
			body.width=body.height=Math.pow(1.1,lev)*20;
			addEventListener(Event.ENTER_FRAME, enf);
			addEventListener(MouseEvent.CLICK, mm_ck);
		}
		public function enf(e:Event) {
			//////////////////////////////////////mudanca de level
			if (p>Math.pow(2,lev)*15) {
				p-=Math.pow(2,lev)*15;
				lev++;
				body.width=body.height=Math.pow(1.2,lev)*20;
			}
			////////////////////////////////ver sel
			if (this==network.sel) {
				body.gotoAndStop(2);
			} else {
				body.gotoAndStop(1);
			}
			////////////////////////////////define ritmo produção
			rtm=(150)*Math.pow(0.85,lev);
			/////////////////////////////////aruma as arestas
			for (var i=0; i<lines.length; i++) {
				var dx=-(cone[i].x-x);
				var dy=-(cone[i].y-y);
				lines[i].comp.width=Math.sqrt((dx*dx)+(dy*dy));
				if (dx<0) {
					lines[i].rotation=Math.atan(dy/dx)*180/Math.PI;
				} else {
					lines[i].rotation=Math.atan(dy/dx)*180/Math.PI-180;
				}
				lines[i].x=x+(dy/lines[i].comp.width)*4;
				lines[i].y=y-(dx/lines[i].comp.width)*4;
			}
			///////////////////////////////mostra o buffer
			pacs_f.text=pacs.length;
			/////////////////////////////////////em função tempo
			if (network.time%network.spd==0) {
				/////////////////////////////////////produção pacotes
				if (tm>rtm) {
					if(limt>pacs.length){
						p+=1;
						var r=network.verts[Math.floor(Math.random()*network.verts.length)];
						while(r==this){
							r=network.verts[Math.floor(Math.random()*network.verts.length)];
						}
						var np=new pack(r);
						pacs.push(np);
						network.m.cont_p.addChild(np);
						np.x=9999;
					}
					tm=0;
				} else {
					tm++;
				}
				/////////////////////////////////////tratamento pacotes
				if (pacs.length!=0) {
					if (tm2>tmpro) {
						if (pacs[0].obj==this) {
							body.lig.play();
							p+=3;
							network.p+=1;
							pacs.shift();
							tm+=rtm/7;
						} else {
							var prox=dijkistra(pacs[0].obj,0);
							if (prox==null) {
								trace("null");
								///TRATAMENTO TEMPORARIO!!!!
								pacs.shift();
								//body.lig.play();
							} else {
								if (lines[prox].max>lines[prox].np) {
									pacs[0].way=lines[prox];
									lines[prox].np++;
									pacs[0].t=0;
								} else {
									if (limt>pacs.length) {
										pacs.push(pacs[0]);
									}else{
										//trace("perdeu")
									}
								}
								pacs.shift();
							}
						}
						p+=1;
						tm2=0;
					} else {
						tm2++;
					}
				}
			}
		}
		public function dijkistra(obj,tip) {

			var vetd=new Array();
			var vetp=new Array();
			var vetc=new Array();
			var vet=new Array();
			var atu,newd,atu_dist;
			for (var i=0; i<network.verts.length; i++) {
				vetd.push(1/0);
				vetp.push(i);
				vetc.push(-1);
				vet.push(network.verts[i]);
			}
			////
			vetd[num]=1/0;
			vet[num]=network.verts[0];
			vetd[0]=0;
			vet[0]=this;
			vetp[0]=num;
			vetp[num]=0;

			for (var i=0; i<network.verts.length; i++) {

				atu=vet[i];
				if (atu==obj) {
					if (tip==0) {
						//retorna o indice do proximo item //ERRADO????
						var prime,prim=vet[i].num;
						//trace("caminho: ");
						for (prim = vet[i].num; vet[vetp[prim]]!=this; prim= vetc[prim]) {
							//trace("pass "+vet[vetp[prim]].num+" "+vetd[vetp[prim]]);
							prime=prim;
						}
						for (var l=0; l<cone.length; l++) {
							if (cone[l]==network.verts[prime]) {
								return l;
							}
						}
					} else if (tip==1) {
						//retorna o proximo passo no caminho //ERRADO!!!
						return vet[1];
					} else {
						//retorna a menor distancia
						return vetd[i];
					}
					//return vetd[i];
				}
				for (var j=0; j<atu.cone.length; j++) {
					//trace("BBBBBBBBBBBBBB");
					newd=vetd[i]+atu.lines[j].comp.width;
					//trace(newd+" "+vetp[atu.cone[j].num]);
					if ((newd<vetd[vetp[atu.cone[j].num]])&&(vetp[atu.cone[j].num]>i)) {
						//trace("CCCCCCCCCCCCCCC");
						vetd[vetp[atu.cone[j].num]]=newd;
						vetc[atu.cone[j].num]=atu.num;
						//trace(newd+" "+vetp[atu.cone[j].num]+" "+atu.num+" "+atu.cone[j].num+" conec "+vetc[atu.cone[j].num]);
						/////reposicionar elemento
						for (var k=vetp[atu.cone[j].num]-1; k>=0; k--) {
							//trace("DDDDDDDDDDDDDDD"+k);
							for (var p=0; p<vet.length; p++) {
								//trace("vet "+(p)+":"+vet[p].cod + " dist " +vetd[p]+" pos " +vetp[p]);
							}
							if (vetd[k]>newd) {
								//trace("cima "+vetp[vet[k].num]+" "+(k+1));
								vetp[vet[k].num]++;
								vet[k+1]=vet[k];
								vetd[k+1]=vetd[k];
							} else {
								//trace("baixo"+k)
								vet[k+1]=atu.cone[j];
								vetd[k+1]=newd;
								vetp[atu.cone[j].num]=k+1;
								break;
							}
							//trace("FDDDDDDDDDDDDDDD");
						}
					}
					//trace("FBBBBBBBBBBBBBB");
				}
			}
			return null;
		}
		///////////////////////////////////verifica existencia conexão
		public function check_con(c) {
			for (var i=0; i<cone.length; i++) {
				if (cone[i]==c) {
					return true;
				}
			}
			return false;
		}
		///////////////////////////////////mouse click
		public function mm_ck(e:Event) {
			//trace(network.Down);
			if ((network.sel!=null)&&(network.Up)) {
				trace("res: "+network.sel.dijkistra(this,0));
			}
			///////////////////////////////////cria conexão
			if (network.conc_sel!=null) {
				if ((network.m.line_t.comp.width<200)&&(network.m.line_t.comp.width>50)&&(!network.conc_sel.check_con(this))) {
					network.conc_sel.cone.push(this);
					var conec=network.m.cont_c.addChild(new line(network.conc_sel,this));
					network.conc_sel.lines.push(conec);
					network.conc_sel=null;
					network.m.line_t.x=9999;
					network.p-=7;
					var dx=-(network.sel.x-x);
					var dy=-(network.sel.y-y);
				}
			} else {
				network.sel=this;
				network.mos.gotoAndStop(1);
			}
		}
	}
}