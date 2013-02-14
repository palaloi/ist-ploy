function PGLoader(params) {
	this.params = this.merge({
		element:	document.body,
		radius:		10,
		thickness:	4,
		size:		0.3,
		color:		'#3f3f3f',
		start:		0,
		speed:		0.5,
		fps:		100,
		direction:	'cw'
	}, params);
	this.params.size = this.params.size > 1 ? 1 : this.params.size;
	this.params.thickness = this.params.thickness > this.params.radius ? this.params.radius : this.params.thickness;
	this.params.start = this.params.start > 1 ? 1 : this.params.start;
	this.params.direction = this.params.direction == 'ccw' ? 'ccw' : 'cw';
	this.paper = new Raphael(this.params.element, this.params.radius * 2 + 1, this.params.radius * 2 + 1);
	this.paper.customAttributes.arcStart = this.arcStartFunction;
	this.paper.customAttributes.arc = this.arcFunction;
	this.path = this.paper.path().attr({stroke: this.params.color, 'stroke-width': this.params.thickness, arcStart: this.params.start}).attr({arc: [this.params.size, 1, this.params.radius]});
	this.started = new Date().getTime();
	this.interval = null;
	this.show();
};

PGLoader.prototype.show = function() {
	this.hide();
	this.paper.canvas.style.display = 'block';
	this.interval = setInterval((function(pgo) { return function() {
		pgo.path.attr({arcStart: (((new Date().getTime() - pgo.started) / 1000) * pgo.params.speed * (pgo.params.direction == 'cw' ? 1 : -1)) % 1.0});
	}; })(this), 1000 / this.params.fps);
};

PGLoader.prototype.hide = function() {
	if (this.interval == null)
		return;
	clearInterval(this.interval);
	this.interval = null;
	this.paper.canvas.style.display = 'none';
};

PGLoader.prototype.merge = function(a, b) {
	var c = {};
	for (var k in a)
		c[k] = a[k];
	for (var k in b)
		c[k] = b[k];
	return c;
};

PGLoader.prototype.arcFunction = function(v, t, R) {
	var d = R;
	R -= (typeof this.attrs['stroke-width'] == 'undefined' ? 0 : Math.ceil(this.attrs['stroke-width'] / 2));
	var s = typeof this.attrs.arcStart == 'undefined' ? 0 : (typeof this.attrs.arcStart[0] == 'undefined' ? this.attrs.arcStart : this.attrs.arcStart[0]);
	var a1 = (90 - (360 / t * (v + s))) * Math.PI / 180;
	var a2 = (90 - (360 / t * s)) * Math.PI / 180;
	var x1 = d + R * Math.cos(a1);
	var y1 = d - R * Math.sin(a1);
	var x2 = d + R * Math.cos(a2);
	var y2 = d - R * Math.sin(a2);
	return {path: [['M', x2, y2], ['A', R, R, 0, +(Math.abs(360 / t * v) > 180), 1, x1, y1]]};
};

PGLoader.prototype.arcStartFunction = function(v) { return typeof this.attrs.arc == 'undefined' ? {} : {arc: this.attrs.arc}; };

PGLoader.prototype.change = function(parameters) {
	var r = this.params.radius;
	var d = this.params.direction;
	var s = this.params.speed;
	this.params = this.merge(this.params, parameters);
	this.params.size = this.params.size > 1 ? 1 : this.params.size;
	this.params.thickness = this.params.thickness > this.params.radius ? this.params.radius : this.params.thickness;
	this.params.start = this.params.start > 1 ? 1 : this.params.start;
	this.params.direction = this.params.direction == 'ccw' ? 'ccw' : 'cw';
	if (s != this.params.speed) {
		if (s == 0.00000001)
			this.show();
		if (this.params.speed == 0) {
			clearInterval(this.interval);
			this.params.speed = 0.00000001;
		}
		var n = new Date().getTime();
		this.started = ((n * this.params.speed) - ((n - this.started) * s)) / this.params.speed;
	}
	if (d != this.params.direction)
		this.started = new Date().getTime() + this.path.attrs.arcStart * 1000 / this.params.speed * (this.params.direction == 'cw' ? -1 : 1);
	this.path.animate({'stroke-width': this.params.thickness, stroke: this.params.color}, 500, '>');
	var t = 500;
	if (this.params.radius > r)
		t = 0;
	setTimeout((function(pgo) { return function() {
		pgo.paper.setSize(pgo.params.radius * 2 + 1, pgo.params.radius * 2 + 1);
	}; })(this), t);
	this.path.animate({arc: [this.params.size, 1, this.params.radius]}, 500, '>');
};