
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
    function element(name) {
        return document.createElement(name);
    }
    function text(data) {
        return document.createTextNode(data);
    }
    function space() {
        return text(' ');
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
    function set_style(node, key, value, important) {
        node.style.setProperty(key, value, important ? 'important' : '');
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
    function transition_in(block, local) {
        if (block && block.i) {
            outroing.delete(block);
            block.i(local);
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
    function attr_dev(node, attribute, value) {
        attr(node, attribute, value);
        if (value == null)
            dispatch_dev("SvelteDOMRemoveAttribute", { node, attribute });
        else
            dispatch_dev("SvelteDOMSetAttribute", { node, attribute, value });
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

    const assert = chai.assert.deepEqual;

    const testReducer = function(reducers, stack) {
    	var countTabs, rpn, run, runTest, states;
    	var errors = [];
    	states = [];
    	run = function(script) {
    		var i, len, line, nr, ref;
    		ref = script.split('\n');
    		errors = [];
    		for (nr = i = 0, len = ref.length; i < len; nr = ++i) {
    			line = ref[nr];
    			console.log(line);
    			var pos = line.lastIndexOf('#');
    			if (pos>=0) line = line.slice(0,pos);
    			console.log(line);
    			try {
    				if (line.trim().length!=0) runTest(line, nr);
    			} catch (err) {
    				errors.push(err);
    			}
    		}
    		console.log(errors);
    		return errors
    	};
    	runTest = function(line, nr) {
    		var arr, cmd, i, index, len, state;
    		index = countTabs(line);
    		line = line.trim();
    		console.log('.',line,'.');
    		if (index === 0) {
    			return states = [JSON.parse(line)];
    		}
    		stack.length = 0;
    		arr = line.split(' ');
    		state = states[index - 1];
    		for (i = 0, len = arr.length; i < len; i++) {
    			cmd = arr[i];
    			state = rpn(cmd, state, nr);
    		}
    		states[index] = state;
    		while (stack.length >= 2) {
    			rpn('==', state, nr);
    		}
    		if (stack.length === 1) {
    			errors.push(`Orphan in line ${nr + 1}`);
    			return 
    		}
    	};
    	rpn = function(cmd, state, nr) {
    		var x, y;
    		if (cmd === '@') {
    			stack.push(state);
    			return state;
    		}
    		const key = cmd.slice(1);
    		if (Object.keys(state).includes(key)) {
    			stack.push(state[key]);
    			return state;
    		}
    		if (Object.keys(reducers).includes(cmd)) {
    			return state = reducers[cmd](state);
    		}
    		if (cmd === '==') {
    			try {
    				x = stack.pop();
    				y = stack.pop();
    				assert(x, y);
    			} catch (error) {
    				errors.push('Assert failure in line ' + (nr + 1));
    				errors.push('  Actual ' + JSON.stringify(y));
    				errors.push('  Expect ' + JSON.stringify(x));
    			}
    			return state;
    		}
    		try {
    			if (cmd=='') return state
    			stack.push(JSON.parse(cmd));
    		} catch (error) {
    			errors.push('JSON.parse failure in line ' + (nr + 1)+ ' '+ cmd);
    			errors.push('	' + cmd);
    		}
    		return state;
    	};
    	countTabs = function(line) {
    		var ch, i, len, result;
    		result = 0;
    		for (i = 0, len = line.length; i < len; i++) {
    			ch = line[i];
    			if (ch !== '\t') {
    				return result;
    			}
    			result++;
    		}
    		return result;
    	};
    	return {run};
    };

    /* src\App.svelte generated by Svelte v3.12.1 */

    const file = "src\\App.svelte";

    function create_fragment(ctx) {
    	var div22, h2, t1, div0, t2, a0, t4, t5, div1, t7, ul0, li0, t8, t9_value = '{' + "", t9, t10, li1, t12, li2, t13_value = '}' + "", t13, t14, t15, div2, t17, div3, t19, div4, t21, div5, t23, div6, t24, a1, t26, div7, t28, div8, t30, div9, t32, div10, t34, div11, t36, div12, a2, t38, t39, div13, a3, t41, t42, div14, t44, div15, t46, div16, t48, div17, t50, div18, t52, div19, t54, div20, t56, ul1, li3, t58, li4, t60, li5, t62, li6, t64, li7, t66, ul2, li8, t68, li9, t70, li10, t72, li11, t74, div21, t76, ul3, li12, t78, li13, t80, div24, div23, t81, a4, t83, t84, ul4, li14, t85_value = '{' + "", t85, t86_value = '"board"' + "", t86, t87, t88_value = '"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"' + "", t88, t89_value = '}' + "", t89, t90, li15, t92, li16;

    	const block = {
    		c: function create() {
    			div22 = element("div");
    			h2 = element("h2");
    			h2.textContent = "Reducer Based Testing";
    			t1 = space();
    			div0 = element("div");
    			t2 = text("This is a compact format for testing ");
    			a0 = element("a");
    			a0.textContent = "Reducers";
    			t4 = text(" and an alternative to:");
    			t5 = space();
    			div1 = element("div");
    			div1.textContent = " ";
    			t7 = space();
    			ul0 = element("ul");
    			li0 = element("li");
    			t8 = text("test('adds 1 + 2 to equal 3', () => ");
    			t9 = text(t9_value);
    			t10 = space();
    			li1 = element("li");
    			li1.textContent = "  expect(sum(1, 2)).toBe(3);";
    			t12 = space();
    			li2 = element("li");
    			t13 = text(t13_value);
    			t14 = text(");");
    			t15 = space();
    			div2 = element("div");
    			div2.textContent = " ";
    			t17 = space();
    			div3 = element("div");
    			div3.textContent = "Reducer: State + Action => State";
    			t19 = space();
    			div4 = element("div");
    			div4.textContent = " ";
    			t21 = space();
    			div5 = element("div");
    			div5.textContent = "Each line contains zero or more actions";
    			t23 = space();
    			div6 = element("div");
    			t24 = text("Each line contains zero or more ");
    			a1 = element("a");
    			a1.textContent = "assertions";
    			t26 = space();
    			div7 = element("div");
    			div7.textContent = " ";
    			t28 = space();
    			div8 = element("div");
    			div8.textContent = "Lines with no indentation contains initial states";
    			t30 = space();
    			div9 = element("div");
    			div9.textContent = "Indented lines are based on previous states";
    			t32 = space();
    			div10 = element("div");
    			div10.textContent = "Alternative actions have the same indentation";
    			t34 = space();
    			div11 = element("div");
    			div11.textContent = " ";
    			t36 = space();
    			div12 = element("div");
    			a2 = element("a");
    			a2.textContent = "JSON";
    			t38 = text(" is used to describe states");
    			t39 = space();
    			div13 = element("div");
    			a3 = element("a");
    			a3.textContent = "RPN";
    			t41 = text(" is used for actions and getters");
    			t42 = space();
    			div14 = element("div");
    			div14.textContent = " ";
    			t44 = space();
    			div15 = element("div");
    			div15.textContent = "Implicit assertion uses ==";
    			t46 = space();
    			div16 = element("div");
    			div16.textContent = "== deeply compares top two stack elements";
    			t48 = space();
    			div17 = element("div");
    			div17.textContent = "Implicit assertions repeats until the stack is empty";
    			t50 = space();
    			div18 = element("div");
    			div18.textContent = "Alternative assertions might be defined";
    			t52 = space();
    			div19 = element("div");
    			div19.textContent = "Actions may consume parameters";
    			t54 = space();
    			div20 = element("div");
    			div20.textContent = " ";
    			t56 = text("\n\n\tActions:\n\t");
    			ul1 = element("ul");
    			li3 = element("li");
    			li3.textContent = "ADD : a = a + 2";
    			t58 = space();
    			li4 = element("li");
    			li4.textContent = "MUL : a = a * 2";
    			t60 = space();
    			li5 = element("li");
    			li5.textContent = "DIV : a = a / 2";
    			t62 = space();
    			li6 = element("li");
    			li6.textContent = "NEW";
    			t64 = space();
    			li7 = element("li");
    			li7.textContent = "UNDO";
    			t66 = text("\n\t\n\tGetters: \n\t");
    			ul2 = element("ul");
    			li8 = element("li");
    			li8.textContent = "@ : The State";
    			t68 = space();
    			li9 = element("li");
    			li9.textContent = "@a : The number to be changed";
    			t70 = space();
    			li10 = element("li");
    			li10.textContent = "@b : Target number";
    			t72 = space();
    			li11 = element("li");
    			li11.textContent = "@hist : List for Undo";
    			t74 = space();
    			div21 = element("div");
    			div21.textContent = " ";
    			t76 = text("\n\tKnown bugs:\n\t");
    			ul3 = element("ul");
    			li12 = element("li");
    			li12.textContent = "Spaces are not allowed in expressions";
    			t78 = space();
    			li13 = element("li");
    			li13.textContent = "Tabs must be used for indentation";
    			t80 = space();
    			div24 = element("div");
    			div23 = element("div");
    			t81 = text("Chess example (");
    			a4 = element("a");
    			a4.textContent = "Forsyth–Edwards Notation";
    			t83 = text(")");
    			t84 = space();
    			ul4 = element("ul");
    			li14 = element("li");
    			t85 = text(t85_value);
    			t86 = text(t86_value);
    			t87 = text(":");
    			t88 = text(t88_value);
    			t89 = text(t89_value);
    			t90 = space();
    			li15 = element("li");
    			li15.textContent = "  e2e4 MOVE @board rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR";
    			t92 = space();
    			li16 = element("li");
    			li16.textContent = "    e7e5 MOVE @board rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR";
    			add_location(h2, file, 73, 1, 1833);
    			attr_dev(a0, "href", "https://redux.js.org/basics/reducers");
    			add_location(a0, file, 74, 43, 1907);
    			attr_dev(div0, "class", "svelte-1m9zrs0");
    			add_location(div0, file, 74, 1, 1865);
    			attr_dev(div1, "class", "svelte-1m9zrs0");
    			add_location(div1, file, 75, 1, 1997);
    			attr_dev(li0, "class", "svelte-1m9zrs0");
    			add_location(li0, file, 77, 2, 2023);
    			attr_dev(li1, "class", "svelte-1m9zrs0");
    			add_location(li1, file, 78, 3, 2077);
    			attr_dev(li2, "class", "svelte-1m9zrs0");
    			add_location(li2, file, 79, 2, 2127);
    			add_location(ul0, file, 76, 1, 2016);
    			attr_dev(div2, "class", "svelte-1m9zrs0");
    			add_location(div2, file, 81, 1, 2152);
    			attr_dev(div3, "class", "svelte-1m9zrs0");
    			add_location(div3, file, 82, 1, 2171);
    			attr_dev(div4, "class", "svelte-1m9zrs0");
    			add_location(div4, file, 83, 1, 2216);
    			attr_dev(div5, "class", "svelte-1m9zrs0");
    			add_location(div5, file, 84, 1, 2235);
    			attr_dev(a1, "href", "https://en.wikipedia.org/wiki/Assertion_(software_development)");
    			add_location(a1, file, 85, 38, 2324);
    			attr_dev(div6, "class", "svelte-1m9zrs0");
    			add_location(div6, file, 85, 1, 2287);
    			attr_dev(div7, "class", "svelte-1m9zrs0");
    			add_location(div7, file, 86, 1, 2419);
    			attr_dev(div8, "class", "svelte-1m9zrs0");
    			add_location(div8, file, 87, 1, 2438);
    			attr_dev(div9, "class", "svelte-1m9zrs0");
    			add_location(div9, file, 88, 1, 2500);
    			attr_dev(div10, "class", "svelte-1m9zrs0");
    			add_location(div10, file, 89, 1, 2556);
    			attr_dev(div11, "class", "svelte-1m9zrs0");
    			add_location(div11, file, 90, 1, 2614);
    			attr_dev(a2, "href", "https://en.wikipedia.org/wiki/JSON");
    			add_location(a2, file, 91, 6, 2638);
    			attr_dev(div12, "class", "svelte-1m9zrs0");
    			add_location(div12, file, 91, 1, 2633);
    			attr_dev(a3, "href", "https://en.wikipedia.org/wiki/Reverse_Polish_notation");
    			add_location(a3, file, 92, 6, 2731);
    			attr_dev(div13, "class", "svelte-1m9zrs0");
    			add_location(div13, file, 92, 1, 2726);
    			attr_dev(div14, "class", "svelte-1m9zrs0");
    			add_location(div14, file, 93, 1, 2842);
    			attr_dev(div15, "class", "svelte-1m9zrs0");
    			add_location(div15, file, 94, 1, 2861);
    			attr_dev(div16, "class", "svelte-1m9zrs0");
    			add_location(div16, file, 95, 1, 2900);
    			attr_dev(div17, "class", "svelte-1m9zrs0");
    			add_location(div17, file, 96, 1, 2954);
    			attr_dev(div18, "class", "svelte-1m9zrs0");
    			add_location(div18, file, 97, 1, 3019);
    			attr_dev(div19, "class", "svelte-1m9zrs0");
    			add_location(div19, file, 98, 1, 3071);
    			attr_dev(div20, "class", "svelte-1m9zrs0");
    			add_location(div20, file, 99, 1, 3114);
    			attr_dev(li3, "class", "svelte-1m9zrs0");
    			add_location(li3, file, 103, 3, 3152);
    			attr_dev(li4, "class", "svelte-1m9zrs0");
    			add_location(li4, file, 104, 2, 3179);
    			attr_dev(li5, "class", "svelte-1m9zrs0");
    			add_location(li5, file, 105, 2, 3206);
    			attr_dev(li6, "class", "svelte-1m9zrs0");
    			add_location(li6, file, 106, 2, 3233);
    			attr_dev(li7, "class", "svelte-1m9zrs0");
    			add_location(li7, file, 107, 2, 3248);
    			add_location(ul1, file, 102, 1, 3144);
    			attr_dev(li8, "class", "svelte-1m9zrs0");
    			add_location(li8, file, 112, 2, 3290);
    			attr_dev(li9, "class", "svelte-1m9zrs0");
    			add_location(li9, file, 113, 2, 3315);
    			attr_dev(li10, "class", "svelte-1m9zrs0");
    			add_location(li10, file, 114, 2, 3356);
    			attr_dev(li11, "class", "svelte-1m9zrs0");
    			add_location(li11, file, 115, 2, 3386);
    			add_location(ul2, file, 111, 1, 3283);
    			attr_dev(div21, "class", "svelte-1m9zrs0");
    			add_location(div21, file, 117, 1, 3425);
    			attr_dev(li12, "class", "svelte-1m9zrs0");
    			add_location(li12, file, 120, 2, 3464);
    			attr_dev(li13, "class", "svelte-1m9zrs0");
    			add_location(li13, file, 121, 2, 3513);
    			add_location(ul3, file, 119, 1, 3457);
    			set_style(div22, "position", "absolute");
    			set_style(div22, "left", "1050px");
    			set_style(div22, "top", "10px");
    			set_style(div22, "width", "40%");
    			attr_dev(div22, "class", "svelte-1m9zrs0");
    			add_location(div22, file, 72, 0, 1766);
    			attr_dev(a4, "href", "https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation");
    			add_location(a4, file, 126, 21, 3658);
    			attr_dev(div23, "class", "svelte-1m9zrs0");
    			add_location(div23, file, 126, 1, 3638);
    			attr_dev(li14, "class", "svelte-1m9zrs0");
    			add_location(li14, file, 128, 2, 3775);
    			attr_dev(li15, "class", "svelte-1m9zrs0");
    			add_location(li15, file, 129, 2, 3858);
    			attr_dev(li16, "class", "svelte-1m9zrs0");
    			add_location(li16, file, 130, 2, 3944);
    			add_location(ul4, file, 127, 1, 3768);
    			set_style(div24, "position", "absolute");
    			set_style(div24, "left", "10px");
    			set_style(div24, "top", "1015px");
    			set_style(div24, "width", "80%");
    			attr_dev(div24, "class", "svelte-1m9zrs0");
    			add_location(div24, file, 125, 0, 3571);
    		},

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: function mount(target, anchor) {
    			insert_dev(target, div22, anchor);
    			append_dev(div22, h2);
    			append_dev(div22, t1);
    			append_dev(div22, div0);
    			append_dev(div0, t2);
    			append_dev(div0, a0);
    			append_dev(div0, t4);
    			append_dev(div22, t5);
    			append_dev(div22, div1);
    			append_dev(div22, t7);
    			append_dev(div22, ul0);
    			append_dev(ul0, li0);
    			append_dev(li0, t8);
    			append_dev(li0, t9);
    			append_dev(ul0, t10);
    			append_dev(ul0, li1);
    			append_dev(ul0, t12);
    			append_dev(ul0, li2);
    			append_dev(li2, t13);
    			append_dev(li2, t14);
    			append_dev(div22, t15);
    			append_dev(div22, div2);
    			append_dev(div22, t17);
    			append_dev(div22, div3);
    			append_dev(div22, t19);
    			append_dev(div22, div4);
    			append_dev(div22, t21);
    			append_dev(div22, div5);
    			append_dev(div22, t23);
    			append_dev(div22, div6);
    			append_dev(div6, t24);
    			append_dev(div6, a1);
    			append_dev(div22, t26);
    			append_dev(div22, div7);
    			append_dev(div22, t28);
    			append_dev(div22, div8);
    			append_dev(div22, t30);
    			append_dev(div22, div9);
    			append_dev(div22, t32);
    			append_dev(div22, div10);
    			append_dev(div22, t34);
    			append_dev(div22, div11);
    			append_dev(div22, t36);
    			append_dev(div22, div12);
    			append_dev(div12, a2);
    			append_dev(div12, t38);
    			append_dev(div22, t39);
    			append_dev(div22, div13);
    			append_dev(div13, a3);
    			append_dev(div13, t41);
    			append_dev(div22, t42);
    			append_dev(div22, div14);
    			append_dev(div22, t44);
    			append_dev(div22, div15);
    			append_dev(div22, t46);
    			append_dev(div22, div16);
    			append_dev(div22, t48);
    			append_dev(div22, div17);
    			append_dev(div22, t50);
    			append_dev(div22, div18);
    			append_dev(div22, t52);
    			append_dev(div22, div19);
    			append_dev(div22, t54);
    			append_dev(div22, div20);
    			append_dev(div22, t56);
    			append_dev(div22, ul1);
    			append_dev(ul1, li3);
    			append_dev(ul1, t58);
    			append_dev(ul1, li4);
    			append_dev(ul1, t60);
    			append_dev(ul1, li5);
    			append_dev(ul1, t62);
    			append_dev(ul1, li6);
    			append_dev(ul1, t64);
    			append_dev(ul1, li7);
    			append_dev(div22, t66);
    			append_dev(div22, ul2);
    			append_dev(ul2, li8);
    			append_dev(ul2, t68);
    			append_dev(ul2, li9);
    			append_dev(ul2, t70);
    			append_dev(ul2, li10);
    			append_dev(ul2, t72);
    			append_dev(ul2, li11);
    			append_dev(div22, t74);
    			append_dev(div22, div21);
    			append_dev(div22, t76);
    			append_dev(div22, ul3);
    			append_dev(ul3, li12);
    			append_dev(ul3, t78);
    			append_dev(ul3, li13);
    			insert_dev(target, t80, anchor);
    			insert_dev(target, div24, anchor);
    			append_dev(div24, div23);
    			append_dev(div23, t81);
    			append_dev(div23, a4);
    			append_dev(div23, t83);
    			append_dev(div24, t84);
    			append_dev(div24, ul4);
    			append_dev(ul4, li14);
    			append_dev(li14, t85);
    			append_dev(li14, t86);
    			append_dev(li14, t87);
    			append_dev(li14, t88);
    			append_dev(li14, t89);
    			append_dev(ul4, t90);
    			append_dev(ul4, li15);
    			append_dev(ul4, t92);
    			append_dev(ul4, li16);
    		},

    		p: noop,
    		i: noop,
    		o: noop,

    		d: function destroy(detaching) {
    			if (detaching) {
    				detach_dev(div22);
    				detach_dev(t80);
    				detach_dev(div24);
    			}
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment.name, type: "component", source: "", ctx });
    	return block;
    }

    function instance($$self) {
    	const stack = [];

    const op = (state,value) => {
    	const hist = [...state.hist, state.a];
    	return {...state, a:value, hist}
    };

    const reducers = {
    	ADD: (state) => op(state,state.a+2),
    	MUL: (state) => op(state,state.a*2),
    	DIV: (state) => op(state,state.a/2),
    	NEW: (state) => ({b:stack.pop(), a:stack.pop(), hist:[]}),
    	UNDO: (state) => {
    		const hist = state.hist.slice();
    		const a = hist.pop();
    		const b = state.b;
    		return {a,b,hist}
    	}
    };

    let script = `
{"a":18,"b":17,"hist":[]} # initial state
	@a 18 ==                # assert @a deeply equals 18
	@b 17                   # implicit == assertion
	ADD @a 20               # based on line 1
	MUL @a 36 @hist [18]    # also based on line 1
	DIV @ {"a":9,"b":17,"hist":[18]} # @ is the state
	3 4 NEW @a 3 @b 4 @hist [] # NEW takes two parameters
{"a":17,"b":1,"hist":[]}  # another initial state
	MUL ADD DIV @ {"a":18,"b":1,"hist":[17,34,36]}
		UNDO @ {"a":36,"b":1,"hist":[17,34]} # based on 9
			UNDO @ {"a":34,"b":1,"hist":[17]}  # based on 10
				UNDO @ {"a":17,"b":1,"hist":[99]}
	# a solution from 17 to 1 in eleven steps
	MUL ADD DIV ADD DIV ADD DIV ADD DIV DIV DIV @a @b
`;
    const editor = CodeMirror(document.body, {
    	lineNumbers: true, 
    	tabSize:2,
    	indentWithTabs: true,
    	theme : 'dracula'
    }); 
    editor.setSize(1000,600);
    editor.setValue(script.trim());
    editor.on("change", () => {
    	viewer.setValue(reducer.run(editor.getValue()).join('\n'));
    });

    const viewer = CodeMirror(document.body, {
    	readOnly:true,
    	tabSize:2,
    });
    viewer.setSize(1000,400);

    const reducer = testReducer(reducers, stack); 
    viewer.setValue(reducer.run(editor.getValue()).join('\n'));

    	$$self.$capture_state = () => {
    		return {};
    	};

    	$$self.$inject_state = $$props => {
    		if ('script' in $$props) script = $$props.script;
    	};

    	return {};
    }

    class App extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance, create_fragment, safe_not_equal, []);
    		dispatch_dev("SvelteRegisterComponent", { component: this, tagName: "App", options, id: create_fragment.name });
    	}
    }

    const app = new App({
    	target: document.body,
    	props: {}
    });

    return app;

}());
//# sourceMappingURL=bundle.js.map
