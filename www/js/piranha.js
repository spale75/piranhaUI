/*
 * Copyright 2017 Pascal Gloor
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

var piranha = {

	"conf": {
		"cgi": "cgi/piranha.fcgi",
		"pages": [
			'about',
			'dashboard',
			'status',
			'peer',
			'top100',
			'lookup',
			'vis',
			'system',
			'test',
		],
		"tmpl": 'tmpl/piranha_template_',
		"default": {
			"modulo": 60,
		},
		"var": {
		},
		"loading_spinner": {
			"lines"     : 16,
			"length"    : 20,
			"width"     : 10,
			"radius"    : 30,
			"scale"     : 1,
			"corners"   : 1,
			"color"     : '#000',
			"opacity"   : 0.15,
			"rotate"    : 0,
			"direction" : 1,
			"speed"     : 1,
			"trail"     : 60,
			"fps"       : 20,
			"zIndex"    : 2e9,
			"className" : 'spinner',
			"top"       : '50%',
			"left"      : '50%',
			"shadow"    : false,
			"hwaccel"   : false,
			"position"  : 'absolute',
		},
	},

	"re": function(str, set) {

		switch(set) {
			// Don't overcomplicate things ...
			case "asn"   : return str.match(/^\d{1,10}$/);
			case "aspath": return str.match(/^\d{1,10}( \d{1,10})*$/);
			// CIDR IPv4/IPv6 regex from regexpal.com
			case "ip4"   : return str.match(/^([0-9]{1,3}\.){3}[0-9]{1,3}(\/([0-9]|[1-2][0-9]|3[0-2]))?$/);
			case "ip6"   : return str.match(/^s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:)))(%.+)?s*(\/([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-8]))?$/);
		}
		return null;
	},
	
	"init": function() {

		window.onhashchange = this.pageevent;
	
		var spin = new Spinner(this.conf.loading_spinner).spin();
		$('#piranha_loading_spin').html(spin.el);
	
	
		this.pageevent({ newURL: location.href });

		// register permanent/dynamic events
		$('body').on('click', 'div.piranha_route_click', function() {
			piranha.auto.routes.colclick(this);
		});

		$('body').on('click', 'div.piranha_route_move',  function() {
			piranha.auto.routes.update(this);
		});

		$('body').on('click', 'a.piranha_footinfo_click', function() {
			piranha.footinfo.lookup(this);
		});

		$('body').on('click', 'div.piranha_vis_proto', function() {
			piranha.page.vis.proto_update(this);
		});

		$(window).resize(function() {
			piranha.helper.resize();
		});

		// register footer functions
		$('.piranha_footer_clear').click(this.footinfo.clear);
		$('.piranha_footer_scroll_back').click(this.footinfo.scroll_back);
		$('.piranha_footer_scroll_fwd').click(this.footinfo.scroll_fwd);

		piranha.helper.resize();

	},

	"gettemplate": function(name, cb) {
		$.get(this.conf.tmpl + name + '.html')
		.done(function(data) {
			var tmpl = $($('<dummy>').append($.parseHTML(data))).children().html();
			cb(tmpl);
		})
		.fail(function( jqxhr, textStatus, error ) {
			console.log( "Request Failed: " + error );
			cb('<div class="alert alert-danger" role="alert">' + error + '</span>');
		});
	},

	"spinner": function(state) {
		if ( state )
			$('#piranha_loading').fadeIn(100);
		else
			$('#piranha_loading').fadeOut(100);
	},

	"loadpage": function(newpage, subpage) {

		this.spinner(1);

		this.gettemplate(newpage, function(x) {

			$("#piranha_body").html(x);

			$.each($("div[class^='piranha_template_']"), function(id, obj) {
				var re = $(obj).attr('class').match('(^| )piranha_template_([^ $]+)');
				piranha.gettemplate(re[2], function(x) {
					$(obj).html(x);
				});
			});

			piranha.helper.resize();

			if ( piranha.page[newpage] ) {
				if ( piranha.page[newpage].init ) {
					piranha.page[newpage].init(subpage);
				}
				else {
					piranha.page[newpage](subpage);
				}
			}
			else {
				console.log("function '" + newpage + "' does not exist");
				piranha.spinner(0);
			}

			$.getJSON(piranha.helper.url(piranha.conf.cgi, { "mode": "peerlist" }))
			.done(function(d) {
	
				$('.piranha_navbar_peer_template:not(:first)').remove();
				$('.piranha_peer_select:not(:first)').remove();

				$.each(d.peer,function(id,p) {
					var obj = $('.piranha_navbar_peer_template').first().clone().removeClass('hide');
					$(obj).find('a').html('AS'+p.asn+' ('+p.ip+') ' + p.descr);
					$(obj).find('a').attr('href', '#peer/'+ p.id);
					$('.piranha_navbar_peer_template').parent().append(obj);
		
					obj = $("<option>", { value: p.id });
					obj.html('AS'+p.asn+' ('+p.ip+') ' + p.descr);
					$('.piranha_peer_select').append(obj);

				});
				var spick = $('.piranha_peer_select').clone().removeClass('hide piranha_peer_select');
				$('.piranha_peer_select').parent().append(spick);
				$(spick).attr('name','peerid');
				$(spick).selectpicker();
				$('select').selectpicker();
			})
			.fail(function(jqxhr, textStatus, error) {
				var err = textStatus + ": " + error;
				console.log( "Request Failed: " + err );
			});
		});
	},

	"pageevent": function(e) {
		var page    = null;
		var subpage = null;

		if ( e && e.newURL && e.newURL.split('#').length>1 ) {
			var x = e.newURL.split('#')[1].split('/');
			if ( x.length > 0 && piranha.conf.pages.indexOf(x[0])>=0 ) {
				page = x[0];
				if ( x.length == 2 ) {
					subpage = x[1];
				}
			}
		}

		if ( ! page ) {
			page = piranha.conf.pages[0];
			subpage = null;
		}

		$('.piranha_navbar').children().children().each(function(id, obj) {
			if ( $(obj).find('a').attr('href').split('#')[1] == page ) { $(obj).addClass('active'); }
			else { $(obj).removeClass('active'); }
		});
	
		piranha.loadpage(page, subpage);
	},


	"page": {
		"dashboard": function(sub) {

			$.getJSON(piranha.helper.url(piranha.conf.cgi, { "mode": "stats" }))
			.done(function(d) {

				$('.piranha_val_peers').html(d.peer.length);
				$('.piranha_val_ipv4_valid').html(piranha.helper.easynum(d.global.ipv4.valid));
				$('.piranha_val_ipv4_invalid').html(piranha.helper.easynum(d.global.ipv4.invalid));
				$('.piranha_val_ipv6_valid').html(piranha.helper.easynum(d.global.ipv6.valid));
				$('.piranha_val_ipv6_invalid').html(piranha.helper.easynum(d.global.ipv6.invalid));
	
				var data = { };
				var pdata = { };
				var total = 0;
				for(var mask in d.global.ipv4.mask) {
					data[mask] = Math.floor(d.global.ipv4.mask[mask] / d.global.ipv4.valid * 10000)/100;
					total += d.global.ipv4.mask[mask] * Math.pow(2,8-mask);
				}
				for(var mask in d.global.ipv4.mask) {
					pdata[mask] = Math.floor(d.global.ipv4.mask[mask] * Math.pow(2,8-mask) / total * 10000)/100;
				}
	
				piranha.morris.mask('piranha_graph_ipv4', 4, data, '%');
				piranha.morris.mask('piranha_graph_ipv4_pond', 4, pdata, '%');
	
				data = { };
				pdata = { };
				total = 0;
				for(var mask in d.global.ipv6.mask) {
					data[mask] = Math.floor(d.global.ipv6.mask[mask] / d.global.ipv6.valid * 10000)/100;
					total += d.global.ipv6.mask[mask] * Math.pow(2,32-mask);
				}
				for(var mask in d.global.ipv6.mask) {
					pdata[mask] = Math.floor(d.global.ipv6.mask[mask] * Math.pow(2, 32-mask) / total * 10000)/100;
				}
	
				piranha.morris.mask('piranha_graph_ipv6', 6, data, '%');
				piranha.morris.mask('piranha_graph_ipv6_pond', 6, pdata, '%');
	
	
	
				var up = 0;
				var down = 0;
	
				$.each(d.peer, function(id, p) {
					up   += p.state ? 1 : 0;
					down += p.state ? 0 : 1;
				});
	
				$('.piranha_val_peers_up').html(up);
				$('.piranha_val_peers_down').html(down);
	
				$('#piranha_loading').fadeOut();
		
	
			})
			.fail(function(jqxhr, textStatus, error) {
				var err = textStatus + ": " + error;
				alert( "Request Failed: " + err );
			});
		},

		"status": function(sub) {
			$.getJSON(piranha.helper.url(piranha.conf.cgi, { "mode": "peerlist" }))
			.done(function(d) {
	
				// cleanup peerlist
				$('.piranha_template_peerlist').parent().children().each(function(index) {
					if ( index != 0 )
						$(this).remove();
				});
		
				$.each(d.peer, function(id, p) {
					var obj = $('.piranha_template_peerlist').first().clone();
					$('.piranha_template_peerlist').parent().append(obj);
		
					piranha.autofill(obj, p);
					$(obj).removeClass('hide');
				});
	
				piranha.spinner(0);
			})
			.fail(function(jqxhr, textStatus, error) {
				var err = textStatus + ": " + error;
				console.log( "Request Failed: " + err );
			});
		},

		"peer": {
			"init": function(peerid) {
		
				$.getJSON(piranha.helper.url(piranha.conf.cgi, { "mode": "peer", "peerid": peerid }))
				.done(function(d) {
		
					var p = d.peer;
					var obj = $('#piranha_body');

					piranha.autofill(obj, p);
			
					if ( p.mask )
						piranha.morris.peer_mask('piranha_peer_graph_mask', p.ip4 ? 4 : 6, p.mask);
			
					piranha.page.peer.update_graph(p.id);
			
					$('#piranha_peer_graph_update_btn').children().each(function(idx) {
						var modulo = piranha.conf.default.modulo;
						switch($(this).html()) {
							case '1m' : modulo=60;    break;
							case '5m' : modulo=300;   break;
							case '15m': modulo=900;   break;
							case '1h' : modulo=3600;  break;
							case '1d' : modulo=86400; break;
						};
						$(this).off('click');
			
						$(this).click(
							{ 'id': p.id, 'modulo': modulo },
							function(x) {
								$(this).parent().children().removeClass('active');
								$(this).addClass('active');
								piranha.page.peer.update_graph(x.data.id, x.data.modulo);
							}
						);
					});

					piranha.auto.routes.init({ "mode": "peer_last", "peerid": peerid, "pagesize": 100, "page": 0 },
						"route", "hide_nexthop:hide_peer_ip:hide_peer_asn:hide_flap_a:hide_flap_w");
			
					piranha.spinner(0);
				})
				.fail(function(jqxhr, textStatus, error) {
					var err = textStatus + ": " + error;
					console.log( "Request Failed: " + err );
				});
			},
			"update_graph": function(id, modulo) {
	
				if ( !modulo )
					modulo = piranha.conf.default.modulo;
	
				$.getJSON(piranha.helper.url(piranha.conf.cgi, { "mode": "graph", "modulo": modulo, "peerid": id }))
				.done(function(d) {
					piranha.morris.peer_update("piranha_peer_graph_update", d.data);

					$('.piranha_event_row:not(:first)').remove();

					for(var i=0; i<d.event.length; i++) {
						row = $(".piranha_event_row").first().clone().removeClass("hide");
						piranha.autofill(row, d.event[i]);
						$('.piranha_event_row').parent().append(row);
					}
				})
				.fail(function(jqxhr, textStatus, error) {
					var err = textStatus + ": " + error;
					console.log( "Request Failed: " + err );
				});
			},
		},
		"top100": {
			"init": function(sub) {
				$.each($('#piranha_body').find("form").find("select"), function(id, obj) {
					$(obj).change(piranha.page.top100.update);
				});
				$.each($('#piranha_body').find("form").find("button"), function(id, obj) {
					$(obj).click(piranha.page.top100.btn);
				});
				piranha.spinner(0);
			},
			"btn": function(x) {
				$(x.target).parent().children().removeClass('active btn-warning');
				$(x.target).addClass('active btn-warning');
				piranha.page.top100.update(x);
			},
			"update": function(x) {

				var form = $(x.target).closest('form');
			
				var isButtonPressed = function(form, name) {
					return $(form).find("[name="+name+"]").hasClass("active")
				};
			
				var qs = {
					'mode'    : 'top100',
					'proto'   : isButtonPressed(form,'ipv4') ? 4 : 6,
					'peerid'  : $(form).find("[name=peerid]").val(),
					'list'    : $(form).find("[name=query]").val(),
					'valid'   : ( isButtonPressed(form,'valid_dual') || isButtonPressed(form,'valid_on')  ) ? true : false,
					'invalid' : ( isButtonPressed(form,'valid_dual') || isButtonPressed(form,'valid_off') ) ? true : false,
					'pagesize': 100,
					'page'    : 0,
				};

				if ( qs['list'] == '' ) {
					piranha.spinner(0);
					return;
				}

				opt = 'nav';
				if ( qs.list == 'flaps' )
					opt = 'nonav';

				opt += ":hide_nexthop:hide_community";

				piranha.auto.routes.init(qs, 'route', opt);
			},
		},
		"lookup": {
			"init": function(x) {

				$.each($('#piranha_body').find('.piranha_form_originas').find('button'), function(id, obj) {
					$(obj).click(piranha.page.lookup.originasbtn);
				});

				$.each($('#piranha_body').find('.piranha_form_prefix').find('button'), function(id, obj) {
					$(obj).click(piranha.page.lookup.prefix);
				});

				piranha.spinner(0);

			},
			"originasbtn": function(x) {

				if ( $(x.target).attr('name') ) {
					$(x.target).parent().children().removeClass('active btn-warning');
					$(x.target).addClass('active btn-warning');
				}
				else {
					piranha.page.lookup.originas(x.target);
				}

			},
			"originas": function(x) {
	
				var input  = $(x).parent().children('.piranha_search_input').val();
				var result = $('#piranha_body').find('.piranha_search_result');
				var proto  = $(x).parent().find('[name=ipv4]').hasClass('active') ? 4 : 6;
				var peerid = $('#piranha_body').find('[name=peerid]').val();
			
				$(result).find('.piranha_template_search').parent().children().not('.piranha_template_search').remove();
			
				piranha.auto.routes.init({
					"mode": "search_originas",
					"asn": input,
					"proto": proto,
					"peerid": peerid,
					"pagesize": 100,
					"page": 0
					}, 'route', "hide_nexthop");
			},
			
			"prefix": function(e) {
				var x = e.target;

				var input  = $(x).parent().children('.piranha_search_input').val();
				var result = $('#piranha_body').find('.piranha_search_result');
				var peerid = $('#piranha_body').find('[name=peerid]').val();
			
				$(result).find('.piranha_template_search').parent().children().not('.piranha_template_search').remove();

				piranha.auto.routes.init({
					"mode": "search_prefix",
					"prefix": input,
					"peerid": peerid,
					"pagesize": 100,
					"page": 0
					}, 'route', "hide_nexthop");
			},
		},
		"vis": {
			"init": function(x) {
				if ( ! x ) {
					piranha.spinner(false);
					return;
				}
				else {
					$('#piranha_vis').data('piranha', { "type": x, "proto": 4 });
					piranha.page.vis.draw();
				}

				piranha.spinner(false);
			},

			"proto_update": function(e) {
				$(e).parent().children().each(function() {
					$(this).removeClass("active btn-warning");
				});
				$(e).addClass("active btn-warning");

				var data = $('#piranha_vis').data('piranha');
				data.proto = $(e).html().match(/IPv4/) ? 4 : 6;

				piranha.spinner(true);
				piranha.page.vis.draw();
			},

			"draw": function() {
				var data = $('#piranha_vis').data('piranha');
				$('#piranha_vis').html('');
				piranha.page.vis.vis[data.type](data);
			},

			"vis": {
				"bgp_updates": function(gconf) {

					$.getJSON(piranha.helper.url(piranha.conf.cgi, { "mode": "vis_bgp_updates", "proto": gconf.proto }))
					.done(function(d) {
						piranha.spinner(false);

						var g = new vis.DataSet();

						var pmul = Math.ceil(360 / d.peer.length / 100)*10;

						for(var i=0; i<d.vis.length; i++) {
							var time = d.vis[i][0];
							var data = d.vis[i][1];

							for(var p=0; p<data.length; p++) {
								var x = p * pmul;
								var y = time;
								var z = data[p]['a'];

								var gd = { x:x, y:y, z:z };
								g.add(gd);
							}
						}

						var dd = $("#piranha_vis").data("piranha");
						dd['vis'] = { };
						for(var i=0; i<d.peer.length; i++) {
							dd['vis'][i*pmul] = d.peer[i];
						}

						var options = {
							width:  '100%',
							height: '100%',
							style: 'bar',
							showPerspective: true,
							showAnimationControls: true,
							showGrid: true,
							showShadow: false,
							keepAspectRatio: true,
							tooltip: function(d) {
								var x = $('#piranha_vis').data('piranha');
								return x.vis[d.x].descr + " sent " + d.z + " updates " + d.y + "min ago";
							},
							xLabel: "Peers",
							yLabel: "Time (min)",
							zLabel: "BGP Updates",
							xBarWidth: pmul/4,
							xStep: pmul,
							xValueLabel: function(x) {
								var d = $('#piranha_vis').data('piranha');
								console.log(x);
								if ( d.vis[x] )
									return d.vis[x].descr + " / AS" + d.vis[x].asn;
								return "";
							},
							//xMin: 0 - pmul,
							//xMax: d.peer.length * pmul,
							cameraPosition: { distance: 2 },
							xStep: 10,
						};
		
						var container = document.getElementById('piranha_vis');
						var graph3d = new vis.Graph3d(container, g, options);
					})
					.fail(function(jqxhr, textStatus, error) {
						var err = textStatus + ": " + error;
						console.log( "Request Failed: " + err );
					});
				},
				"demo3d": function() {

					var data = new vis.DataSet();
					var counter = 0;
					var steps = 50;
			   		var axisMax = 359;
					var axisStep = axisMax / steps;
					for (var x = 0; x < axisMax; x+=axisStep) {
						for (var y = 0; y < axisMax; y+=axisStep) {
							var value = (Math.sin(x/50) * Math.cos(y/50) * 50 + 50);
							data.add({id:counter++,x:x,y:y,z:value,style:value});
						}
					}

					var wmin = 200;
					var wmax = 1000;
					var w = $(window).width() - 200;

					if ( w < wmin )
						w=wmin;
					else if ( w > wmax )
						w=wmax;

					h = Math.floor(w * .80);
				

					// specify options
					var options = {
						width:  '100%',
						height: '800px',
						style: 'surface',
						showPerspective: true,
						showGrid: true,
						showShadow: false,
						keepAspectRatio: true,
						verticalRatio: 0.5
					};
	
					// Instantiate our graph object.
					var container = document.getElementById('piranha_vis');
					var graph3d = new vis.Graph3d(container, data, options);
	
				},
			},
		},
		"system": function(x) {
	
			$.getJSON(piranha.helper.url(piranha.conf.cgi, { "mode": "config", "action": "get" }))
			.done(function(d) {
				piranha.autofill($('#piranha_body'), d.conf);
				piranha.spinner(0);
			})
			.fail(function(jqxhr, textStatus, error) {
				var err = textStatus + ": " + error;
				console.log( "Request Failed: " + err );
			});
	
		},
	},

	"helper": {

		"easynum": function(num) {
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "'");
		},

		"url": function(url, args) {
			var arr = [ ];
			for (var name in args) {
				arr.push(encodeURIComponent(name) + "=" + encodeURIComponent(args[name]));
			}
			return url + '?' + arr.join('&') + "&nocache=" + Date.now();
		},
		"resize": function() {
			$('.piranha_resize_vis').css('height', $(window).height() - 400);
		},
	},

	"autofill": function(obj, data, path) {

		if ( !path )
			path = '';

		for(var name in data) {
			var val = data[name];
			switch(typeof data[name]) {
				case "number":
					val = val.toString();
				case "string":
					if ( val == null )
						val = 'n/a';

					$(obj).find('.piranha_val_'+path+name).each(function(index) {
						if ( $(this).hasClass("piranha_autofill_string") ) {
							if ( name.match(/(asn?|aspath)$/) && piranha.re(val,'aspath') ) {
								var s = val.split(' ');
								var all = '';
								for(var i=0; i<s.length; i++) {
									all += ' <a href="javascript:void(0)" class="piranha_footinfo_click">' + s[i] + '</a>';
								};
								val = all;
							}
							else if ( piranha.re(val,'ip4') || piranha.re(val, 'ip6') ) {
								val = '<a href="javascript:void(0)" class="piranha_footinfo_click">' + val + '</a>';
							}
				
							$(this).html(val);
						}
						else if ( $(this).hasClass("piranha_autofill_bool") ) {
							if ( val.search(/^(1|true)$/i) != -1 ) { $(this).removeClass('hide'); }
							else { $(this).addClass('hide'); }
						}
						else if ( $(this).hasClass("piranha_autofill_rbool") ) {
							if ( val.search(/^(1|true)$/i) != -1 )  { $(this).addClass('hide'); }
							else { $(this).removeClass('hide'); }
						}
						else if ( $(this).hasClass("piranha_autofill_switch") ) {
							if ( $(this).hasClass("piranha_switch_"+val) ) { $(this).removeClass("hide"); }
							else { $(this).addClass("hide"); }
						}
					});
					break;
				case "object":
					piranha.autofill(obj, data[name], name + '_');
					break;
			}
	
		}
	},

	"auto": {
		"routes": {
			"init": function(query, name, opt) {

				if ( opt ) {
					var os = opt.split(':');
					piranha.auto.routes.colreset();
					for(var i=0; i<os.length; i++) {
						if ( os[i] == 'nonav' ) {
							$('.piranha_routes_pager').hide();
						}
						else if ( os[i] == 'nav' ) {
							$('.piranha_routes_pager').show();
						}
						else {
							var re = os[i].match(/^hide_(.*)$/);
							if ( re ) {
								$('div[name="'+re[1]+'"]').trigger('click');
							}
						}
					}
				}

				$('.piranha_routes_results').data('piranha', { "query": query, "name": name });
				piranha.auto.routes.update($(".piranha_route_move_first"));

			},
			"update": function(btn) {

				re = $(btn).attr('class').match('piranha_route_move_([^ ]+)');

				if ( ! re )
					return;

				var data = $('.piranha_routes_results').data('piranha');

				if ( ! data )
					return;

				piranha.spinner(true);

				switch(re[1]) {
					case "first":
						data.query.page = 0;
						break;
					case "next":
						data.query.page += 1;
						break;
					case "prev":
						data.query.page -= 1;
						if ( data.query.page < 0 )
							data.query.page = 0;
						break;
				};

				$('.piranha_routes_row:not(:first)').remove();

				$.getJSON(piranha.helper.url(piranha.conf.cgi, data.query))
				.done(function(x) {
					if ( x.error ) {
						$('.piranha_routes_error')
							.html(x.error)
							.removeClass('hide')
							.show()
							.fadeOut(5000);
					}
					else {

						for(var id in x[data.name]) {
							var r = x[data.name][id];
							var obj = $('.piranha_routes_row').first().clone();
							$('.piranha_routes_row').parent().append(obj);
							piranha.autofill(obj, r);
							$(obj).removeClass('hide');
						}
					}
					piranha.spinner(false);
				})
				.fail(function(jqxhr, textStatus, error) {
					var err = textStatus + ": " + error;
					console.log( "Request Failed: " + err );
				});
			},
			"colreset": function() {
				$.each($('.piranha_routes_btn').find('div.piranha_route_click.disabled'), function(id, btn) {
					$(btn).click();
				});
			},
			"colclick": function(btn) {
				var tbl = $('.piranha_routes_results');
				var hdr = '.piranha_hdr_' + $(btn).attr('name');
				var val = '.piranha_val_' + $(btn).attr('name');
		
				if ( $(btn).hasClass('disabled') ) {
					$(btn).removeClass('disabled');
					$(tbl).find(hdr).show();
					$(tbl).find(val).show();
				}
				else {
					$(btn).addClass('disabled');
					$(tbl).find(hdr).hide();
					$(tbl).find(val).hide();
				}
			},
		},
	},

	"morris": {
		"mask": function(id, proto, data, suffix) {
			var mdata = [ ];
			var end = proto == 4 ? 32 : 128;
	
			for(var i=0; i<=end; i++) {
				if ( data[i] )
					mdata.push({ "y": i, "x": data[i]});
			}
	
			$('#'+id).html('');
	
			Morris.Bar({
				"element": id,
				"data": mdata,
				"xkey": "y",
				"ykeys": [ 'x' ],
				"labels": [ "" ],
				"hoverCallback": function(index, options, content, row) {
					return "<h4>/" + row.y + "</h4><strong>" + row.x + suffix + "</strong>";
				},
				"hideHover": 'auto'
			});
		},
		"peer_mask": function(id, proto, data) {
			var mdata = [ ];
			var end = proto == 4 ? 32 : 128;
	
			for(var i=0; i<=end; i++) {
				if ( data[i] )
					mdata.push({ "y": i, "x": data[i]});
			}
	
			$('#'+id).html('');
		
			Morris.Bar({
				"element": id,
				"data": mdata,
				"xkey": "y",
				"ykeys": [ 'x' ],
				"labels": [ "" ],
				"hoverCallback": function(index, options, content, row) {
					return "<h4>/" + row.y + "</h4><strong>" + piranha.helper.easynum(row.x) + "</strong>";
				},
				"hideHover": 'auto'
			});
		},
		"peer_update": function(id, data) {
	
			$('#'+id).html('');
	
			Morris.Line({
				"element": id,
				"data": data,
				"xkey": "ts",
				"ykeys": [ 'a', 'w' ],
				"labels": [ "Announce", "Withdrawn" ],
				"hoverCallback": function(index, options, content, row) {
					return "<h4>" + row.ts + "</h4>" + 
						"<table class='table table-condensed'>" +
						"<tr><th>Announce</th><td>" + piranha.helper.easynum(row.a) + "</td></tr>" +
						"<tr><th>Withdrawn</th><td>" + piranha.helper.easynum(row.w) + "</td></tr>" +
						"</table>";
				},
				"hideHover": 'auto'
			});
		},
	},
	"footinfo": {

		"lookup": function(btn) {

			var rdapdata = $(btn).html();
			var rdaptype = 'asn';

			if ( piranha.re(rdapdata, 'ip4') ) {
				rdaptype = 'ip4';
			}
			else if ( piranha.re(rdapdata, 'ip6') ) {
				rdaptype = 'ip6';
			}
			
			$('.piranha_template_footer, .piranha_footer_scroll').addClass('hide');
			$('.piranha_footer_default').show();
			$('.piranha_template_footer:not(:first)').remove();
			$('.piranha_footer').fadeIn();
		
			piranha.autofill($('.piranha_footer_scroll'), {
					'cur'   : 0,
					'total' : 0,
					'error' : null,
					'obj'   : null
				});


		
			$.getJSON(piranha.helper.url(piranha.conf.cgi, { "mode": "rdap", "rdaptype": rdaptype, "rdapdata": rdapdata }))
			.done(function(d) {
		
				var vcard = [ ];
				var grab_vcard = function(x,y) {
					if ( ! y ) { y = [ ]; }
		
					switch(typeof x) {
						case 'object':
							$.each(x, function(idx, val) {
								if ( idx == 'vcardArray' ) {
									y.push(val);
								}
								else {
									grab_vcard(val,y);
								}
							});
							break;
						case 'number':
						case 'string':
							break;
					}
					return y;
				};
		
				if ( 'rdap' in d ) {
					var v = grab_vcard(d.rdap);
					var unique = { };
		
					$.each(v, function(idx, vc) {
						if ( vc.length == 2 && vc[0] == "vcard" ) {
							var c = vc[1];
							var myc = { };
							var ustr = '';
							$.each(c, function(idx, e) {
								if ( e.length >= 4 ) {
			
									if ( e[2] == 'text' && e[3] && typeof e[3] == 'string' )
										myc[e[0]] = e[3].replace(/(\\n|, )/g,'<br/>');
		
									if ( "label" in e[1] )
										myc[e[0]] = e[1]['label'].replace(/(\\n|, )/g,'<br/>');
		
									if ( e[0] in myc )
										ustr += e[0];
								}
							});
							if ( ! ( ustr in unique ) ) {
								unique[ustr] = 1;
								vcard.push(myc);
							}
						}
					});
				}
		
				$('.piranha_footer_default').hide();
		
				var data = {
					'cur'   : 'error' in d ? 0 : 1,
					'total' : vcard.length,
					'error' : 'error' in d ? d['error'] : '',
					'obj'   : rdapdata };
		
				piranha.autofill($('.piranha_footer_scroll'), data);
		
				$('.piranha_footer_scroll').removeClass('hide').data('piranha', data);
		
				$.each(vcard, function(index, x) {
					var o = $('.piranha_template_footer').first().clone().removeClass('hide');
		
					piranha.autofill(o, x);
		
					if ( index > 0 )
						$(o).hide();
					else
						$(o).fadeIn();
		
					$('.piranha_template_footer').parent().append(o);
				});
		
			})
			.fail(function(jqxhr, textStatus, error) {
				var err = textStatus + ": " + error;
				console.log( "Request Failed: " + err );
			});
			
		},

		"clear": function(x) {
			$('.piranha_footer').fadeOut();
			setTimeout(function() {
				$('.piranha_template_footer, .piranha_footer_scroll').addClass('hide');
				$('.piranha_footer_default').show();
			},1000);
		},

		"scroll_back": function(x) { piranha.footinfo.scroll(x.target, -1); },
		"scroll_fwd":  function(x) { piranha.footinfo.scroll(x.target,  1); },
		
		"scroll": function(o, cnt) {
			var data = $('.piranha_footer_scroll').data('piranha');
			var arr  = $('.piranha_template_footer:not(:first)')
			var old = data.cur;
		
			if ( data.error.length>0 )
				return;
		
			data.cur += cnt;
		
			if ( data.cur < 1 ) { data.cur = 1; }
			if ( data.cur > data.total ) { data.cur = data.total; }
		
			if ( old == data.cur )
				return;
		
			$('.piranha_footer_scroll').find('.piranha_val_cur').html(data.cur);
		
			$(arr).hide();
			$(arr[data.cur-1]).fadeIn();
		},
	},
};


$(document).ready(function() {
	piranha.init();
});

