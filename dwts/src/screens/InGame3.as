package screens 
{
	import com.friendsofed.vector.VectorModel;
	import com.friendsofed.vector.VectorMath;
	import objects.Archer;
	import objects.Ball;
	import objects.Proyectil;
	import objects.Witch;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import screens.InGame;
	import starling.text.TextField;
	
	
	/**
	 * ...
	 * @author v y a
	 */
	public class InGame3 extends InGame 
	{
		//movimiento
		private var angulo:Number = 0;
		private var centroX:Number = 400;
		private var centroY:Number = 300;
		private var radio:Number = 300;
		private var vel:Number= 0.05;
		
		
		//nuestros arrays y vectores
		public var vectorBolasCongeladas:Array = new Array();
		
		public function InGame3() 
		{
			super();	
		}
		
		override public function update():void
		{
			
			colisionBolasDisparos();
			colisionBolas();
			
			puntuacion -= 1;
			puntuacionTexto.text = "Puntuacion: " + puntuacion;
			hpBruja.text = "Vida Bruja: " + bruja.hp;
			
			if (vectorBolas.length == 0)
			{
				bruja.vulnerable = true;
				
				if (bruja.hp == 1000 || bruja.hp == 500) 
				{
					bruja.hit();
					
					bruja.vulnerable = false;
					
					addBolas(5);
				}
				
				if (bruja.hp < 990) 
				{
					trace(bruja.hp);
					bruja.x=centroX+Math.sin(angulo)*radio;
					bruja.y=centroY+Math.cos(angulo)*radio;
					//angulo = angulo + vel;
					angulo += vel;
				}
				
				if (bruja.hp < 500)
				{
					
					this.addChild(tronco);
					
				}
				
				if (bruja.hp == 0)
				{
					this.removeEventListener(Event.ENTER_FRAME, update);
					stage.removeEventListener(TouchEvent.TOUCH, onTouch);
					for (var limpiar:int = 0; limpiar < vectorDisparos.length; limpiar++ )
					{
						removeChild(vectorDisparos[limpiar]);
						vectorDisparos.removeAt(limpiar);
					}
					
					this.removeChild(tronco);
					mostrarPuntuacion();
					
					
					this.addChild(botonNext);
				}

				
				
				
				
				
				
			}
			else 
			{
				bruja.vulnerable = false;
			}
		}//fin update
		
		override public function drawGame():void
		{
			hpBruja = new TextField(300, 100, "Vida Bruja: " + bruja.hp, "Verdana", 12, 0xffffff, true);
			hpBruja.pivotX = hpBruja.width / 2;
			hpBruja.x = stage.stageWidth - stage.stageWidth / 4;
			addChild(hpBruja);
			addChild(bruja);
			
			canalMusica = musicaBruja.play();
			bajarVolumen.volume = 0.1;
			canalMusica.soundTransform = bajarVolumen;
		}
		
		
	}

}