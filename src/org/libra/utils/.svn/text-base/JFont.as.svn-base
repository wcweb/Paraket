package org.libra.utils {
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JFont{
		
		private var name:String;
		private var size:uint;
		private var bold:Boolean;
		private var italic:Boolean;
		private var underline:Boolean;
		private var textFormat:TextFormat;
		
		public function JFont(name:String = "Tahoma", size:Number = 11, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false) { 
			this.name = name;
			this.size = size;
			this.bold = bold;
			this.italic = italic;
			this.underline = underline;
			textFormat = createTextFormat();
		}
		
		private function createTextFormat():TextFormat {
			return new TextFormat(
				name, size, null, bold, italic, underline, 
				"", "", TextFormatAlign.LEFT, 0, 0, 0, 0 
				);
		}
		
		public function getName():String{
			return name;
		}
		
		public function changeName(name:String):JFont{
			return new JFont(name, size, bold, italic, underline);
		}
		
		public function getSize():uint{
			return size;
		}
		
		public function changeSize(size:int):JFont{
			return new JFont(name, size, bold, italic, underline);
		}
		
		public function isBold():Boolean{
			return bold;
		}
		
		public function changeBold(bold:Boolean):JFont{
			return new JFont(name, size, bold, italic, underline);
		}
		
		public function isItalic():Boolean{
			return italic;
		}
		
		public function changeItalic(italic:Boolean):JFont{
			return new JFont(name, size, bold, italic, underline);
		}
		
		public function isUnderline():Boolean{
			return underline;
		}
		
		public function changeUnderline(underline:Boolean):JFont{
			return new JFont(name, size, bold, italic, underline);
		}
		
		public function getTextFormat():TextFormat{
			return this.textFormat;
		}
		
		public function clone():JFont{
			return new JFont(name, size, bold, italic, underline);
		}	
		
		public function toString():String{
			return "JFont[" 
				+ "name : " + name 
				+ ", size : " + size 
				+ ", bold : " + bold 
				+ ", italic : " + italic 
				+ ", underline : " + underline 
				+ "]";
		}
	}
}