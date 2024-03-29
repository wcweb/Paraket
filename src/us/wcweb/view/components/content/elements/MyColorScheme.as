package us.wcweb.view.components.content.elements {
	/**
	 * @author macbookpro
	 */
	public class MyColorScheme {
		public static const WHITE : MyColorScheme = new MyColorScheme(0xffffff);
		public static const LIGHT_GRAY : MyColorScheme = new MyColorScheme(0xc0c0c0);
		public static const LIGHT_GREEN_GRAY : MyColorScheme = new MyColorScheme(0xD9DDDD);
		public static const GRAY : MyColorScheme = new MyColorScheme(0x808080);
		public static const DARK_GRAY : MyColorScheme = new MyColorScheme(0x404040);
		public static const BLACK : MyColorScheme = new MyColorScheme(0x000000);
		public static const RED : MyColorScheme = new MyColorScheme(0xff0000);
		public static const PINK : MyColorScheme = new MyColorScheme(0xffafaf);
		public static const ORANGE : MyColorScheme = new MyColorScheme(0xffc800);
		public static const HALO_ORANGE : MyColorScheme = new MyColorScheme(0xFFC200);
		public static const YELLOW : MyColorScheme = new MyColorScheme(0xffff00);
		public static const GREEN : MyColorScheme = new MyColorScheme(0x00ff00);
		public static const HALO_GREEN : MyColorScheme = new MyColorScheme(0x80FF4D);
		public static const MAGENTA : MyColorScheme = new MyColorScheme(0xff00ff);
		public static const CYAN : MyColorScheme = new MyColorScheme(0x00ffff);
		public static const BLUE : MyColorScheme = new MyColorScheme(0x0000ff);
		public static const HALO_BLUE : MyColorScheme = new MyColorScheme(0x2BF5F5);
		protected var rgb : uint;
		protected var alpha : Number;
		protected var hue : Number;
		protected var luminance : Number;
		protected var saturation : Number;
		private var hlsCounted : Boolean;

		public function MyColorScheme(rgb : uint = 0x000000, alpha : Number = 1) {
			this.rgb = rgb;
			this.alpha = Math.min(1, Math.max(0, alpha));
			hlsCounted = false;
		}

		public function getAlpha() : Number {
			return alpha;
		}

		public function getRGB() : uint {
			return rgb;
		}

		public function getARGB() : uint {
			var a : uint = alpha * 255;
			return rgb | (a << 24);
		}

		public function getRed() : uint {
			return (rgb & 0x00FF0000) >> 16;
		}

		public function getGreen() : uint {
			return (rgb & 0x0000FF00) >> 8;
		}

		public function getBlue() : uint {
			return (rgb & 0x000000FF);
		}

		public function getHue() : Number {
			countHLS();
			return hue;
		}

		public function getLuminance() : Number {
			countHLS();
			return luminance;
		}

		public function getSaturation() : Number {
			countHLS();
			return saturation;
		}

		private function countHLS() : void {
			if (hlsCounted) {
				return;
			}
			hlsCounted = true;
			var rr : Number = getRed() / 255.0;
			var gg : Number = getGreen() / 255.0;
			var bb : Number = getBlue() / 255.0;

			var rnorm : Number, gnorm : Number, bnorm : Number;
			var minval : Number, maxval : Number, msum : Number, mdiff : Number;
			var r : Number, g : Number, b : Number;

			r = g = b = 0;
			if (rr > 0) r = rr;
			if (r > 1) r = 1;
			if (gg > 0) g = gg;
			if (g > 1) g = 1;
			if (bb > 0) b = bb;
			if (b > 1) b = 1;

			minval = r;
			if (g < minval) minval = g;
			if (b < minval) minval = b;
			maxval = r;
			if (g > maxval) maxval = g;
			if (b > maxval) maxval = b;

			rnorm = gnorm = bnorm = 0;
			mdiff = maxval - minval;
			msum = maxval + minval;
			luminance = 0.5 * msum;
			if (maxval != minval) {
				rnorm = (maxval - r) / mdiff;
				gnorm = (maxval - g) / mdiff;
				bnorm = (maxval - b) / mdiff;
			} else {
				saturation = hue = 0;
				return;
			}

			if (luminance < 0.5)
				saturation = mdiff / msum;
			else
				saturation = mdiff / (2.0 - msum);

			if (r == maxval)
				hue = 60.0 * (6.0 + bnorm - gnorm);
			else if (g == maxval)
				hue = 60.0 * (2.0 + rnorm - bnorm);
			else
				hue = 60.0 * (4.0 + gnorm - rnorm);

			if (hue > 360)
				hue = hue - 360;
			hue /= 360;
		}

		public function changeAlpha(newAlpha : Number) : MyColorScheme {
			return new MyColorScheme(getRGB(), newAlpha);
		}

		public function changeHue(newHue : Number) : MyColorScheme {
			return getMyColorSchemeWithHLS(newHue, getLuminance(), getSaturation(), getAlpha());
		}

		public function changeLuminance(newLuminance : Number) : MyColorScheme {
			return getMyColorSchemeWithHLS(getHue(), newLuminance, getSaturation(), getAlpha());
		}

		public function changeSaturation(newSaturation : Number) : MyColorScheme {
			return getMyColorSchemeWithHLS(getHue(), getLuminance(), newSaturation, getAlpha());
		}

		public function scaleHLS(hScale : Number, lScale : Number, sScale : Number) : MyColorScheme {
			var h : Number = getHue() * hScale;
			var l : Number = getLuminance() * lScale;
			var s : Number = getSaturation() * sScale;
			return getMyColorSchemeWithHLS(h, l, s, alpha);
		}

		public function offsetHLS(hOffset : Number, lOffset : Number, sOffset : Number) : MyColorScheme {
			var h : Number = getHue() + hOffset;
			if (h > 1) h -= 1;
			if (h < 0) h += 1;
			var l : Number = getLuminance() + lOffset;
			var s : Number = getSaturation() + sOffset;
			return getMyColorSchemeWithHLS(h, l, s, alpha);
		}

		public function darker(factor : Number = 0.7) : MyColorScheme {
			var r : uint = getRed();
			var g : uint = getGreen();
			var b : uint = getBlue();
			return getMyColorScheme(r * factor, g * factor, b * factor, alpha);
		}

		public function brighter(factor : Number = 0.7) : MyColorScheme {
			var r : uint = getRed();
			var g : uint = getGreen();
			var b : uint = getBlue();

			var i : Number = Math.floor(1.0 / (1.0 - factor));
			if ( r == 0 && g == 0 && b == 0) {
				return getMyColorScheme(i, i, i, alpha);
			}
			if ( r > 0 && r < i ) r = i;
			if ( g > 0 && g < i ) g = i;
			if ( b > 0 && b < i ) b = i;

			return getMyColorScheme(r / factor, g / factor, b / factor, alpha);
		}

		public static function getMyColorScheme(r : uint, g : uint, b : uint, a : Number = 1) : MyColorScheme {
			return new MyColorScheme(getRGBWith(r, g, b), a);
		}

		public static function getWithARGB(argb : uint) : MyColorScheme {
			var rgb : uint = argb & 0x00FFFFFF;
			var alpha : Number = (argb >>> 24) / 255;
			return new MyColorScheme(rgb, alpha);
		}

		public static function getMyColorSchemeWithHLS(h : Number, l : Number, s : Number, a : Number = 1) : MyColorScheme {
			var c : MyColorScheme = new MyColorScheme(0, a);
			c.hlsCounted = true;
			c.hue = Math.max(0, Math.min(1, h));
			c.luminance = Math.max(0, Math.min(1, l));
			c.saturation = Math.max(0, Math.min(1, s));

			var H : Number = c.hue;
			var L : Number = c.luminance;
			var S : Number = c.saturation;

			var p1 : Number, p2 : Number, r : Number, g : Number, b : Number;
			p1 = p2 = 0;
			H = H * 360;
			if (L < 0.5) {
				p2 = L * (1 + S);
			} else {
				p2 = L + S - L * S;
			}
			p1 = 2 * L - p2;
			if (S == 0) {
				r = L;
				g = L;
				b = L;
			} else {
				r = hlsValue(p1, p2, H + 120);
				g = hlsValue(p1, p2, H);
				b = hlsValue(p1, p2, H - 120);
			}
			r *= 255;
			g *= 255;
			b *= 255;
			var color_n : Number = (r << 16) + (g << 8) + b;
			var color_rgb : uint = Math.max(0, Math.min(0xFFFFFF, Math.round(color_n)));
			c.rgb = color_rgb;
			return c;
		}

		private static function hlsValue(p1 : Number, p2 : Number, h : Number) : Number {
			if (h > 360) h = h - 360;
			if (h < 0) h = h + 360;
			if (h < 60 ) return p1 + (p2 - p1) * h / 60;
			if (h < 180) return p2;
			if (h < 240) return p1 + (p2 - p1) * (240 - h) / 60;
			return p1;
		}

		public static function getRGBWith(rr : uint, gg : uint, bb : uint) : uint {
			var r : uint = rr;
			var g : uint = gg;
			var b : uint = bb;
			if (r > 255) {
				r = 255;
			}
			if (g > 255) {
				g = 255;
			}
			if (b > 255) {
				b = 255;
			}
			var color_n : uint = (r << 16) + (g << 8) + b;
			return color_n;
		}

		public function toString() : String {
			return "MyColorScheme(rgb:" + rgb.toString(16) + ", alpha:" + alpha + ")";
		}

		public function equals(c : MyColorScheme) : Boolean {
			if (c != null) {
				return c.alpha === alpha && c.rgb === rgb;
			} else {
				return false;
			}
		}

		public function clone() : MyColorScheme {
			return new MyColorScheme(getRGB(), getAlpha());
		}
	}
}