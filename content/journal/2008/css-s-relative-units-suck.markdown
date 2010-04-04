These days, the recommended approach for setting all widths, heights and sizes in CSS is using relative units (e.g. `em` and `%`) instead of absolute units (e.g `pt` and `px`). Doing so has the advantage that the entire page "zooms" when the font size is changed, meaning that the proportions of all elements on the page are preserved.

With the recent [redesign](/journal/2008/minimal-earth/), however, Stoneship has—deliberately—gone from a layout set in _relative_ units to a layout set in _absolute_ units.

The reason why is because there is almost no point in using relative units anymore, as all browsers have or are getting full page zoom. Full page zoom, for those that don't know, gives browsers the ability to zoom pages as if you were using `em`'s, except you're not using `em`'s at all. Opera and Internet Explorer (!) already have it; Firefox and Safari are getting it soon.

So, why still bother?

The only real reason for still using `em`'s or `%`'s is backward compatibility. People with older browsers may still want to have that full page zoom effect after all. However, if you really want full page zoom everywhere, why not ditch your old browser and upgrade? Also, it's not like you are preventing people with older browsers from viewing your site—the content is still there, but without full page zoom… so what?

I admit it's a bit early to completely banish `em`'s everywhere, but once full page zoom is incorporated in all modern browsers, there's no need to bother anymore. Be lazy and use absolute units, like I did.
