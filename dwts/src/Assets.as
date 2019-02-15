package 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.display.Image;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Victor y Ana
	 */
	public class Assets 
	{
		/*[Embed(source = "./img/.png")]
		private var ShooterImage:Class;*/
		
		[Embed(source="img/bgWelcome.png")]
		public static const BgWelcome:Class;
		
		[Embed(source = "img/hero.png")]
		public static const hero:Class;
		
		[Embed(source="img/play.png")]
		public static const PlayButton:Class;
		
		[Embed(source = "img/credits.png")]
		public static const CrtlButton:Class;
		
		[Embed(source = "img/ball.png")]
		public static const Proyectil:Class;
		
		[Embed(source = "img/enemyball.png")]
		public static const Ball:Class;
		
		[Embed(source = "img/witch.png")]
		public static const Witch:Class;
		
		[Embed(source = "img/tronco.png")]
		public static const Tronco:Class;
		
		[Embed(source = "img/1.png")]
		public static const Lvl1:Class;
		
		[Embed(source = "img/2.png")]
		public static const Lvl2:Class;
		
		[Embed(source = "img/3.png")]
		public static const Lvl3:Class;
		
		[Embed(source = "img/next.png")]
		public static const Next:Class;
		
		[Embed(source="sounds/wow.mp3")]
		public static const DisparoSonido:Class;
		
		[Embed(source = "sounds/hitmarker.mp3")]
		public static const Hitmarker:Class;
		
		[Embed(source = "sounds/music.mp3")]
		public static const Musica:Class;
		
		[Embed(source = "sounds/musicaBruja.mp3")]
		public static const MusicaBruja:Class;
		
		
		
		public static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name]
		}
		
		
	}

}