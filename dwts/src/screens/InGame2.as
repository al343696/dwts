package screens 
{
	import com.friendsofed.vector.VectorModel;
	import com.friendsofed.vector.VectorMath;
	import objects.Ball;
	import objects.Proyectil;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import screens.InGame;
	
	
	/**
	 * ...
	 * @author v y a
	 */
	public class InGame2 extends InGame 
	{
		//objetos
		public var bolaActualCongelada:Ball;
		public var disparoActualCongelada:Proyectil;

		//nuestros arrays y vectores
		public var vectorBolasCongeladas:Array = new Array();
		
		public function InGame2() 
		{
			super();
			
		}
		
		override public function colisionBolas():void
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
		}
		
		override public function colisionBolasDisparos():void
		{
			//disparo y colision bolas
			for (var i:int = 0; i < vectorDisparos.length; i++ )
			{
				disparoActual = vectorDisparos[i];
				disparoActual.x += disparoActual.vux * disparoActual.vel;
				disparoActual.y += disparoActual.vuy * disparoActual.vel;
				
				for (var r:int = 0; r < vectorBolas.length; r++)
				{
					bolaActualDisparo = vectorBolas[r];
					
					var v7:VectorModel = new VectorModel(bolaActualDisparo.x, bolaActualDisparo.y, disparoActual.x, disparoActual.y);
					var totalRadio_disparo:Number = bolaActualDisparo.width / 2 + disparoActual.width / 2;
				
					if (v7.m < totalRadio_disparo)
					{
						bolaActualDisparo.cambiaEstado();
						if (bolaActualDisparo.frezzed)
						{
							bolaActualDisparo.alpha = 0.5;
							
							vectorBolasCongeladas.push(bolaActualDisparo);
							
							vectorBolas.removeAt(r);
							
							this.removeChild(disparoActual);
							vectorDisparos.removeAt(i);
							hitmarker.play();
							puntuacion += 50;
							
							break;
						}
					}
				}
				
				
				//colision disparo bolas congeladas
				for (var d:int = 0; d < vectorDisparos.length; d++ )
				{
					disparoActualCongelada = vectorDisparos[d];
					
					for (var c:int = 0; c < vectorBolasCongeladas.length; c++)
					{
						bolaActualCongelada = vectorBolasCongeladas[c];
						
						var vCongelada:VectorModel = new VectorModel(bolaActualCongelada.x, bolaActualCongelada.y, disparoActualCongelada.x, disparoActualCongelada.y);
						var totalRadioCongeladaDisparo:Number = bolaActualCongelada.width / 2 + disparoActualCongelada.width / 2;
					
						if (vCongelada.m < totalRadioCongeladaDisparo)
						{
							bolaActualCongelada.cambiaEstado();
							if (!bolaActualCongelada.frezzed)
							{
								bolaActualCongelada.alpha = 1;
								
								vectorBolas.push(bolaActualCongelada);
								
								vectorBolasCongeladas.removeAt(c);
								
								this.removeChild(disparoActualCongelada);
								vectorDisparos.removeAt(d);
								
								puntuacion -= 50;
								
								break;
							}
						}
					}
				}
				
				if (disparoActual.x > stage.stageWidth ||
					disparoActual.x < 0 ||
					disparoActual.y > stage.stageHeight ||
					disparoActual.y < 0)
				{
					removeChild(disparoActual);
					vectorDisparos.removeAt(i);
				}
			}
		}//fin colision bolas disparos
		
		override public function update():void
		{
			
			colisionBolasDisparos();
			colisionBolas();
			
			puntuacion -= 1;
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
		
		
		
		
	}

}