function setup_rollover(name)
{
	banner = document.getElementById('banner-' + name);
	if(banner)
	{
		image = new Image();
		image.src = '/media/images/banners/' + name + '-on.png';

		banner.onmouseover	= function() { this.src = '/media/images/banners/' + name + '-on.png'; }
		banner.onmouseout	= function() { this.src = '/media/images/banners/' + name + '-off.png'; }
	}
}

window.onload = function()
{
	setup_rollover('alurio');
	setup_rollover('euromysterium');
	setup_rollover('mublogs');
	setup_rollover('nanoc');
	setup_rollover('stoneship');
	setup_rollover('uruvote');
}
