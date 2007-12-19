function setup_rollover(id, base_url)
{
	element = document.getElementById(id);
	if(element)
	{
		image = new Image();
		image.src = base_url + '-on.png';

		element.onmouseover	= function() { this.src = base_url + '-on.png'; }
		element.onmouseout	= function() { this.src = base_url + '-off.png'; }
	}
}

function setup_banner_rollover(name)
{
	setup_rollover('banner-' + name, '/media/images/banners/' + name);
}

function setup_ad_rollover(name)
{
	setup_rollover('ad-' + name, '/media/images/ads/' + name);
}

window.onload = function()
{
	setup_banner_rollover('euromysterium');
	setup_banner_rollover('moul');
	setup_banner_rollover('mublogs');
	setup_banner_rollover('nanoc');
	setup_banner_rollover('nanoc-site');
	setup_banner_rollover('stoneship');
	setup_banner_rollover('uruvote');

	setup_ad_rollover('moul-5');
}
