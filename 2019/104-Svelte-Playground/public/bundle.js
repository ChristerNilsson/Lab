
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
    function validate_store(store, name) {
        if (!store || typeof store.subscribe !== 'function') {
            throw new Error(`'${name}' is not a store with a 'subscribe' method`);
        }
    }
    function subscribe(store, callback) {
        const unsub = store.subscribe(callback);
        return unsub.unsubscribe ? () => unsub.unsubscribe() : unsub;
    }
    function get_store_value(store) {
        let value;
        subscribe(store, _ => value = _)();
        return value;
    }
    function component_subscribe(component, store, callback) {
        component.$$.on_destroy.push(subscribe(store, callback));
    }
    function null_to_empty(value) {
        return value == null ? '' : value;
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
    function createEventDispatcher() {
        const component = current_component;
        return (type, detail) => {
            const callbacks = component.$$.callbacks[type];
            if (callbacks) {
                // TODO are there situations where events could be dispatched
                // in a server (non-DOM) environment?
                const event = custom_event(type, detail);
                callbacks.slice().forEach(fn => {
                    fn.call(component, event);
                });
            }
        };
    }
    // TODO figure out if we still want to support
    // shorthand events, or if we want to implement
    // a real bubbling mechanism
    function bubble(component, event) {
        const callbacks = component.$$.callbacks[event.type];
        if (callbacks) {
            callbacks.slice().forEach(fn => fn(event));
        }
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
    function prop_dev(node, property, value) {
        node[property] = value;
        dispatch_dev("SvelteDOMSetProperty", { node, property, value });
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

    const subscriber_queue = [];
    /**
     * Create a `Writable` store that allows both updating and reading by subscription.
     * @param {*=}value initial value
     * @param {StartStopNotifier=}start start and stop notifications for subscriptions
     */
    function writable(value, start = noop) {
        let stop;
        const subscribers = [];
        function set(new_value) {
            if (safe_not_equal(value, new_value)) {
                value = new_value;
                if (stop) { // store is ready
                    const run_queue = !subscriber_queue.length;
                    for (let i = 0; i < subscribers.length; i += 1) {
                        const s = subscribers[i];
                        s[1]();
                        subscriber_queue.push(s, value);
                    }
                    if (run_queue) {
                        for (let i = 0; i < subscriber_queue.length; i += 2) {
                            subscriber_queue[i][0](subscriber_queue[i + 1]);
                        }
                        subscriber_queue.length = 0;
                    }
                }
            }
        }
        function update(fn) {
            set(fn(value));
        }
        function subscribe(run, invalidate = noop) {
            const subscriber = [run, invalidate];
            subscribers.push(subscriber);
            if (subscribers.length === 1) {
                stop = start(set) || noop;
            }
            run(value);
            return () => {
                const index = subscribers.indexOf(subscriber);
                if (index !== -1) {
                    subscribers.splice(index, 1);
                }
                if (subscribers.length === 0) {
                    stop();
                    stop = null;
                }
            };
        }
        return { set, update, subscribe };
    }

    // import {createEventDispatcher} from 'svelte'
    // const dispatch = createEventDispatcher()

    // const ADD = 'ADD'
    // const MUL = 'MUL'
    // const DIV = 'DIV'
    // const NEW = 'NEW'
    // const UNDO = 'UNDO'
    // const USE_TIME_MACHINE = true

    // let states

    const store = writable({a:17,b:1,hist:[]});
    // console.log(store)

    // let operation = () => {}
    // const register = (oper) => {
    // 	operation = oper
    // }

    var store$1 = {  
    	subscribe : store.subscribe,
    	// register : register,
    	update : store.update,
    	set: store.set,
    	// states : states
    };

    var commonjsGlobal = typeof globalThis !== 'undefined' ? globalThis : typeof window !== 'undefined' ? window : typeof global !== 'undefined' ? global : typeof self !== 'undefined' ? self : {};

    function unwrapExports (x) {
    	return x && x.__esModule && Object.prototype.hasOwnProperty.call(x, 'default') ? x['default'] : x;
    }

    function createCommonjsModule(fn, module) {
    	return module = { exports: {} }, fn(module, module.exports), module.exports;
    }

    var emotion_umd_min = createCommonjsModule(function (module, exports) {
    !function(e,r){r(exports);}(commonjsGlobal,function(e){var r=function(){function e(e){this.isSpeedy=void 0===e.speedy||e.speedy,this.tags=[],this.ctr=0,this.nonce=e.nonce,this.key=e.key,this.container=e.container,this.before=null;}var r=e.prototype;return r.insert=function(e){if(this.ctr%(this.isSpeedy?65e3:1)==0){var r,t=function(e){var r=document.createElement("style");return r.setAttribute("data-emotion",e.key),void 0!==e.nonce&&r.setAttribute("nonce",e.nonce),r.appendChild(document.createTextNode("")),r}(this);r=0===this.tags.length?this.before:this.tags[this.tags.length-1].nextSibling,this.container.insertBefore(t,r),this.tags.push(t);}var a=this.tags[this.tags.length-1];if(this.isSpeedy){var n=function(e){if(e.sheet)return e.sheet;for(var r=0;r<document.styleSheets.length;r++)if(document.styleSheets[r].ownerNode===e)return document.styleSheets[r]}(a);try{var i=105===e.charCodeAt(1)&&64===e.charCodeAt(0);n.insertRule(e,i?0:n.cssRules.length);}catch(e){}}else a.appendChild(document.createTextNode(e));this.ctr++;},r.flush=function(){this.tags.forEach(function(e){return e.parentNode.removeChild(e)}),this.tags=[],this.ctr=0;},e}();function t(e){function r(e,r,a){var n=r.trim().split(b);r=n;var i=n.length,s=e.length;switch(s){case 0:case 1:var c=0;for(e=0===s?"":e[0]+" ";c<i;++c)r[c]=t(e,r[c],a).trim();break;default:var o=c=0;for(r=[];c<i;++c)for(var l=0;l<s;++l)r[o++]=t(e[l]+" ",n[c],a).trim();}return r}function t(e,r,t){var a=r.charCodeAt(0);switch(33>a&&(a=(r=r.trim()).charCodeAt(0)),a){case 38:return r.replace(g,"$1"+e.trim());case 58:return e.trim()+r.replace(g,"$1"+e.trim());default:if(0<1*t&&0<r.indexOf("\f"))return r.replace(g,(58===e.charCodeAt(0)?"":"$1")+e.trim())}return e+r}function a(e,r,t,i){var s=e+";",c=2*r+3*t+4*i;if(944===c){e=s.indexOf(":",9)+1;var o=s.substring(e,s.length-1).trim();return o=s.substring(0,e).trim()+o+";",1===z||2===z&&n(o,1)?"-webkit-"+o+o:o}if(0===z||2===z&&!n(s,1))return s;switch(c){case 1015:return 97===s.charCodeAt(10)?"-webkit-"+s+s:s;case 951:return 116===s.charCodeAt(3)?"-webkit-"+s+s:s;case 963:return 110===s.charCodeAt(5)?"-webkit-"+s+s:s;case 1009:if(100!==s.charCodeAt(4))break;case 969:case 942:return "-webkit-"+s+s;case 978:return "-webkit-"+s+"-moz-"+s+s;case 1019:case 983:return "-webkit-"+s+"-moz-"+s+"-ms-"+s+s;case 883:if(45===s.charCodeAt(8))return "-webkit-"+s+s;if(0<s.indexOf("image-set(",11))return s.replace(S,"$1-webkit-$2")+s;break;case 932:if(45===s.charCodeAt(4))switch(s.charCodeAt(5)){case 103:return "-webkit-box-"+s.replace("-grow","")+"-webkit-"+s+"-ms-"+s.replace("grow","positive")+s;case 115:return "-webkit-"+s+"-ms-"+s.replace("shrink","negative")+s;case 98:return "-webkit-"+s+"-ms-"+s.replace("basis","preferred-size")+s}return "-webkit-"+s+"-ms-"+s+s;case 964:return "-webkit-"+s+"-ms-flex-"+s+s;case 1023:if(99!==s.charCodeAt(8))break;return "-webkit-box-pack"+(o=s.substring(s.indexOf(":",15)).replace("flex-","").replace("space-between","justify"))+"-webkit-"+s+"-ms-flex-pack"+o+s;case 1005:return d.test(s)?s.replace(u,":-webkit-")+s.replace(u,":-moz-")+s:s;case 1e3:switch(r=(o=s.substring(13).trim()).indexOf("-")+1,o.charCodeAt(0)+o.charCodeAt(r)){case 226:o=s.replace(v,"tb");break;case 232:o=s.replace(v,"tb-rl");break;case 220:o=s.replace(v,"lr");break;default:return s}return "-webkit-"+s+"-ms-"+o+s;case 1017:if(-1===s.indexOf("sticky",9))break;case 975:switch(r=(s=e).length-10,c=(o=(33===s.charCodeAt(r)?s.substring(0,r):s).substring(e.indexOf(":",7)+1).trim()).charCodeAt(0)+(0|o.charCodeAt(7))){case 203:if(111>o.charCodeAt(8))break;case 115:s=s.replace(o,"-webkit-"+o)+";"+s;break;case 207:case 102:s=s.replace(o,"-webkit-"+(102<c?"inline-":"")+"box")+";"+s.replace(o,"-webkit-"+o)+";"+s.replace(o,"-ms-"+o+"box")+";"+s;}return s+";";case 938:if(45===s.charCodeAt(5))switch(s.charCodeAt(6)){case 105:return o=s.replace("-items",""),"-webkit-"+s+"-webkit-box-"+o+"-ms-flex-"+o+s;case 115:return "-webkit-"+s+"-ms-flex-item-"+s.replace(A,"")+s;default:return "-webkit-"+s+"-ms-flex-line-pack"+s.replace("align-content","").replace(A,"")+s}break;case 973:case 989:if(45!==s.charCodeAt(3)||122===s.charCodeAt(4))break;case 931:case 953:if(!0===x.test(e))return 115===(o=e.substring(e.indexOf(":")+1)).charCodeAt(0)?a(e.replace("stretch","fill-available"),r,t,i).replace(":fill-available",":stretch"):s.replace(o,"-webkit-"+o)+s.replace(o,"-moz-"+o.replace("fill-",""))+s;break;case 962:if(s="-webkit-"+s+(102===s.charCodeAt(5)?"-ms-"+s:"")+s,211===t+i&&105===s.charCodeAt(13)&&0<s.indexOf("transform",10))return s.substring(0,s.indexOf(";",27)+1).replace(h,"$1-webkit-$2")+s}return s}function n(e,r){var t=e.indexOf(1===r?":":"{"),a=e.substring(0,3!==r?t:10);return t=e.substring(t+1,e.length-1),G(2!==r?a:a.replace(C,"$1"),t,r)}function i(e,r){var t=a(r,r.charCodeAt(0),r.charCodeAt(1),r.charCodeAt(2));return t!==r+";"?t.replace(y," or ($1)").substring(4):"("+r+")"}function s(e,r,t,a,n,i,s,c,l,f){for(var u,d=0,h=r;d<_;++d)switch(u=R[d].call(o,e,h,t,a,n,i,s,c,l,f)){case void 0:case!1:case!0:case null:break;default:h=u;}if(h!==r)return h}function c(e){return void 0!==(e=e.prefix)&&(G=null,e?"function"!=typeof e?z=1:(z=2,G=e):z=0),c}function o(e,t){var c=e;if(33>c.charCodeAt(0)&&(c=c.trim()),c=[c],0<_){var o=s(-1,t,c,c,$,O,0,0,0,0);void 0!==o&&"string"==typeof o&&(t=o);}var u=function e(t,c,o,u,d){for(var h,b,g,v,y,A=0,C=0,x=0,S=0,R=0,G=0,I=g=h=0,M=0,W=0,P=0,D=0,F=o.length,L=F-1,T="",q="",B="",H="";M<F;){if(b=o.charCodeAt(M),M===L&&0!==C+S+x+A&&(0!==C&&(b=47===C?10:47),S=x=A=0,F++,L++),0===C+S+x+A){if(M===L&&(0<W&&(T=T.replace(f,"")),0<T.trim().length)){switch(b){case 32:case 9:case 59:case 13:case 10:break;default:T+=o.charAt(M);}b=59;}switch(b){case 123:for(h=(T=T.trim()).charCodeAt(0),g=1,D=++M;M<F;){switch(b=o.charCodeAt(M)){case 123:g++;break;case 125:g--;break;case 47:switch(b=o.charCodeAt(M+1)){case 42:case 47:e:{for(I=M+1;I<L;++I)switch(o.charCodeAt(I)){case 47:if(42===b&&42===o.charCodeAt(I-1)&&M+2!==I){M=I+1;break e}break;case 10:if(47===b){M=I+1;break e}}M=I;}}break;case 91:b++;case 40:b++;case 34:case 39:for(;M++<L&&o.charCodeAt(M)!==b;);}if(0===g)break;M++;}switch(g=o.substring(D,M),0===h&&(h=(T=T.replace(l,"").trim()).charCodeAt(0)),h){case 64:switch(0<W&&(T=T.replace(f,"")),b=T.charCodeAt(1)){case 100:case 109:case 115:case 45:W=c;break;default:W=E;}if(D=(g=e(c,W,g,b,d+1)).length,0<_&&(y=s(3,g,W=r(E,T,P),c,$,O,D,b,d,u),T=W.join(""),void 0!==y&&0===(D=(g=y.trim()).length)&&(b=0,g="")),0<D)switch(b){case 115:T=T.replace(w,i);case 100:case 109:case 45:g=T+"{"+g+"}";break;case 107:g=(T=T.replace(p,"$1 $2"))+"{"+g+"}",g=1===z||2===z&&n("@"+g,3)?"@-webkit-"+g+"@"+g:"@"+g;break;default:g=T+g,112===u&&(q+=g,g="");}else g="";break;default:g=e(c,r(c,T,P),g,u,d+1);}B+=g,g=P=W=I=h=0,T="",b=o.charCodeAt(++M);break;case 125:case 59:if(1<(D=(T=(0<W?T.replace(f,""):T).trim()).length))switch(0===I&&(h=T.charCodeAt(0),45===h||96<h&&123>h)&&(D=(T=T.replace(" ",":")).length),0<_&&void 0!==(y=s(1,T,c,t,$,O,q.length,u,d,u))&&0===(D=(T=y.trim()).length)&&(T="\0\0"),h=T.charCodeAt(0),b=T.charCodeAt(1),h){case 0:break;case 64:if(105===b||99===b){H+=T+o.charAt(M);break}default:58!==T.charCodeAt(D-1)&&(q+=a(T,h,b,T.charCodeAt(2)));}P=W=I=h=0,T="",b=o.charCodeAt(++M);}}switch(b){case 13:case 10:47===C?C=0:0===1+h&&107!==u&&0<T.length&&(W=1,T+="\0"),0<_*N&&s(0,T,c,t,$,O,q.length,u,d,u),O=1,$++;break;case 59:case 125:if(0===C+S+x+A){O++;break}default:switch(O++,v=o.charAt(M),b){case 9:case 32:if(0===S+A+C)switch(R){case 44:case 58:case 9:case 32:v="";break;default:32!==b&&(v=" ");}break;case 0:v="\\0";break;case 12:v="\\f";break;case 11:v="\\v";break;case 38:0===S+C+A&&(W=P=1,v="\f"+v);break;case 108:if(0===S+C+A+j&&0<I)switch(M-I){case 2:112===R&&58===o.charCodeAt(M-3)&&(j=R);case 8:111===G&&(j=G);}break;case 58:0===S+C+A&&(I=M);break;case 44:0===C+x+S+A&&(W=1,v+="\r");break;case 34:case 39:0===C&&(S=S===b?0:0===S?b:S);break;case 91:0===S+C+x&&A++;break;case 93:0===S+C+x&&A--;break;case 41:0===S+C+A&&x--;break;case 40:if(0===S+C+A){if(0===h)switch(2*R+3*G){case 533:break;default:h=1;}x++;}break;case 64:0===C+x+S+A+I+g&&(g=1);break;case 42:case 47:if(!(0<S+A+x))switch(C){case 0:switch(2*b+3*o.charCodeAt(M+1)){case 235:C=47;break;case 220:D=M,C=42;}break;case 42:47===b&&42===R&&D+2!==M&&(33===o.charCodeAt(D+2)&&(q+=o.substring(D,M+1)),v="",C=0);}}0===C&&(T+=v);}G=R,R=b,M++;}if(0<(D=q.length)){if(W=c,0<_&&void 0!==(y=s(2,q,W,t,$,O,D,u,d,u))&&0===(q=y).length)return H+q+B;if(q=W.join(",")+"{"+q+"}",0!=z*j){switch(2!==z||n(q,2)||(j=0),j){case 111:q=q.replace(k,":-moz-$1")+q;break;case 112:q=q.replace(m,"::-webkit-input-$1")+q.replace(m,"::-moz-$1")+q.replace(m,":-ms-input-$1")+q;}j=0;}}return H+q+B}(E,c,t,0,0);return 0<_&&(void 0!==(o=s(-2,u,c,c,$,O,u.length,0,0,0))&&(u=o)),j=0,O=$=1,u}var l=/^\0+/g,f=/[\0\r\f]/g,u=/: */g,d=/zoo|gra/,h=/([,: ])(transform)/g,b=/,\r+?/g,g=/([\t\r\n ])*\f?&/g,p=/@(k\w+)\s*(\S*)\s*/,m=/::(place)/g,k=/:(read-only)/g,v=/[svh]\w+-[tblr]{2}/,w=/\(\s*(.*)\s*\)/g,y=/([\s\S]*?);/g,A=/-self|flex-/g,C=/[^]*?(:[rp][el]a[\w-]+)[^]*/,x=/stretch|:\s*\w+\-(?:conte|avail)/,S=/([^-])(image-set\()/,O=1,$=1,j=0,z=1,E=[],R=[],_=0,G=null,N=0;return o.use=function e(r){switch(r){case void 0:case null:_=R.length=0;break;default:if("function"==typeof r)R[_++]=r;else if("object"==typeof r)for(var t=0,a=r.length;t<a;++t)e(r[t]);else N=0|!!r;}return e},o.set=c,void 0!==e&&c(e),o}function a(e){e&&n.current.insert(e+"}");}var n={current:null},i=function(e,r,t,i,s,c,o,l,f,u){switch(e){case 1:switch(r.charCodeAt(0)){case 64:return n.current.insert(r+";"),"";case 108:if(98===r.charCodeAt(2))return ""}break;case 2:if(0===l)return r+"/*|*/";break;case 3:switch(l){case 102:case 112:return n.current.insert(t[0]+r),"";default:return r+(0===u?"/*|*/":"")}case-2:r.split("/*|*/}").forEach(a);}};var s={animationIterationCount:1,borderImageOutset:1,borderImageSlice:1,borderImageWidth:1,boxFlex:1,boxFlexGroup:1,boxOrdinalGroup:1,columnCount:1,columns:1,flex:1,flexGrow:1,flexPositive:1,flexShrink:1,flexNegative:1,flexOrder:1,gridRow:1,gridRowEnd:1,gridRowSpan:1,gridRowStart:1,gridColumn:1,gridColumnEnd:1,gridColumnSpan:1,gridColumnStart:1,msGridRow:1,msGridRowSpan:1,msGridColumn:1,msGridColumnSpan:1,fontWeight:1,lineHeight:1,opacity:1,order:1,orphans:1,tabSize:1,widows:1,zIndex:1,zoom:1,WebkitLineClamp:1,fillOpacity:1,floodOpacity:1,stopOpacity:1,strokeDasharray:1,strokeDashoffset:1,strokeMiterlimit:1,strokeOpacity:1,strokeWidth:1};var c=/[A-Z]|^ms/g,o=/_EMO_([^_]+?)_([^]*?)_EMO_/g,l=function(e){return 45===e.charCodeAt(1)},f=function(e){var r={};return function(t){return void 0===r[t]&&(r[t]=e(t)),r[t]}}(function(e){return l(e)?e:e.replace(c,"-$&").toLowerCase()}),u=function(e,r){if(null==r||"boolean"==typeof r)return "";switch(e){case"animation":case"animationName":if("string"==typeof r)return r.replace(o,function(e,r,t){return h={name:r,styles:t,next:h},r})}return 1===s[e]||l(e)||"number"!=typeof r||0===r?r:r+"px"};function d(e,r,t,a){if(null==t)return "";if(void 0!==t.__emotion_styles)return t;switch(typeof t){case"boolean":return "";case"object":if(1===t.anim)return h={name:t.name,styles:t.styles,next:h},t.name;if(void 0!==t.styles){var n=t.next;if(void 0!==n)for(;void 0!==n;)h={name:n.name,styles:n.styles,next:h},n=n.next;return t.styles}return function(e,r,t){var a="";if(Array.isArray(t))for(var n=0;n<t.length;n++)a+=d(e,r,t[n],!1);else for(var i in t){var s=t[i];if("object"!=typeof s)null!=r&&void 0!==r[s]?a+=i+"{"+r[s]+"}":a+=f(i)+":"+u(i,s)+";";else if(!Array.isArray(s)||"string"!=typeof s[0]||null!=r&&void 0!==r[s[0]]){var c=d(e,r,s,!1);switch(i){case"animation":case"animationName":a+=f(i)+":"+c+";";break;default:a+=i+"{"+c+"}";}}else for(var o=0;o<s.length;o++)a+=f(i)+":"+u(i,s[o])+";";}return a}(e,r,t);case"function":if(void 0!==e){var i=h,s=t(e);return h=i,d(e,r,s,a)}default:if(null==r)return t;var c=r[t];return void 0===c||a?t:c}}var h,b=/label:\s*([^\s;\n{]+)\s*;/g,g=function(e,r,t){if(1===e.length&&"object"==typeof e[0]&&null!==e[0]&&void 0!==e[0].styles)return e[0];var a=!0,n="";h=void 0;var i=e[0];null==i||void 0===i.raw?(a=!1,n+=d(t,r,i,!1)):n+=i[0];for(var s=1;s<e.length;s++)n+=d(t,r,e[s],46===n.charCodeAt(n.length-1)),a&&(n+=i[s]);b.lastIndex=0;for(var c,o="";null!==(c=b.exec(n));)o+="-"+c[1];return {name:function(e){for(var r,t=e.length,a=t^t,n=0;t>=4;)r=1540483477*(65535&(r=255&e.charCodeAt(n)|(255&e.charCodeAt(++n))<<8|(255&e.charCodeAt(++n))<<16|(255&e.charCodeAt(++n))<<24))+((1540483477*(r>>>16)&65535)<<16),a=1540483477*(65535&a)+((1540483477*(a>>>16)&65535)<<16)^(r=1540483477*(65535&(r^=r>>>24))+((1540483477*(r>>>16)&65535)<<16)),t-=4,++n;switch(t){case 3:a^=(255&e.charCodeAt(n+2))<<16;case 2:a^=(255&e.charCodeAt(n+1))<<8;case 1:a=1540483477*(65535&(a^=255&e.charCodeAt(n)))+((1540483477*(a>>>16)&65535)<<16);}return a=1540483477*(65535&(a^=a>>>13))+((1540483477*(a>>>16)&65535)<<16),((a^=a>>>15)>>>0).toString(36)}(n)+o,styles:n,next:h}};function p(e,r,t){var a="";return t.split(" ").forEach(function(t){void 0!==e[t]?r.push(e[t]):a+=t+" ";}),a}function m(e,r){if(void 0===e.inserted[r.name])return e.insert("",r,e.sheet,!0)}function k(e,r,t){var a=[],n=p(e,a,t);return a.length<2?t:n+r(a)}var v=function e(r){for(var t="",a=0;a<r.length;a++){var n=r[a];if(null!=n){var i=void 0;switch(typeof n){case"boolean":break;case"object":if(Array.isArray(n))i=e(n);else for(var s in i="",n)n[s]&&s&&(i&&(i+=" "),i+=s);break;default:i=n;}i&&(t&&(t+=" "),t+=i);}}return t},w=function(e){var a=function(e){void 0===e&&(e={});var a,s=e.key||"css";void 0!==e.prefix&&(a={prefix:e.prefix});var c,o=new t(a),l={};c=e.container||document.head;var f,u=document.querySelectorAll("style[data-emotion-"+s+"]");Array.prototype.forEach.call(u,function(e){e.getAttribute("data-emotion-"+s).split(" ").forEach(function(e){l[e]=!0;}),e.parentNode!==c&&c.appendChild(e);}),o.use(e.stylisPlugins)(i),f=function(e,r,t,a){var i=r.name;n.current=t,o(e,r.styles),a&&(d.inserted[i]=!0);};var d={key:s,sheet:new r({key:s,container:c,nonce:e.nonce,speedy:e.speedy}),nonce:e.nonce,inserted:l,registered:{},insert:f};return d}(e);a.sheet.speedy=function(e){this.isSpeedy=e;},a.compat=!0;var s=function(){for(var e=arguments.length,r=new Array(e),t=0;t<e;t++)r[t]=arguments[t];var n=g(r,a.registered,void 0);return function(e,r,t){var a=e.key+"-"+r.name;if(!1===t&&void 0===e.registered[a]&&(e.registered[a]=r.styles),void 0===e.inserted[r.name]){var n=r;do{e.insert("."+a,n,e.sheet,!0),n=n.next;}while(void 0!==n)}}(a,n,!1),a.key+"-"+n.name};return {css:s,cx:function(){for(var e=arguments.length,r=new Array(e),t=0;t<e;t++)r[t]=arguments[t];return k(a.registered,s,v(r))},injectGlobal:function(){for(var e=arguments.length,r=new Array(e),t=0;t<e;t++)r[t]=arguments[t];var n=g(r,a.registered);m(a,n);},keyframes:function(){for(var e=arguments.length,r=new Array(e),t=0;t<e;t++)r[t]=arguments[t];var n=g(r,a.registered),i="animation-"+n.name;return m(a,{name:n.name,styles:"@keyframes "+i+"{"+n.styles+"}"}),i},hydrate:function(e){e.forEach(function(e){a.inserted[e]=!0;});},flush:function(){a.registered={},a.inserted={},a.sheet.flush();},sheet:a.sheet,cache:a,getRegisteredStyles:p.bind(null,a.registered),merge:k.bind(null,a.registered,s)}}(),y=w.flush,A=w.hydrate,C=w.cx,x=w.merge,S=w.getRegisteredStyles,O=w.injectGlobal,$=w.keyframes,j=w.css,z=w.sheet,E=w.cache;e.cache=E,e.css=j,e.cx=C,e.flush=y,e.getRegisteredStyles=S,e.hydrate=A,e.injectGlobal=O,e.keyframes=$,e.merge=x,e.sheet=z,Object.defineProperty(e,"__esModule",{value:!0});});
    //# sourceMappingURL=emotion.umd.min.js.map
    });

    var emotion = unwrapExports(emotion_umd_min);

    const { css } = emotion;

    const col1 = css` { 
	float: left; 
	width: 100%;  
}`;

    const col2 = css` {  
	float: left; 
	width: 50%;
}`;

    const col3 = css` {
	float: left;  
	width: 33.333333%;
}`;

    /* src\Button.svelte generated by Svelte v3.12.1 */

    const file = "src\\Button.svelte";

    function create_fragment(ctx) {
    	var button, t, button_class_value, dispose;

    	const block = {
    		c: function create() {
    			button = element("button");
    			t = text(ctx.title);
    			attr_dev(button, "class", button_class_value = "" + null_to_empty(ctx.klass) + " svelte-hrvg8g");
    			button.disabled = ctx.disabled;
    			add_location(button, file, 17, 0, 254);
    			dispose = listen_dev(button, "click", ctx.click);
    		},

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: function mount(target, anchor) {
    			insert_dev(target, button, anchor);
    			append_dev(button, t);
    		},

    		p: function update(changed, ctx) {
    			if (changed.title) {
    				set_data_dev(t, ctx.title);
    			}

    			if ((changed.klass) && button_class_value !== (button_class_value = "" + null_to_empty(ctx.klass) + " svelte-hrvg8g")) {
    				attr_dev(button, "class", button_class_value);
    			}

    			if (changed.disabled) {
    				prop_dev(button, "disabled", ctx.disabled);
    			}
    		},

    		i: noop,
    		o: noop,

    		d: function destroy(detaching) {
    			if (detaching) {
    				detach_dev(button);
    			}

    			dispose();
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment.name, type: "component", source: "", ctx });
    	return block;
    }

    function instance($$self, $$props, $$invalidate) {
    	let { click, disabled, title, klass } = $$props;

    	if (window.innerWidth < 600) $$invalidate('klass', klass=col1);

    	const writable_props = ['click', 'disabled', 'title', 'klass'];
    	Object.keys($$props).forEach(key => {
    		if (!writable_props.includes(key) && !key.startsWith('$$')) console.warn(`<Button> was created with unknown prop '${key}'`);
    	});

    	$$self.$set = $$props => {
    		if ('click' in $$props) $$invalidate('click', click = $$props.click);
    		if ('disabled' in $$props) $$invalidate('disabled', disabled = $$props.disabled);
    		if ('title' in $$props) $$invalidate('title', title = $$props.title);
    		if ('klass' in $$props) $$invalidate('klass', klass = $$props.klass);
    	};

    	$$self.$capture_state = () => {
    		return { click, disabled, title, klass };
    	};

    	$$self.$inject_state = $$props => {
    		if ('click' in $$props) $$invalidate('click', click = $$props.click);
    		if ('disabled' in $$props) $$invalidate('disabled', disabled = $$props.disabled);
    		if ('title' in $$props) $$invalidate('title', title = $$props.title);
    		if ('klass' in $$props) $$invalidate('klass', klass = $$props.klass);
    	};

    	return { click, disabled, title, klass };
    }

    class Button extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance, create_fragment, safe_not_equal, ["click", "disabled", "title", "klass"]);
    		dispatch_dev("SvelteRegisterComponent", { component: this, tagName: "Button", options, id: create_fragment.name });

    		const { ctx } = this.$$;
    		const props = options.props || {};
    		if (ctx.click === undefined && !('click' in props)) {
    			console.warn("<Button> was created without expected prop 'click'");
    		}
    		if (ctx.disabled === undefined && !('disabled' in props)) {
    			console.warn("<Button> was created without expected prop 'disabled'");
    		}
    		if (ctx.title === undefined && !('title' in props)) {
    			console.warn("<Button> was created without expected prop 'title'");
    		}
    		if (ctx.klass === undefined && !('klass' in props)) {
    			console.warn("<Button> was created without expected prop 'klass'");
    		}
    	}

    	get click() {
    		throw new Error("<Button>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set click(value) {
    		throw new Error("<Button>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	get disabled() {
    		throw new Error("<Button>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set disabled(value) {
    		throw new Error("<Button>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	get title() {
    		throw new Error("<Button>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set title(value) {
    		throw new Error("<Button>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	get klass() {
    		throw new Error("<Button>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set klass(value) {
    		throw new Error("<Button>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}
    }

    /* src\State.svelte generated by Svelte v3.12.1 */

    const file$1 = "src\\State.svelte";

    function create_fragment$1(ctx) {
    	var button, t0_value = ctx.state.action + "", t0, t1, t2_value = ctx.state.store.a + "", t2, t3, t4_value = ctx.state.store.b + "", t4, t5, t6_value = ctx.state.store.hist + "", t6, t7, dispose;

    	const block = {
    		c: function create() {
    			button = element("button");
    			t0 = text(t0_value);
    			t1 = text(" a:");
    			t2 = text(t2_value);
    			t3 = text(" b:");
    			t4 = text(t4_value);
    			t5 = text(" hist:[");
    			t6 = text(t6_value);
    			t7 = text("]");
    			attr_dev(button, "class", "col1");
    			add_location(button, file$1, 13, 0, 318);
    			dispose = listen_dev(button, "click", ctx.fixState);
    		},

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: function mount(target, anchor) {
    			insert_dev(target, button, anchor);
    			append_dev(button, t0);
    			append_dev(button, t1);
    			append_dev(button, t2);
    			append_dev(button, t3);
    			append_dev(button, t4);
    			append_dev(button, t5);
    			append_dev(button, t6);
    			append_dev(button, t7);
    		},

    		p: function update(changed, ctx) {
    			if ((changed.state) && t0_value !== (t0_value = ctx.state.action + "")) {
    				set_data_dev(t0, t0_value);
    			}

    			if ((changed.state) && t2_value !== (t2_value = ctx.state.store.a + "")) {
    				set_data_dev(t2, t2_value);
    			}

    			if ((changed.state) && t4_value !== (t4_value = ctx.state.store.b + "")) {
    				set_data_dev(t4, t4_value);
    			}

    			if ((changed.state) && t6_value !== (t6_value = ctx.state.store.hist + "")) {
    				set_data_dev(t6, t6_value);
    			}
    		},

    		i: noop,
    		o: noop,

    		d: function destroy(detaching) {
    			if (detaching) {
    				detach_dev(button);
    			}

    			dispose();
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment$1.name, type: "component", source: "", ctx });
    	return block;
    }

    function instance$1($$self, $$props, $$invalidate) {
    	
    	const dispatch = createEventDispatcher();
    	let { state } = $$props;
    	// console.log('State',state)
    	const fixState = () => dispatch('fixstate',state);

    	const writable_props = ['state'];
    	Object.keys($$props).forEach(key => {
    		if (!writable_props.includes(key) && !key.startsWith('$$')) console.warn(`<State> was created with unknown prop '${key}'`);
    	});

    	$$self.$set = $$props => {
    		if ('state' in $$props) $$invalidate('state', state = $$props.state);
    	};

    	$$self.$capture_state = () => {
    		return { state };
    	};

    	$$self.$inject_state = $$props => {
    		if ('state' in $$props) $$invalidate('state', state = $$props.state);
    	};

    	return { state, fixState };
    }

    class State extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance$1, create_fragment$1, safe_not_equal, ["state"]);
    		dispatch_dev("SvelteRegisterComponent", { component: this, tagName: "State", options, id: create_fragment$1.name });

    		const { ctx } = this.$$;
    		const props = options.props || {};
    		if (ctx.state === undefined && !('state' in props)) {
    			console.warn("<State> was created without expected prop 'state'");
    		}
    	}

    	get state() {
    		throw new Error("<State>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set state(value) {
    		throw new Error("<State>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}
    }

    /* src\TimeMachine.svelte generated by Svelte v3.12.1 */

    const file$2 = "src\\TimeMachine.svelte";

    function get_each_context(ctx, list, i) {
    	const child_ctx = Object.create(ctx);
    	child_ctx.state = list[i];
    	return child_ctx;
    }

    // (10:1) {#each states as state}
    function create_each_block(ctx) {
    	var current;

    	var state = new State({
    		props: { state: ctx.state },
    		$$inline: true
    	});
    	state.$on("fixstate", ctx.fixstate_handler);

    	const block = {
    		c: function create() {
    			state.$$.fragment.c();
    		},

    		m: function mount(target, anchor) {
    			mount_component(state, target, anchor);
    			current = true;
    		},

    		p: function update(changed, ctx) {
    			var state_changes = {};
    			if (changed.states) state_changes.state = ctx.state;
    			state.$set(state_changes);
    		},

    		i: function intro(local) {
    			if (current) return;
    			transition_in(state.$$.fragment, local);

    			current = true;
    		},

    		o: function outro(local) {
    			transition_out(state.$$.fragment, local);
    			current = false;
    		},

    		d: function destroy(detaching) {
    			destroy_component(state, detaching);
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_each_block.name, type: "each", source: "(10:1) {#each states as state}", ctx });
    	return block;
    }

    function create_fragment$2(ctx) {
    	var div, current;

    	let each_value = ctx.states;

    	let each_blocks = [];

    	for (let i = 0; i < each_value.length; i += 1) {
    		each_blocks[i] = create_each_block(get_each_context(ctx, each_value, i));
    	}

    	const out = i => transition_out(each_blocks[i], 1, 1, () => {
    		each_blocks[i] = null;
    	});

    	const block = {
    		c: function create() {
    			div = element("div");

    			for (let i = 0; i < each_blocks.length; i += 1) {
    				each_blocks[i].c();
    			}
    			add_location(div, file$2, 8, 0, 190);
    		},

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: function mount(target, anchor) {
    			insert_dev(target, div, anchor);

    			for (let i = 0; i < each_blocks.length; i += 1) {
    				each_blocks[i].m(div, null);
    			}

    			current = true;
    		},

    		p: function update(changed, ctx) {
    			if (changed.states) {
    				each_value = ctx.states;

    				let i;
    				for (i = 0; i < each_value.length; i += 1) {
    					const child_ctx = get_each_context(ctx, each_value, i);

    					if (each_blocks[i]) {
    						each_blocks[i].p(changed, child_ctx);
    						transition_in(each_blocks[i], 1);
    					} else {
    						each_blocks[i] = create_each_block(child_ctx);
    						each_blocks[i].c();
    						transition_in(each_blocks[i], 1);
    						each_blocks[i].m(div, null);
    					}
    				}

    				group_outros();
    				for (i = each_value.length; i < each_blocks.length; i += 1) {
    					out(i);
    				}
    				check_outros();
    			}
    		},

    		i: function intro(local) {
    			if (current) return;
    			for (let i = 0; i < each_value.length; i += 1) {
    				transition_in(each_blocks[i]);
    			}

    			current = true;
    		},

    		o: function outro(local) {
    			each_blocks = each_blocks.filter(Boolean);
    			for (let i = 0; i < each_blocks.length; i += 1) {
    				transition_out(each_blocks[i]);
    			}

    			current = false;
    		},

    		d: function destroy(detaching) {
    			if (detaching) {
    				detach_dev(div);
    			}

    			destroy_each(each_blocks, detaching);
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment$2.name, type: "component", source: "", ctx });
    	return block;
    }

    function instance$2($$self, $$props, $$invalidate) {
    	
    	let { states, touch } = $$props;

    	const writable_props = ['states', 'touch'];
    	Object.keys($$props).forEach(key => {
    		if (!writable_props.includes(key) && !key.startsWith('$$')) console.warn(`<TimeMachine> was created with unknown prop '${key}'`);
    	});

    	function fixstate_handler(event) {
    		bubble($$self, event);
    	}

    	$$self.$set = $$props => {
    		if ('states' in $$props) $$invalidate('states', states = $$props.states);
    		if ('touch' in $$props) $$invalidate('touch', touch = $$props.touch);
    	};

    	$$self.$capture_state = () => {
    		return { states, touch };
    	};

    	$$self.$inject_state = $$props => {
    		if ('states' in $$props) $$invalidate('states', states = $$props.states);
    		if ('touch' in $$props) $$invalidate('touch', touch = $$props.touch);
    	};

    	return { states, touch, fixstate_handler };
    }

    class TimeMachine extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance$2, create_fragment$2, safe_not_equal, ["states", "touch"]);
    		dispatch_dev("SvelteRegisterComponent", { component: this, tagName: "TimeMachine", options, id: create_fragment$2.name });

    		const { ctx } = this.$$;
    		const props = options.props || {};
    		if (ctx.states === undefined && !('states' in props)) {
    			console.warn("<TimeMachine> was created without expected prop 'states'");
    		}
    		if (ctx.touch === undefined && !('touch' in props)) {
    			console.warn("<TimeMachine> was created without expected prop 'touch'");
    		}
    	}

    	get states() {
    		throw new Error("<TimeMachine>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set states(value) {
    		throw new Error("<TimeMachine>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	get touch() {
    		throw new Error("<TimeMachine>: Props cannot be read directly from the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}

    	set touch(value) {
    		throw new Error("<TimeMachine>: Props cannot be set directly on the component instance unless compiling with 'accessors: true' or '<svelte:options accessors/>'");
    	}
    }

    /* src\App.svelte generated by Svelte v3.12.1 */

    const file$3 = "src\\App.svelte";

    // (112:0) {#if USE_TIME_MACHINE}
    function create_if_block(ctx) {
    	var current;

    	var timemachine = new TimeMachine({
    		props: {
    		touch: ctx.touch,
    		states: ctx.states
    	},
    		$$inline: true
    	});
    	timemachine.$on("fixstate", ctx.fixState);

    	const block = {
    		c: function create() {
    			timemachine.$$.fragment.c();
    		},

    		m: function mount(target, anchor) {
    			mount_component(timemachine, target, anchor);
    			current = true;
    		},

    		p: function update(changed, ctx) {
    			var timemachine_changes = {};
    			if (changed.states) timemachine_changes.states = ctx.states;
    			timemachine.$set(timemachine_changes);
    		},

    		i: function intro(local) {
    			if (current) return;
    			transition_in(timemachine.$$.fragment, local);

    			current = true;
    		},

    		o: function outro(local) {
    			transition_out(timemachine.$$.fragment, local);
    			current = false;
    		},

    		d: function destroy(detaching) {
    			destroy_component(timemachine, detaching);
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_if_block.name, type: "if", source: "(112:0) {#if USE_TIME_MACHINE}", ctx });
    	return block;
    }

    function create_fragment$3(ctx) {
    	var h10, t0_value = ctx.$store.a + "", t0, t1, h11, t2_value = ctx.$store.b + "", t2, t3, t4, t5, t6, t7, t8, if_block_anchor, current;

    	var button0 = new Button({
    		props: {
    		klass: col3,
    		title: "+2",
    		click: ctx.func,
    		disabled: ctx.$store.a==ctx.$store.b
    	},
    		$$inline: true
    	});

    	var button1 = new Button({
    		props: {
    		klass: col3,
    		title: "*2",
    		click: ctx.func_1,
    		disabled: ctx.$store.a==ctx.$store.b
    	},
    		$$inline: true
    	});

    	var button2 = new Button({
    		props: {
    		klass: col3,
    		title: "/2",
    		click: ctx.func_2,
    		disabled: ctx.$store.a==ctx.$store.b
    	},
    		$$inline: true
    	});

    	var button3 = new Button({
    		props: {
    		klass: col2,
    		title: "New",
    		click: ctx.func_3,
    		disabled: ctx.$store.a!=ctx.$store.b
    	},
    		$$inline: true
    	});

    	var button4 = new Button({
    		props: {
    		klass: col2,
    		title: "Undo",
    		click: ctx.func_4,
    		disabled: ctx.$store.hist.length==0
    	},
    		$$inline: true
    	});

    	var if_block =  create_if_block(ctx);

    	const block = {
    		c: function create() {
    			h10 = element("h1");
    			t0 = text(t0_value);
    			t1 = space();
    			h11 = element("h1");
    			t2 = text(t2_value);
    			t3 = space();
    			button0.$$.fragment.c();
    			t4 = space();
    			button1.$$.fragment.c();
    			t5 = space();
    			button2.$$.fragment.c();
    			t6 = space();
    			button3.$$.fragment.c();
    			t7 = space();
    			button4.$$.fragment.c();
    			t8 = space();
    			if (if_block) if_block.c();
    			if_block_anchor = empty();
    			attr_dev(h10, "class", "" + col2 + " svelte-1of37l2");
    			set_style(h10, "font-size", "60px");
    			set_style(h10, "color", "red");
    			add_location(h10, file$3, 103, 0, 2043);
    			attr_dev(h11, "class", "" + col2 + " svelte-1of37l2");
    			set_style(h11, "font-size", "60px");
    			set_style(h11, "color", "green");
    			add_location(h11, file$3, 104, 0, 2112);
    		},

    		l: function claim(nodes) {
    			throw new Error("options.hydrate only works if the component was compiled with the `hydratable: true` option");
    		},

    		m: function mount(target, anchor) {
    			insert_dev(target, h10, anchor);
    			append_dev(h10, t0);
    			insert_dev(target, t1, anchor);
    			insert_dev(target, h11, anchor);
    			append_dev(h11, t2);
    			insert_dev(target, t3, anchor);
    			mount_component(button0, target, anchor);
    			insert_dev(target, t4, anchor);
    			mount_component(button1, target, anchor);
    			insert_dev(target, t5, anchor);
    			mount_component(button2, target, anchor);
    			insert_dev(target, t6, anchor);
    			mount_component(button3, target, anchor);
    			insert_dev(target, t7, anchor);
    			mount_component(button4, target, anchor);
    			insert_dev(target, t8, anchor);
    			if (if_block) if_block.m(target, anchor);
    			insert_dev(target, if_block_anchor, anchor);
    			current = true;
    		},

    		p: function update(changed, ctx) {
    			if ((!current || changed.$store) && t0_value !== (t0_value = ctx.$store.a + "")) {
    				set_data_dev(t0, t0_value);
    			}

    			if ((!current || changed.$store) && t2_value !== (t2_value = ctx.$store.b + "")) {
    				set_data_dev(t2, t2_value);
    			}

    			var button0_changes = {};
    			if (changed.$store) button0_changes.disabled = ctx.$store.a==ctx.$store.b;
    			button0.$set(button0_changes);

    			var button1_changes = {};
    			if (changed.$store) button1_changes.disabled = ctx.$store.a==ctx.$store.b;
    			button1.$set(button1_changes);

    			var button2_changes = {};
    			if (changed.$store) button2_changes.disabled = ctx.$store.a==ctx.$store.b;
    			button2.$set(button2_changes);

    			var button3_changes = {};
    			if (changed.$store) button3_changes.disabled = ctx.$store.a!=ctx.$store.b;
    			button3.$set(button3_changes);

    			var button4_changes = {};
    			if (changed.$store) button4_changes.disabled = ctx.$store.hist.length==0;
    			button4.$set(button4_changes);

    			if_block.p(changed, ctx);
    		},

    		i: function intro(local) {
    			if (current) return;
    			transition_in(button0.$$.fragment, local);

    			transition_in(button1.$$.fragment, local);

    			transition_in(button2.$$.fragment, local);

    			transition_in(button3.$$.fragment, local);

    			transition_in(button4.$$.fragment, local);

    			transition_in(if_block);
    			current = true;
    		},

    		o: function outro(local) {
    			transition_out(button0.$$.fragment, local);
    			transition_out(button1.$$.fragment, local);
    			transition_out(button2.$$.fragment, local);
    			transition_out(button3.$$.fragment, local);
    			transition_out(button4.$$.fragment, local);
    			transition_out(if_block);
    			current = false;
    		},

    		d: function destroy(detaching) {
    			if (detaching) {
    				detach_dev(h10);
    				detach_dev(t1);
    				detach_dev(h11);
    				detach_dev(t3);
    			}

    			destroy_component(button0, detaching);

    			if (detaching) {
    				detach_dev(t4);
    			}

    			destroy_component(button1, detaching);

    			if (detaching) {
    				detach_dev(t5);
    			}

    			destroy_component(button2, detaching);

    			if (detaching) {
    				detach_dev(t6);
    			}

    			destroy_component(button3, detaching);

    			if (detaching) {
    				detach_dev(t7);
    			}

    			destroy_component(button4, detaching);

    			if (detaching) {
    				detach_dev(t8);
    			}

    			if (if_block) if_block.d(detaching);

    			if (detaching) {
    				detach_dev(if_block_anchor);
    			}
    		}
    	};
    	dispatch_dev("SvelteRegisterBlock", { block, id: create_fragment$3.name, type: "component", source: "", ctx });
    	return block;
    }

    const ADD = 'ADD';

    const MUL = 'MUL';

    const DIV = 'DIV';

    const NEW = 'NEW';

    const UNDO = 'UNDO';

    function instance$3($$self, $$props, $$invalidate) {
    	let $store;

    	validate_store(store$1, 'store');
    	component_subscribe($$self, store$1, $$value => { $store = $$value; $$invalidate('$store', $store); });

    	

    	console.log('store',store$1);

    	let states = [];

    	const touch = () => {
    		$$invalidate('states', states);
    		console.log('touch',states.length);
    	};
    	
    	const random = (a,b) => a+Math.floor((b-a+1)*Math.random());

    	const resetState = () => {
    		if ( states.length > 0) {
    			let state = states[states.length-1];
    			console.log('reset',state.store);
    			store$1.set(state.store); //.slice()
    		}
    	};

    	const saveState = (action) => {
    		{
    			const obj = Object.assign({}, get_store_value(store$1));
    			console.log('saveState',obj,states);
    			let state = {action:action,store:obj}; //.slice()
    			states.push(state);
    			$$invalidate('states', states);
    			// dispatch('fixstate')
    		}
    	};

    	const operation = (st,action) => {
    		resetState();
    		console.log('operation',st);
    		let a = st.a;
    		let b = st.b;
    		let hist = st.hist;

    		if (action == ADD) {
    			hist.push(a);
    			hist=hist;
    			a += 2;
    		} else if (action == MUL) {
    			hist.push(a);
    			hist=hist;
    			a *= 2;
    		} else if (action == DIV) {
    			hist.push(a);
    			hist=hist;
    			a /= 2;
    		} else if (action == NEW) {
    			a = random(1,20);
    			b = random(1,20);
    			hist = [];
    		} else if (action == UNDO) {
    			a = hist.pop();
    			hist = hist; 
    		} else {
    			console.log('Missing action: ' + action);
    		}
    		store$1.set({a:a, b:b, hist:hist.slice()});
    		saveState(action);
    		return {a:a, b:b, hist:hist}
    	}; 

    	const op = (action) => store$1.update( st => operation(st,action) );
    		
    	const fixState = (event) => {
    		let st = event.detail.store;
    		console.log('fixState',st); //.a,event.detail.b,event.detail.hist)
    		store$1.set({a:st.a, b:st.b, hist:st.hist});
    	};

    	op(NEW);

    	const func = () => op(ADD);

    	const func_1 = () => op(MUL);

    	const func_2 = () => op(DIV);

    	const func_3 = () => op(NEW);

    	const func_4 = () => op(UNDO);

    	$$self.$capture_state = () => {
    		return {};
    	};

    	$$self.$inject_state = $$props => {
    		if ('states' in $$props) $$invalidate('states', states = $$props.states);
    		if ('$store' in $$props) store$1.set($store);
    	};

    	return {
    		states,
    		touch,
    		op,
    		fixState,
    		$store,
    		func,
    		func_1,
    		func_2,
    		func_3,
    		func_4
    	};
    }

    class App extends SvelteComponentDev {
    	constructor(options) {
    		super(options);
    		init(this, options, instance$3, create_fragment$3, safe_not_equal, []);
    		dispatch_dev("SvelteRegisterComponent", { component: this, tagName: "App", options, id: create_fragment$3.name });
    	}
    }

    const app = new App({
    	target: document.body,
    	props: {}
    });

    return app;

}());
//# sourceMappingURL=bundle.js.map
