package screens 
{
	import events.NavigationEvent;
	import flash.media.SoundTransform;
	import objects.Obstaculo;
	import objects.Witch;
	
	import flash.geom.Point;
	
	import objects.Archer;
	import objects.Proyectil;
	import objects.Ball;
	
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import starling.text.TextField;
	import starling.utils.VectorUtil;

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import Math;
	
	import com.friendsofed.vector.VectorModel;
	import com.friendsofed.vector.VectorMath;

	import mx.core.ButtonAsset;
	

	public class InGame extends Sprite 
	{
		//objetos
		public var arquera:Archer;
		public var bruja:Witch;
		public var tronco:Obstaculo;
		public var disparo:Proyectil;
		public var bola:Ball;
		public var disparoActual:Proyectil;
		public var bolaActual:Ball;
		public var bolaColision:Ball;
		public var bolaActualDisparo:Ball;
		
		//raton
		public var mouseX:Number = 0;
		public var mouseY:Number = 0;
		
		//nuestros arrays y vectores
		public var vectorDisparos:Array;
		public var vectorBolas:Array;
		
		//puntuacion
		public var puntuacionTexto:TextField;
		public var puntuacionTotalTexto:TextField;
		public var puntuacion:int = 5000;
		
		//boton next
		public var botonNext:Button;
		
		//sonidos
		public var disparoSonido:Sound = new Assets.DisparoSonido();
		public var hitmarker:Sound = new Assets.Hitmarker();
		public var musica:Sound = new Assets.Musica();
		public var musicaBruja:Sound = new Assets.MusicaBruja();
		public var canalMusica:SoundChannel = new SoundChannel();
		public var bajarVolumen:SoundTransform = new SoundTransform();
		
		//vida bruja
		public var hpBruja:TextField;
		
		//texto completado
		public var completadoTexto:TextField = new TextField(300, 100, "NIVEL COMPLETADO!", "Verdana", 25, 0xffffff, true);
			
		
		public function InGame() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			vectorDisparos = new Array;
			vectorBolas = new Array;
			
			this.addEventListener(Event.ENTER_FRAME, update);
			
			arquera = new Archer();
						
			arquera.x = stage.stageWidth / 2;
			arquera.y = stage.stageHeight / 2;
			
			addChild(arquera);
			
			bruja = new Witch();
			tronco = new Obstaculo();
			
			bruja.x = 0;
			bruja.y = stage.stageHeight / 2;
			
			tronco.scale = 0.5;
			tronco.x = 200;
			tronco.y = bruja.y;
			
			addBolas(15);
			
			botonNext = new Button(Assets.getTexture("Next"));
			botonNext.pivotX = botonNext.width / 2;
			botonNext.pivotY = botonNext.height / 2;
			botonNext.scale = 0.4;
			botonNext.x = stage.stageWidth / 2;
			botonNext.y = (stage.stageHeight / 2) + 100;
			this.addEventListener(Event.TRIGGERED, clicEnBoton);
			
			drawGame();
			
			puntuacionTexto = new TextField(300, 100, "Puntuacion: 5000", "Verdana", 12, 0xffffff, true);
			this.addChild(puntuacionTexto);
		}
		
		public function onTouch(e:TouchEvent):void 
		{
			// get the mouse location related to the stage		
			var touch:Touch = e.getTouch(stage);
			
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					disparar();
				}
			}
			else return;
			
			var pos:Point = touch.getLocation(stage);
		    // store the mouse coordinates
			mouseX = pos.x;			
			mouseY = pos.y;
			
			rotaConCursor();
		}
		
		public function rotaConCursor():Number 
		{
			var catOpuesto:Number = mouseY-arquera.y;
			var catContinuo:Number = mouseX-arquera.x;
			var rotacion:Number = Math.atan2(catOpuesto, catContinuo);
			arquera.rotation = rotacion;
			return rotacion;
		}
		
		public function disparar():void
		{
			disparo = new Proyectil();
			disparo.x = stage.stageWidth / 2;
			disparo.y = stage.stageHeight / 2;
			disparo.rotation = rotaConCursor();
			
			var dx:Number = mouseX - disparo.x;
			var dy:Number = mouseY - disparo.y;
			
			disparo.m = Math.sqrt(dx * dx + dy * dy);
			disparo.vux = dx / disparo.m;
			disparo.vuy = dy / disparo.m;
			
			disparoSonido.play();
			
			vectorDisparos.push(disparo);
			
			addChild(disparo);
		}
		
		public function addBolas(nbolas:int ):void
		{
			for (var i:int = 0; i < nbolas; i++)
			{
				bola = new Ball();
				bola.x = Math.floor(Math.random() * (stage.stageWidth - 200) ) + 100;
				bola.y = Math.floor(Math.random() * (stage.stageHeight - 200) ) + 100;
				bola._speed = 6;
				
				bola._velocityX = (Math.random() * 2) - 1;
				bola._velocityY = (Math.random() * 2) - 1;
				
				vectorBolas.push(bola);
				
				addChild(bola);
			}
		}
		
		public function colisionBolasDisparos():void
		{
			//disparo y colision bolas
			for (var i:int = 0; i < vectorDisparos.length; i++ )
			{
				disparoActual = vectorDisparos[i];
				disparoActual.x += disparoActual.vux * disparoActual.vel;
				disparoActual.y += disparoActual.vuy * disparoActual.vel;
				
				//comprobacion con las bolas
				for (var r:int = 0; r < vectorBolas.length; r++)
				{
					bolaActualDisparo = vectorBolas[r];
					
					var v7:VectorModel = new VectorModel(bolaActualDisparo.x, bolaActualDisparo.y, disparoActual.x, disparoActual.y);
					var totalRadio_disparo:Number = bolaActualDisparo.width / 2 + disparoActual.width / 2;
				
					if (v7.m < totalRadio_disparo)
					{
						vectorBolas.removeAt(r);
						removeChild(bolaActualDisparo);
						hitmarker.play();
						puntuacion += 50;
					}
				}
				
				//comprobacion con la bruja
				if (bruja.visible)
				{
					if (colisionBrujaDisparo(disparoActual))
					{
						removeChild(disparoActual);
						vectorDisparos.removeAt(i);
						if (bruja.vulnerable)
						{
							bruja.hit();
						}
						
					}
					if (colisionTroncoDisparo(disparoActual))
					{
						removeChild(disparoActual);
						vectorDisparos.removeAt(i);
					}
				}
				
				// comprobacion con el stage
				if (disparoActual.x > stage.stageWidth ||
					disparoActual.x < 0 ||
					disparoActual.y > stage.stageHeight ||
					disparoActual.y < 0)
				{
					removeChild(disparoActual);
					vectorDisparos.removeAt(i);
				}
			}
		}//fin colision bolas con disparos
		
		public function colisionBrujaDisparo(disparo:Proyectil):Boolean 
		{
			if ( 
			disparo.x < (bruja.x + bruja.width / 2)
			&& disparo.x > (bruja.x - bruja.width / 2)
			&& disparo.y > (bruja.y - bruja.height / 2)
			&& disparo.y < (bruja.y + bruja.height / 2) 
			)
			{
				return true;
			}
			
			return false;
		}
		
		public function colisionTroncoDisparo(disparo:Proyectil):Boolean
		{
			if ( 
			disparo.x < (tronco.x + tronco.width / 2)
			&& disparo.y > (tronco.y - tronco.height / 2)
			&& disparo.y < (tronco.y + tronco.height / 2) 
			)
			{
				return true;
			}
			
			return false;
		}
		
		public function colisionBolas():void
		{
			//colisiones bolas
			for (var j:int = 0; j < vectorBolas.length; j++ )
			{
				bolaActual = vectorBolas[j];
				
				bolaActual.m = Math.sqrt(bolaActual._velocityX * bolaActual._velocityX + bolaActual._velocityY * bolaActual._velocityY);
				bolaActual._velocityX = bolaActual._velocityX / bolaActual.m;
				bolaActual._velocityY = bolaActual._velocityY / bolaActual.m;
				
				// colision escenario
				if ((bolaActual.x - bolaActual.width) < 0 
				|| (bolaActual.x + bolaActual.width) > stage.stageWidth)
				{
					bolaActual._velocityX = -bolaActual._velocityX;
				}
				
				if ((bolaActual.y - bolaActual.height) < 0
				|| (bolaActual.y + bolaActual.height) > stage.stageHeight)
				{
					bolaActual._velocityY = -bolaActual._velocityY;
				}
				
				// actualizacion de posicion 
				bolaActual.x += bolaActual._velocityX * bolaActual._speed;
				bolaActual.y += bolaActual._velocityY * bolaActual._speed;
				
				// colision otras bolas
				for (var l:int = 0; l < vectorBolas.length; l++)
				{
					bolaColision = vectorBolas[l];
					
					if (j != l)
					{
						var v0:VectorModel = new VectorModel(bolaActual.x, bolaActual.y, bolaColision.x, bolaColision.y);
						
						// calcular el radio de los dos circulos
						
						var totalRadio:Number = bolaActual.width / 2 + bolaColision.width / 2;
						
						
						if (v0.m < totalRadio)
						{
							// comprobamos si hay colision 
							var overlap:Number = totalRadio - v0.m;
							
							var colision_vx:Number = Math.abs(v0.dx * overlap * 0.5);
							var colision_vy:Number = Math.abs(v0.dy * overlap * 0.5);
							
							var xside:int = -1, yside:int = -1;
							
							if (bolaActual.x > bolaColision.x)
							{
								xside = 1;
							}
							
							if(bolaActual.y > bolaColision.y)
							{
								yside = 1;
							}
							
							// reposicionar la bolaActual
							bolaActual.x = bolaActual.x + (colision_vx * xside);
							bolaActual.y = bolaActual.y + (colision_vy * yside);
							
							// reposicionar la bolaColision
							bolaColision.x = bolaColision.x + (colision_vx * -xside);
							bolaColision.y = bolaColision.y + (colision_vy * -yside);
							
							//bolaActual 
							var v1:VectorModel = new VectorModel(
							bolaActual.x,
							bolaActual.y,
							bolaActual.x + bolaActual._velocityX,
							bolaActual.y + bolaActual._velocityY
							);
							
							//bolaColision 
							var v2:VectorModel = new VectorModel(
							bolaColision.x,
							bolaColision.y,
							bolaColision.x + bolaColision._velocityX,
							bolaColision.y + bolaColision._velocityY
							);
							
							//proyeccion v1
							var p1a:VectorModel = VectorMath.project(v1, v0);
							var p1b:VectorModel = VectorMath.project(v1, v0.ln);
							
							//proyeccion v2
							var p2a:VectorModel = VectorMath.project(v2, v0);
							var p2b:VectorModel = VectorMath.project(v2, v0.ln);
							
							bolaActual._velocityX = p1b.vx + p2a.vx;
							bolaActual._velocityY = p1b.vy + p2a.vy;
							
							bolaColision._velocityX = p1a.vx + p2b.vx;
							bolaColision._velocityY = p1a.vy + p2b.vy;	
						}
					}
				}
				

				// colision con shooter
				var v4:VectorModel = new VectorModel(bolaActual.x, bolaActual.y, arquera.x, arquera.y);
						
				// calcular el radio de los dos circulos
						
				var totalRadio_ab:Number = bolaActual.width / 2 + arquera.width / 2;
						
				if (v4.m < totalRadio_ab)
				{
					// comprobamos si hay colision 
					var overlap_ab:Number = totalRadio_ab - v4.m;
					
					var colision_abvx:Number = Math.abs(v4.dx * overlap_ab * 0.5);
					var colision_abvy:Number = Math.abs(v4.dy * overlap_ab * 0.5);
					
					var xabside:int = -1, yabside:int = -1;
					
					if (bolaActual.x > arquera.x)
					{
						xabside = 1;
					}
					
					if(bolaActual.y > arquera.y)
					{
						yabside = 1;
					}
					
					// reposicionar la bolaActual
					bolaActual.x = bolaActual.x + (colision_abvx * xabside);
					bolaActual.y = bolaActual.y + (colision_abvy * yabside);
					
					
					//bolaActual 
					var v5:VectorModel = new VectorModel(
					bolaActual.x,
					bolaActual.y,
					bolaActual.x + bolaActual._velocityX,
					bolaActual.y + bolaActual._velocityY
					);
					
					//bolaColision 
					var v6:VectorModel = new VectorModel(
					arquera.x,
					arquera.y,
					arquera.x - bolaActual._velocityX,
					arquera.y - bolaActual._velocityY
					);
					
					//proyeccion v5
					var p3b:VectorModel = VectorMath.project(v5, v4.ln);
					
					//proyeccion v6
					var p4a:VectorModel = VectorMath.project(v6, v4);

					bolaActual._velocityX = p3b.vx + p4a.vx;
					bolaActual._velocityY = p3b.vy + p4a.vy;
				}//Fin colision con arquera
	
				
			}//fin for recorrer bolas
			
		}//fin reccorrer bolas
		
				
		public function update():void
		{
			colisionBolasDisparos();
			colisionBolas();
			
			if (puntuacion > 0)
			{
				puntuacion -= 1;
			}
			
			puntuacionTexto.text = "Puntuacion: " + puntuacion;
			
			if (vectorBolas.length == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, update);
				stage.removeEventListener(TouchEvent.TOUCH, onTouch);
				for (var limpiar:int = 0; limpiar < vectorDisparos.length; limpiar++ )
				{
					removeChild(vectorDisparos[limpiar]);
					vectorDisparos.removeAt(limpiar);
				}
				
				mostrarPuntuacion();
				
				this.addChild(botonNext);				
			}
		}//fin update
		
		public function drawGame():void
		{			
			canalMusica = musica.play();
			bajarVolumen.volume = 0.1;
			canalMusica.soundTransform = bajarVolumen;
		}
		
		public function clicEnBoton(event:Event):void
		{
			var buttonCLicked:Button = event.target as Button;
			
			if ((buttonCLicked as Button) == botonNext)
			{
				canalMusica.stop();
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
			}
			// hacer para poder pulsar escape y volver al menu
		}
		
		public function mostrarPuntuacion():void
		{
			completadoTexto.pivotX = completadoTexto.width / 2;
			completadoTexto.x = stage.stageWidth / 2;
			completadoTexto.y = 100;
			this.addChild(completadoTexto);
			
			puntuacionTexto.text = "Puntuacion: \n" + puntuacion;
			puntuacionTexto.pivotX = puntuacionTexto.width / 2;
			puntuacionTexto.pivotY = puntuacionTexto.height / 2;
			puntuacionTexto.y = stage.stageHeight / 2;
			puntuacionTexto.x = ( stage.stageWidth / 2 ) - (stage.stageWidth / 4);
			puntuacionTexto.fontSize = 25;
			
			Game.PuntuacionTotal = Game.PuntuacionTotal + puntuacion;
			
			puntuacionTotalTexto = new TextField(300, 100, "Puntuacion Total: \n" + Game.PuntuacionTotal, "Verdana", 25, 0xffffff, true);
			puntuacionTotalTexto.pivotX = puntuacionTotalTexto.width / 2;
			puntuacionTotalTexto.pivotY = puntuacionTotalTexto.height / 2;
			puntuacionTotalTexto.y = stage.stageHeight / 2;
			puntuacionTotalTexto.x = ( stage.stageWidth / 2 ) + (stage.stageWidth / 4);
			this.addChild(puntuacionTotalTexto);
			
		}

		
		
	}

}