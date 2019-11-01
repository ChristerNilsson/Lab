
(function(l, r) { if (l.getElementById('livereloadscript')) return; r = l.createElement('script'); r.async = 1; r.src = '//' + (window.location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1'; r.id = 'livereloadscript'; l.head.appendChild(r) })(window.document);
var app = (function () {
    'use strict';

    function noop() { }
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
    function children(element) {
        return Array.from(element.childNodes);
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

    // Generated by CoffeeScript 2.4.1
    //var assert, testReducer;

    const assert = chai.assert.deepEqual;

    const testReducer = function(script, reducers, stack) {
    	var countTabs, rpn, run, runTest, states;
    	var errors = [];
    	states = [];
    	run = function() {
    		var i, len, line, nr, ref, results;
    		ref = script.split('\n');
    		// console.log(ref)
    		results = [];
    		for (nr = i = 0, len = ref.length; i < len; nr = ++i) {
    			line = ref[nr];
    			// console.log(line)
    			results.push(runTest(line, nr));
    		}
    		return errors;
    	};
    	runTest = function(line, nr) {
    		var arr, cmd, i, index, len, state;
    		index = countTabs(line);
    		line = line.trim();
    		if (index === 0) {
    			// console.log(line)
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
    		if (cmd === 'STATE') {
    			stack.push(state);
    			return state;
    		}
    		if (Object.keys(state).includes(cmd.toLowerCase() )) {
    			stack.push(state[cmd.toLowerCase()]);
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

    function create_fragment(ctx) {
    	const block = {
    		c: noop,

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: noop,
    		p: noop,
    		i: noop,
    		o: noop,
    		d: noop
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment.name, type: "component", source: "", ctx });
    	return block;
    }

    function instance($$self) {
    	const stack = [];

    	const op = (state,value) => {
    		const hist = state.hist.slice();
    		hist.push(state.a);
    		const a = value;
    		const b = state.b;
    		return {a,b,hist}
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
{"a":18,"b":17,"hist":[]}
	ADD STATE {"a":20,"b":17,"hist":[18]}
	MUL STATE {"a":36,"b":17,"hist":[18]}
	DIV STATE {"a":9,"b":17,"hist":[18]}
	17 1 NEW A 17 B 1 HIST []
{"a":17,"b":1,"hist":[]}
	MUL ADD DIV STATE {"a":18,"b":1,"hist":[17,34,36]}
		UNDO STATE {"a":36,"b":1,"hist":[17,34]}
			UNDO STATE {"a":34,"b":1,"hist":[17]}
				UNDO STATE {"a":17,"b":1,"hist":[]}
`;

    	const reducer = testReducer(script.trim(), reducers, stack); 
    	const lines = reducer.run();
    	console.log(lines.join('\n'));

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
