
(function(l, r) { if (l.getElementById('livereloadscript')) return; r = l.createElement('script'); r.async = 1; r.src = '//' + (window.location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1'; r.id = 'livereloadscript'; l.head.appendChild(r) })(window.document);
var app = (function () {
    'use strict';

    function noop() { }
    function add_location(element, file, line, column, char) {
        element.__svelte_meta = {
            loc: { file, line, column, char }
        };
    }
    function run(fn) {
        return fn();
    }
    function blank_object() {
        return Object.create(null);
    }
    function run_all(fns) {
        fns.forEach(run);
    }
    function is_function(thing) {
        return typeof thing === 'function';
    }
    function safe_not_equal(a, b) {
        return a != a ? b == b : a !== b || ((a && typeof a === 'object') || typeof a === 'function');
    }

    function append(target, node) {
        target.appendChild(node);
    }
    function insert(target, node, anchor) {
        target.insertBefore(node, anchor || null);
    }
    function detach(node) {
        node.parentNode.removeChild(node);
    }
    function destroy_each(iterations, detaching) {
        for (let i = 0; i < iterations.length; i += 1) {
            if (iterations[i])
                iterations[i].d(detaching);
        }
    }
    function element(name) {
        return document.createElement(name);
    }
    function text(data) {
        return document.createTextNode(data);
    }
    function space() {
        return text(' ');
    }
    function empty() {
        return text('');
    }
    function listen(node, event, handler, options) {
        node.addEventListener(event, handler, options);
        return () => node.removeEventListener(event, handler, options);
    }
    function attr(node, attribute, value) {
        if (value == null)
            node.removeAttribute(attribute);
        else
            node.setAttribute(attribute, value);
    }
    function children(element) {
        return Array.from(element.childNodes);
    }
    function set_input_value(input, value) {
        if (value != null || input.value) {
            input.value = value;
        }
    }
    function custom_event(type, detail) {
        const e = document.createEvent('CustomEvent');
        e.initCustomEvent(type, false, false, detail);
        return e;
    }

    let current_component;
    function set_current_component(component) {
        current_component = component;
    }

    const dirty_components = [];
    const binding_callbacks = [];
    const render_callbacks = [];
    const flush_callbacks = [];
    const resolved_promise = Promise.resolve();
    let update_scheduled = false;
    function schedule_update() {
        if (!update_scheduled) {
            update_scheduled = true;
            resolved_promise.then(flush);
        }
    }
    function add_render_callback(fn) {
        render_callbacks.push(fn);
    }
    function flush() {
        const seen_callbacks = new Set();
        do {
            // first, call beforeUpdate functions
            // and update components
            while (dirty_components.length) {
                const component = dirty_components.shift();
                set_current_component(component);
                update(component.$$);
            }
            while (binding_callbacks.length)
                binding_callbacks.pop()();
            // then, once components are updated, call
            // afterUpdate functions. This may cause
            // subsequent updates...
            for (let i = 0; i < render_callbacks.length; i += 1) {
                const callback = render_callbacks[i];
                if (!seen_callbacks.has(callback)) {
                    callback();
                    // ...so guard against infinite loops
                    seen_callbacks.add(callback);
                }
            }
            render_callbacks.length = 0;
        } while (dirty_components.length);
        while (flush_callbacks.length) {
            flush_callbacks.pop()();
        }
        update_scheduled = false;
    }
    function update($$) {
        if ($$.fragment) {
            $$.update($$.dirty);
            run_all($$.before_update);
            $$.fragment.p($$.dirty, $$.ctx);
            $$.dirty = null;
            $$.after_update.forEach(add_render_callback);
        }
    }
    const outroing = new Set();
    let outros;
    function group_outros() {
        outros = {
            r: 0,
            c: [],
            p: outros // parent group
        };
    }
    function check_outros() {
        if (!outros.r) {
            run_all(outros.c);
        }
        outros = outros.p;
    }
    function transition_in(block, local) {
        if (block && block.i) {
            outroing.delete(block);
            block.i(local);
        }
    }
    function transition_out(block, local, detach, callback) {
        if (block && block.o) {
            if (outroing.has(block))
                return;
            outroing.add(block);
            outros.c.push(() => {
                outroing.delete(block);
                if (callback) {
                    if (detach)
                        block.d(1);
                    callback();
                }
            });
            block.o(local);
        }
    }
    function mount_component(component, target, anchor) {
        const { fragment, on_mount, on_destroy, after_update } = component.$$;
        fragment.m(target, anchor);
        // onMount happens before the initial afterUpdate
        add_render_callback(() => {
            const new_on_destroy = on_mount.map(run).filter(is_function);
            if (on_destroy) {
                on_destroy.push(...new_on_destroy);
            }
            else {
                // Edge case - component was destroyed immediately,
                // most likely as a result of a binding initialising
                run_all(new_on_destroy);
            }
            component.$$.on_mount = [];
        });
        after_update.forEach(add_render_callback);
    }
    function destroy_component(component, detaching) {
        if (component.$$.fragment) {
            run_all(component.$$.on_destroy);
            component.$$.fragment.d(detaching);
            // TODO null out other refs, including component.$$ (but need to
            // preserve final state?)
            component.$$.on_destroy = component.$$.fragment = null;
            component.$$.ctx = {};
        }
    }
    function make_dirty(component, key) {
        if (!component.$$.dirty) {
            dirty_components.push(component);
            schedule_update();
            component.$$.dirty = blank_object();
        }
        component.$$.dirty[key] = true;
    }
    function init(component, options, instance, create_fragment, not_equal, prop_names) {
        const parent_component = current_component;
        set_current_component(component);
        const props = options.props || {};
        const $$ = component.$$ = {
            fragment: null,
            ctx: null,
            // state
            props: prop_names,
            update: noop,
            not_equal,
            bound: blank_object(),
            // lifecycle
            on_mount: [],
            on_destroy: [],
            before_update: [],
            after_update: [],
            context: new Map(parent_component ? parent_component.$$.context : []),
            // everything else
            callbacks: blank_object(),
            dirty: null
        };
        let ready = false;
        $$.ctx = instance
            ? instance(component, props, (key, ret, value = ret) => {
                if ($$.ctx && not_equal($$.ctx[key], $$.ctx[key] = value)) {
                    if ($$.bound[key])
                        $$.bound[key](value);
                    if (ready)
                        make_dirty(component, key);
                }
                return ret;
            })
            : props;
        $$.update();
        ready = true;
        run_all($$.before_update);
        $$.fragment = create_fragment($$.ctx);
        if (options.target) {
            if (options.hydrate) {
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                $$.fragment.l(children(options.target));
            }
            else {
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                $$.fragment.c();
            }
            if (options.intro)
                transition_in(component.$$.fragment);
            mount_component(component, options.target, options.anchor);
            flush();
        }
        set_current_component(parent_component);
    }
    class SvelteComponent {
        $destroy() {
            destroy_component(this, 1);
            this.$destroy = noop;
        }
        $on(type, callback) {
            const callbacks = (this.$$.callbacks[type] || (this.$$.callbacks[type] = []));
            callbacks.push(callback);
            return () => {
                const index = callbacks.indexOf(callback);
                if (index !== -1)
                    callbacks.splice(index, 1);
            };
        }
        $set() {
            // overridden by instance, if it has props
        }
    }

    function dispatch_dev(type, detail) {
        document.dispatchEvent(custom_event(type, detail));
    }
    function append_dev(target, node) {
        dispatch_dev("SvelteDOMInsert", { target, node });
        append(target, node);
    }
    function insert_dev(target, node, anchor) {
        dispatch_dev("SvelteDOMInsert", { target, node, anchor });
        insert(target, node, anchor);
    }
    function detach_dev(node) {
        dispatch_dev("SvelteDOMRemove", { node });
        detach(node);
    }
    function listen_dev(node, event, handler, options, has_prevent_default, has_stop_propagation) {
        const modifiers = options === true ? ["capture"] : options ? Array.from(Object.keys(options)) : [];
        if (has_prevent_default)
            modifiers.push('preventDefault');
        if (has_stop_propagation)
            modifiers.push('stopPropagation');
        dispatch_dev("SvelteDOMAddEventListener", { node, event, handler, modifiers });
        const dispose = listen(node, event, handler, options);
        return () => {
            dispatch_dev("SvelteDOMRemoveEventListener", { node, event, handler, modifiers });
            dispose();
        };
    }
    function attr_dev(node, attribute, value) {
        attr(node, attribute, value);
        if (value == null)
            dispatch_dev("SvelteDOMRemoveAttribute", { node, attribute });
        else
            dispatch_dev("SvelteDOMSetAttribute", { node, attribute, value });
    }
    function set_data_dev(text, data) {
        data = '' + data;
        if (text.data === data)
            return;
        dispatch_dev("SvelteDOMSetData", { node: text, data });
        text.data = data;
    }
    class SvelteComponentDev extends SvelteComponent {
        constructor(options) {
            if (!options || (!options.target && !options.$$inline)) {
                throw new Error(`'target' is a required option`);
            }
            super();
        }
        $destroy() {
            super.$destroy();
            this.$destroy = () => {
                console.warn(`Component was already destroyed`); // eslint-disable-line no-console
            };
        }
    }

    /* src\FindPage.svelte generated by Svelte v3.12.1 */

    const file = "src\\FindPage.svelte";

    function get_each_context(ctx, list, i) {
    	const child_ctx = Object.create(ctx);
    	child_ctx.line = list[i];
    	return child_ctx;
    }

    // (20:1) {#each showLines as line}
    function create_each_block(ctx) {
    	var li, t_value = ctx.line + "", t;

    	const block = {
    		c: function create() {
    			li = element("li");
    			t = text(t_value);
    			add_location(li, file, 20, 2, 452);
    		},

    		m: function mount(target, anchor) {
    			insert_dev(target, li, anchor);
    			append_dev(li, t);
    		},

    		p: function update(changed, ctx) {
    			if ((changed.showLines) && t_value !== (t_value = ctx.line + "")) {
    				set_data_dev(t, t_value);
    			}
    		},

    		d: function destroy(detaching) {
    			if (detaching) {
    				detach_dev(li);
    			}
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_each_block.name, type: "each", source: "(20:1) {#each showLines as line}", ctx });
    	return block;
    }

    function create_fragment(ctx) {
    	var button, t1, input, t2, ul, dispose;

    	let each_value = ctx.showLines;

    	let each_blocks = [];

    	for (let i = 0; i < each_value.length; i += 1) {
    		each_blocks[i] = create_each_block(get_each_context(ctx, each_value, i));
    	}

    	const block = {
    		c: function create() {
    			button = element("button");
    			button.textContent = "Edit";
    			t1 = space();
    			input = element("input");
    			t2 = space();
    			ul = element("ul");

    			for (let i = 0; i < each_blocks.length; i += 1) {
    				each_blocks[i].c();
    			}
    			attr_dev(button, "class", "svelte-1nxc5es");
    			add_location(button, file, 16, 0, 283);
    			attr_dev(input, "type", "text");
    			attr_dev(input, "placeholder", "Search");
    			attr_dev(input, "class", "svelte-1nxc5es");
    			add_location(input, file, 17, 0, 323);
    			attr_dev(ul, "class", "svelte-1nxc5es");
    			add_location(ul, file, 18, 0, 416);

    			dispose = [
    				listen_dev(button, "click", ctx.click),
    				listen_dev(input, "input", ctx.input_input_handler),
    				listen_dev(input, "keyup", ctx.keyup_handler)
    			];
    		},

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: function mount(target, anchor) {
    			insert_dev(target, button, anchor);
    			insert_dev(target, t1, anchor);
    			insert_dev(target, input, anchor);

    			set_input_value(input, ctx.pattern);

    			insert_dev(target, t2, anchor);
    			insert_dev(target, ul, anchor);

    			for (let i = 0; i < each_blocks.length; i += 1) {
    				each_blocks[i].m(ul, null);
    			}
    		},

    		p: function update(changed, ctx) {
    			if (changed.pattern && (input.value !== ctx.pattern)) set_input_value(input, ctx.pattern);

    			if (changed.showLines) {
    				each_value = ctx.showLines;

    				let i;
    				for (i = 0; i < each_value.length; i += 1) {
    					const child_ctx = get_each_context(ctx, each_value, i);

    					if (each_blocks[i]) {
    						each_blocks[i].p(changed, child_ctx);
    					} else {
    						each_blocks[i] = create_each_block(child_ctx);
    						each_blocks[i].c();
    						each_blocks[i].m(ul, null);
    					}
    				}

    				for (; i < each_blocks.length; i += 1) {
    					each_blocks[i].d(1);
    				}
    				each_blocks.length = each_value.length;
    			}
    		},

    		i: noop,
    		o: noop,

    		d: function destroy(detaching) {
    			if (detaching) {
    				detach_dev(button);
    				detach_dev(t1);
    				detach_dev(input);
    				detach_dev(t2);
    				detach_dev(ul);
    			}

    			destroy_each(each_blocks, detaching);

    			run_all(dispose);
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment.name, type: "component", source: "", ctx });
    	return block;
    }

    function instance($$self, $$props, $$invalidate) {
    	let { pattern, lines, click, keyup } = $$props;

    	const writable_props = ['pattern', 'lines', 'click', 'keyup'];
    	Object.keys($$props).forEach(key => {
    		if (!writable_props.includes(key) && !key.startsWith('$$')) console.warn(`<FindPage> was created with unknown prop '${key}'`);
    	});

    	function input_input_handler() {
    		pattern = this.value;
    		$$invalidate('pattern', pattern);
    	}

    	const keyup_handler = () => keyup(pattern);

    	$$self.$set = $$props => {
    		if ('pattern' in $$props) $$invalidate('pattern', pattern = $$props.pattern);
    		if ('lines' in $$props) $$invalidate('lines', lines = $$props.lines);
    		if ('click' in $$props) $$invalidate('click', click = $$props.click);
    		if ('keyup' in $$props) $$invalidate('keyup', keyup = $$props.keyup);
    	};

    	$$self.$capture_state = () => {
    		return { pattern, lines, click, keyup, showLines };
    	};

    	$$self.$inject_state = $$props => {
    		if ('pattern' in $$props) $$invalidate('pattern', pattern = $$props.pattern);
    		if ('lines' in $$props) $$invalidate('lines', lines = $$props.lines);
    		if ('click' in $$props) $$invalidate('click', click = $$props.click);
    		if ('keyup' in $$props) $$invalidate('keyup', keyup = $$props.keyup);
    		if ('showLines' in $$props) $$invalidate('showLines', showLines = $$props.showLines);
    	};

    	let showLines;

    	$$self.$$.update = ($$dirty = { lines: 1, pattern: 1 }) => {
    		if ($$dirty.lines || $$dirty.pattern) { $$invalidate('showLines', showLines = lines.split('\n').filter((line) => line.toLowerCase().includes(pattern))); }
    	};

    	return {
    		pattern,
    		lines,
    		click,
    		keyup,
    		showLines,
    		input_input_handler,
    		keyup_handler
    	};
    }

    class FindPage extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance, create_fragment, safe_not_equal, ["pattern", "lines", "click", "keyup"]);
    		dispatch_dev("SvelteRegisterComponent", { component: this, tagName: "FindPage", options, id: create_fragment.name });

    		const { ctx } = this.$$;
    		const props = options.props || {};
    		if (ctx.pattern === undefined && !('pattern' in props)) {
    			console.warn("<FindPage> was created without expected prop 'pattern'");
    		}
    		if (ctx.lines === undefined && !('lines' in props)) {
    			console.warn("<FindPage> was created without expected prop 'lines'");
    		}
    		if (ctx.click === undefined && !('click' in props)) {
    			console.warn("<FindPage> was created without expected prop 'click'");
    		}
    		if (ctx.keyup === undefined && !('keyup' in props)) {
    			console.warn("<FindPage> was created without expected prop 'keyup'");
    		}
    	}

    	get pattern() {
    		throw new Error("<FindPage>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set pattern(value) {
    		throw new Error("<FindPage>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	get lines() {
    		throw new Error("<FindPage>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set lines(value) {
    		throw new Error("<FindPage>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	get click() {
    		throw new Error("<FindPage>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set click(value) {
    		throw new Error("<FindPage>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	get keyup() {
    		throw new Error("<FindPage>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set keyup(value) {
    		throw new Error("<FindPage>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}
    }

    /* src\EditPage.svelte generated by Svelte v3.12.1 */

    const file$1 = "src\\EditPage.svelte";

    function create_fragment$1(ctx) {
    	var button, t_1, textarea, dispose;

    	const block = {
    		c: function create() {
    			button = element("button");
    			button.textContent = "Save";
    			t_1 = space();
    			textarea = element("textarea");
    			attr_dev(button, "class", "svelte-1tun46h");
    			add_location(button, file$1, 12, 0, 147);
    			attr_dev(textarea, "rows", "70");
    			attr_dev(textarea, "class", "svelte-1tun46h");
    			add_location(textarea, file$1, 13, 0, 198);

    			dispose = [
    				listen_dev(button, "click", ctx.click_handler),
    				listen_dev(textarea, "input", ctx.textarea_input_handler)
    			];
    		},

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: function mount(target, anchor) {
    			insert_dev(target, button, anchor);
    			insert_dev(target, t_1, anchor);
    			insert_dev(target, textarea, anchor);

    			set_input_value(textarea, ctx.lines);
    		},

    		p: function update(changed, ctx) {
    			if (changed.lines) set_input_value(textarea, ctx.lines);
    		},

    		i: noop,
    		o: noop,

    		d: function destroy(detaching) {
    			if (detaching) {
    				detach_dev(button);
    				detach_dev(t_1);
    				detach_dev(textarea);
    			}

    			run_all(dispose);
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment$1.name, type: "component", source: "", ctx });
    	return block;
    }

    function instance$1($$self, $$props, $$invalidate) {
    	let { lines, click } = $$props;

    	const writable_props = ['lines', 'click'];
    	Object.keys($$props).forEach(key => {
    		if (!writable_props.includes(key) && !key.startsWith('$$')) console.warn(`<EditPage> was created with unknown prop '${key}'`);
    	});

    	const click_handler = () => click(lines);

    	function textarea_input_handler() {
    		lines = this.value;
    		$$invalidate('lines', lines);
    	}

    	$$self.$set = $$props => {
    		if ('lines' in $$props) $$invalidate('lines', lines = $$props.lines);
    		if ('click' in $$props) $$invalidate('click', click = $$props.click);
    	};

    	$$self.$capture_state = () => {
    		return { lines, click };
    	};

    	$$self.$inject_state = $$props => {
    		if ('lines' in $$props) $$invalidate('lines', lines = $$props.lines);
    		if ('click' in $$props) $$invalidate('click', click = $$props.click);
    	};

    	return {
    		lines,
    		click,
    		click_handler,
    		textarea_input_handler
    	};
    }

    class EditPage extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance$1, create_fragment$1, safe_not_equal, ["lines", "click"]);
    		dispatch_dev("SvelteRegisterComponent", { component: this, tagName: "EditPage", options, id: create_fragment$1.name });

    		const { ctx } = this.$$;
    		const props = options.props || {};
    		if (ctx.lines === undefined && !('lines' in props)) {
    			console.warn("<EditPage> was created without expected prop 'lines'");
    		}
    		if (ctx.click === undefined && !('click' in props)) {
    			console.warn("<EditPage> was created without expected prop 'click'");
    		}
    	}

    	get lines() {
    		throw new Error("<EditPage>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set lines(value) {
    		throw new Error("<EditPage>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	get click() {
    		throw new Error("<EditPage>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set click(value) {
    		throw new Error("<EditPage>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}
    }

    /* src\App001.svelte generated by Svelte v3.12.1 */

    // (23:0) {:else}
    function create_else_block(ctx) {
    	var current;

    	var editpage = new EditPage({
    		props: {
    		click: ctx.save,
    		lines: ctx.lines
    	},
    		$$inline: true
    	});

    	const block = {
    		c: function create() {
    			editpage.$$.fragment.c();
    		},

    		m: function mount(target, anchor) {
    			mount_component(editpage, target, anchor);
    			current = true;
    		},

    		p: function update(changed, ctx) {
    			var editpage_changes = {};
    			if (changed.lines) editpage_changes.lines = ctx.lines;
    			editpage.$set(editpage_changes);
    		},

    		i: function intro(local) {
    			if (current) return;
    			transition_in(editpage.$$.fragment, local);

    			current = true;
    		},

    		o: function outro(local) {
    			transition_out(editpage.$$.fragment, local);
    			current = false;
    		},

    		d: function destroy(detaching) {
    			destroy_component(editpage, detaching);
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_else_block.name, type: "else", source: "(23:0) {:else}", ctx });
    	return block;
    }

    // (21:0) {#if page==0}
    function create_if_block(ctx) {
    	var current;

    	var findpage = new FindPage({
    		props: {
    		keyup: ctx.keyup,
    		click: ctx.func,
    		lines: ctx.lines,
    		pattern: ctx.pattern
    	},
    		$$inline: true
    	});

    	const block = {
    		c: function create() {
    			findpage.$$.fragment.c();
    		},

    		m: function mount(target, anchor) {
    			mount_component(findpage, target, anchor);
    			current = true;
    		},

    		p: function update(changed, ctx) {
    			var findpage_changes = {};
    			if (changed.page) findpage_changes.click = ctx.func;
    			if (changed.lines) findpage_changes.lines = ctx.lines;
    			if (changed.pattern) findpage_changes.pattern = ctx.pattern;
    			findpage.$set(findpage_changes);
    		},

    		i: function intro(local) {
    			if (current) return;
    			transition_in(findpage.$$.fragment, local);

    			current = true;
    		},

    		o: function outro(local) {
    			transition_out(findpage.$$.fragment, local);
    			current = false;
    		},

    		d: function destroy(detaching) {
    			destroy_component(findpage, detaching);
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_if_block.name, type: "if", source: "(21:0) {#if page==0}", ctx });
    	return block;
    }

    function create_fragment$2(ctx) {
    	var current_block_type_index, if_block, if_block_anchor, current;

    	var if_block_creators = [
    		create_if_block,
    		create_else_block
    	];

    	var if_blocks = [];

    	function select_block_type(changed, ctx) {
    		if (ctx.page==0) return 0;
    		return 1;
    	}

    	current_block_type_index = select_block_type(null, ctx);
    	if_block = if_blocks[current_block_type_index] = if_block_creators[current_block_type_index](ctx);

    	const block = {
    		c: function create() {
    			if_block.c();
    			if_block_anchor = empty();
    		},

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: function mount(target, anchor) {
    			if_blocks[current_block_type_index].m(target, anchor);
    			insert_dev(target, if_block_anchor, anchor);
    			current = true;
    		},

    		p: function update(changed, ctx) {
    			var previous_block_index = current_block_type_index;
    			current_block_type_index = select_block_type(changed, ctx);
    			if (current_block_type_index === previous_block_index) {
    				if_blocks[current_block_type_index].p(changed, ctx);
    			} else {
    				group_outros();
    				transition_out(if_blocks[previous_block_index], 1, 1, () => {
    					if_blocks[previous_block_index] = null;
    				});
    				check_outros();

    				if_block = if_blocks[current_block_type_index];
    				if (!if_block) {
    					if_block = if_blocks[current_block_type_index] = if_block_creators[current_block_type_index](ctx);
    					if_block.c();
    				}
    				transition_in(if_block, 1);
    				if_block.m(if_block_anchor.parentNode, if_block_anchor);
    			}
    		},

    		i: function intro(local) {
    			if (current) return;
    			transition_in(if_block);
    			current = true;
    		},

    		o: function outro(local) {
    			transition_out(if_block);
    			current = false;
    		},

    		d: function destroy(detaching) {
    			if_blocks[current_block_type_index].d(detaching);

    			if (detaching) {
    				detach_dev(if_block_anchor);
    			}
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment$2.name, type: "component", source: "", ctx });
    	return block;
    }

    function instance$2($$self, $$props, $$invalidate) {
    	document.title = 'Organizer';

    	let pattern = '';
    	let page = 0;
    	let lines = localStorage.Organizer;
    	//let lines = "12 Batteri\n65 Bensin \n64 Bestick\n43 Blöjor \n52 Brandlarm\n52 Chifonet\n41 Cykelgrejer\n42 Cykelgrejer\n22 Cykellampor\n22 Cykellås\n65 Cykelolja\n21 Dammsugarpåsar\n36 Dämpare\n61 Diverse\n12 Elmätare\n13 Elprylar, små\n32 Etiketter\n22 Ficklampor\n24 Fickplunta\n45 Fotvård\n32 Glasögonfodral\n14 Glödlampor\n16 Glödlampor\n15 Glödlampor, stora\n54 Glögglas\n11 Gruppschema\n21 Gummiband\n11 Häftapparat\n55 Handdukar\n44 Hårvård\n36 IKEA-delar\n63 Kåsor\n11 Klammer\n13 Klister\n12 Laddare\n33 Lås\n13 Märkpennor\n26 Möss\n33 Nycklar\n44 Ögonvård\n44 Öronvård\n21 Pappersnäsdukar\n13 Pennor\n63 Plastflaskor\n62 Plastpåsar\n35 Plugg\n13 Proppar\n65 Putsgrejer\n46 Rakgrejer\n51 Remmar\n56 Skovård\n31 Skruvar\n35 Skruvar\n51 Snören\n34 Specialverktyg\n26 Streckkodläsare\n66 Strykjärn\n52 Svinto\n53 Sygrejer\n32 Tändstickor\n46 Tandvård\n23 Tape\n11 Tätningslist\n25 Toagrejer\n21 Tvättklämmor\n26 USB-grejer\n26 Wattmätare"

    	const save = (lines0) => {
    		$$invalidate('lines', lines = lines0);
    		localStorage.Organizer = lines;
    		$$invalidate('page', page = 1-page);
    	};

    	const keyup = (pattern0) => $$invalidate('pattern', pattern = pattern0);

    	const func = () => $$invalidate('page', page=1-page);

    	$$self.$capture_state = () => {
    		return {};
    	};

    	$$self.$inject_state = $$props => {
    		if ('pattern' in $$props) $$invalidate('pattern', pattern = $$props.pattern);
    		if ('page' in $$props) $$invalidate('page', page = $$props.page);
    		if ('lines' in $$props) $$invalidate('lines', lines = $$props.lines);
    	};

    	return { pattern, page, lines, save, keyup, func };
    }

    class App001 extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance$2, create_fragment$2, safe_not_equal, []);
    		dispatch_dev("SvelteRegisterComponent", { component: this, tagName: "App001", options, id: create_fragment$2.name });
    	}
    }

    const app = new App001({
    	target: document.body,
    	props: {}
    });

    return app;

}());
//# sourceMappingURL=bundle.js.map
