package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import flixel.addons.ui.FlxButtonPlus;

using StringTools;

class PlayState extends FlxState
{
	var json:Dynamic = Json.parse(File.getContent('assets/name.json'));

	var itWEBSITE:Array<String> = [];
	var itname:Array<String> = [];
	var itpassword:Array<String> = [];

	var it:Int = 0;

	var size:Int = 25;

	var name:FlxText;
	var password:FlxText;
	var UI:FlxText;
	var WEBSITE:FlxText;
	var SCP:FlxSprite;
	var whiteScreen:FlxSprite;

	var lt:FlxText;
	var rt:FlxText;

	var china:FlxButtonPlus;
	var english:FlxButtonPlus;

	var rti:Int = 0;
	var ps:Array<String> = ["方便存储密码软件", "Password Software"];
	var na:Array<String> = ["名称: ", "Name: "];
	var pw:Array<String> = ["密码: ", "Password: "];
	var lcs:Array<String> = ["左击开关", "Left-click switch"];
	var rcs:Array<String> = ["右击开关", "Right-click switch"];

	override public function create()
	{
		super.create();

		itWEBSITE = json.itWEBSITE;
		itname = json.itname;
		itpassword = json.itpassword;

		persistentUpdate = persistentDraw = true;

		whiteScreen = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.WHITE);
		add(whiteScreen);

		SCP = new FlxSprite(0, FlxG.height * 0.75).loadGraphic(Paths.image('discord'));
		SCP.antialiasing = false;
		add(SCP);

		UI = new FlxText(0, FlxG.height * 0.05, FlxG.width, ps[rti], 20);
		UI.setFormat(Paths.font('vcr.ttf'), 50, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UI.antialiasing = true;
		add(UI);

		WEBSITE = new FlxText(0, FlxG.height * 0.2, FlxG.width, itWEBSITE[it], 20);
		WEBSITE.setFormat(Paths.font('vcr.ttf'), 40, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		WEBSITE.antialiasing = true;
		add(WEBSITE);

		name = new FlxText(0, FlxG.height * 0.4, FlxG.width, na[rti] + itname[it], 20);
		name.setFormat(Paths.font('vcr.ttf'), size, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		name.antialiasing = true;
		add(name);

		password = new FlxText(0, FlxG.height * 0.5, FlxG.width, pw[rti] + itpassword[it], 20);
		password.setFormat(Paths.font('vcr.ttf'), size, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UI.antialiasing = true;
		add(password);

		lt = new FlxText(FlxG.width * -0.4, FlxG.height * 0.95, FlxG.width, lcs[rti], 20);
		lt.setFormat(Paths.font('vcr.ttf'), 10, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		lt.antialiasing = true;
		add(lt);

		rt = new FlxText(FlxG.width * 0.4, FlxG.height * 0.95, FlxG.width, rcs[rti], 20);
		rt.setFormat(Paths.font('vcr.ttf'), 10, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		rt.antialiasing = true;
		add(rt);

		var wh:Int = 60;

		china = new FlxButtonPlus(FlxG.width * 0.3, FlxG.height * 0.95, updateChinaLanguage, 'China Language', wh, wh);
		china.antialiasing = true;
		add(china);

		english = new FlxButtonPlus(FlxG.width * 0.6, FlxG.height * 0.95, updateEnglishLanguage, 'English Language', wh, wh);
		english.antialiasing = true;
		add(english);

		updateChinaLanguage();
	}

	function updateChinaLanguage():Void
	{
		rti = 0;
		UI.text = ps[rti];
		name.text = na[rti] + itname[it];
		password.text = pw[rti] + itpassword[it];
		lt.text = lcs[rti];
		rt.text = rcs[rti];
	}

	function updateEnglishLanguage():Void
	{
		rti = 1;
		UI.text = ps[rti];
		name.text = na[rti] + itname[it];
		password.text = pw[rti] + itpassword[it];
		lt.text = lcs[rti];
		rt.text = rcs[rti];
	}

	function updatetext():Void
	{
		if (it < 0)
			it = itWEBSITE.length-1;
		if (it > itWEBSITE.length-1)
			it = 0;

		WEBSITE.text = itWEBSITE[it];
		name.text = na[rti] + itname[it];
		password.text = pw[rti] + itpassword[it];
			FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.LEFT)
		{
			it--;
			updatetext();
		}
		else if (FlxG.keys.justPressed.RIGHT)
		{
			it++;
			updatetext();
		}
	}
}
