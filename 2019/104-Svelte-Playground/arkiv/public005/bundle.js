var app=function(){"use strict";function t(){}function n(t){return t()}function e(){return Object.create(null)}function r(t){t.forEach(n)}function o(t){return"function"==typeof t}function a(t,n){return t!=t?n==n:t!==n||t&&"object"==typeof t||"function"==typeof t}function c(t,n){t.appendChild(n)}function p(t,n,e){t.insertBefore(n,e||null)}function s(t){t.parentNode.removeChild(t)}function u(t,n){for(let e=0;e<t.length;e+=1)t[e]&&t[e].d(n)}function i(t){return document.createElement(t)}function l(t){return document.createTextNode(t)}function f(){return l(" ")}function d(t,n,e,r){return t.addEventListener(n,e,r),()=>t.removeEventListener(n,e,r)}function h(t,n,e){null==e?t.removeAttribute(n):t.setAttribute(n,e)}function m(t,n){n=""+n,t.data!==n&&(t.data=n)}function $(t,n){(null!=n||t.value)&&(t.value=n)}let y;function g(t){y=t}const v=[],b=[],x=[],k=[],_=Promise.resolve();let M=!1;function w(t){x.push(t)}function E(){const t=new Set;do{for(;v.length;){const t=v.shift();g(t),j(t.$$)}for(;b.length;)b.pop()();for(let n=0;n<x.length;n+=1){const e=x[n];t.has(e)||(e(),t.add(e))}x.length=0}while(v.length);for(;k.length;)k.pop()();M=!1}function j(t){t.fragment&&(t.update(t.dirty),r(t.before_update),t.fragment.p(t.dirty,t.ctx),t.dirty=null,t.after_update.forEach(w))}const N=new Set;function O(t,n){t.$$.dirty||(v.push(t),M||(M=!0,_.then(E)),t.$$.dirty=e()),t.$$.dirty[n]=!0}function A(a,c,p,s,u,i){const l=y;g(a);const f=c.props||{},d=a.$$={fragment:null,ctx:null,props:i,update:t,not_equal:u,bound:e(),on_mount:[],on_destroy:[],before_update:[],after_update:[],context:new Map(l?l.$$.context:[]),callbacks:e(),dirty:null};let h=!1;var m,$,v;d.ctx=p?p(a,f,(t,n,e=n)=>(d.ctx&&u(d.ctx[t],d.ctx[t]=e)&&(d.bound[t]&&d.bound[t](e),h&&O(a,t)),n)):f,d.update(),h=!0,r(d.before_update),d.fragment=s(d.ctx),c.target&&(c.hydrate?d.fragment.l((v=c.target,Array.from(v.childNodes))):d.fragment.c(),c.intro&&((m=a.$$.fragment)&&m.i&&(N.delete(m),m.i($))),function(t,e,a){const{fragment:c,on_mount:p,on_destroy:s,after_update:u}=t.$$;c.m(e,a),w(()=>{const e=p.map(n).filter(o);s?s.push(...e):r(e),t.$$.on_mount=[]}),u.forEach(w)}(a,c.target,c.anchor),E()),g(l)}class q{$destroy(){var n,e;e=1,(n=this).$$.fragment&&(r(n.$$.on_destroy),n.$$.fragment.d(e),n.$$.on_destroy=n.$$.fragment=null,n.$$.ctx={}),this.$destroy=t}$on(t,n){const e=this.$$.callbacks[t]||(this.$$.callbacks[t]=[]);return e.push(n),()=>{const t=e.indexOf(n);-1!==t&&e.splice(t,1)}}$set(){}}function P(t,n,e){const r=Object.create(t);return r.item=n[e],r}function C(t,n,e){const r=Object.create(t);return r.par=n[e],r}function F(t){var n,e,r=Object.keys(t.par).join(" ")+"";return{c(){n=i("div"),e=l(r),h(n,"class","svelte-1ev848y")},m(t,r){p(t,n,r),c(n,e)},p(t,n){(t.par0||t.par1||t.par2)&&r!==(r=Object.keys(n.par).join(" ")+"")&&m(e,r)},d(t){t&&s(n)}}}function I(t){var n,e,r=t.item+"";return{c(){n=i("div"),e=l(r),h(n,"class","svelte-1ev848y")},m(t,r){p(t,n,r),c(n,e)},p(t,n){t.stack&&r!==(r=n.item+"")&&m(e,r)},d(t){t&&s(n)}}}function L(n){var e,o,a,m,y,g,v,b=n.document.title+"";let x=[n.par0,n.par1,n.par2],k=[];for(let t=0;t<3;t+=1)k[t]=F(C(n,x,t));let _=n.stack,M=[];for(let t=0;t<_.length;t+=1)M[t]=I(P(n,_,t));return{c(){e=i("div"),o=l(b),a=f();for(let t=0;t<3;t+=1)k[t].c();m=f();for(let t=0;t<M.length;t+=1)M[t].c();y=f(),g=i("input"),h(e,"class","svelte-1ev848y"),h(g,"type","text"),h(g,"placeholder","Enter commands separated with spaces"),h(g,"class","svelte-1ev848y"),v=[d(g,"input",n.input_input_handler),d(g,"keyup",n.onkeyup)]},m(t,r){p(t,e,r),c(e,o),p(t,a,r);for(let n=0;n<3;n+=1)k[n].m(t,r);p(t,m,r);for(let n=0;n<M.length;n+=1)M[n].m(t,r);p(t,y,r),p(t,g,r),$(g,n.commands)},p(t,n){if(t.par0||t.par1||t.par2){let e;for(x=[n.par0,n.par1,n.par2],e=0;e<x.length;e+=1){const r=C(n,x,e);k[e]?k[e].p(t,r):(k[e]=F(r),k[e].c(),k[e].m(m.parentNode,m))}for(;e<3;e+=1)k[e].d(1)}if(t.stack){let e;for(_=n.stack,e=0;e<_.length;e+=1){const r=P(n,_,e);M[e]?M[e].p(t,r):(M[e]=I(r),M[e].c(),M[e].m(y.parentNode,y))}for(;e<M.length;e+=1)M[e].d(1);M.length=_.length}t.commands&&g.value!==n.commands&&$(g,n.commands)},i:t,o:t,d(t){t&&(s(e),s(a)),u(k,t),t&&s(m),u(M,t),t&&(s(y),s(g)),r(v)}}}function S(t,n,e){document.title="RPN Calculator";let r=[],o=[],a="";const c={},p={},s={};e("par0",c.drop=(()=>r.pop()),c),e("par0",c.pi=(()=>r.push(Math.PI)),c),e("par0",c.e=(()=>r.push(Math.E)),c),e("par0",c.swap=(()=>r.push(r.pop(),r.pop())),c),e("par0",c.clr=(()=>e("stack",r=[])),c),e("par1",p.abs=(t=>Math.abs(t)),p),e("par1",p["x^2"]=(t=>t*t),p),e("par1",p["10^x"]=(t=>10**t),p),e("par1",p.log=(t=>Math.log10(t)),p),e("par1",p.exp=(t=>Math.exp(t)),p),e("par1",p.ln=(t=>Math.log(t)),p),e("par1",p.sqrt=(t=>Math.sqrt(t)),p),e("par1",p.chs=(t=>-t),p),e("par1",p["1/x"]=(t=>1/t),p),e("par1",p.sin=(t=>Math.sin(t/180*Math.PI)),p),e("par2",s["+"]=((t,n)=>n+t),s),e("par2",s["*"]=((t,n)=>n*t),s),e("par2",s["-"]=((t,n)=>n-t),s),e("par2",s["/"]=((t,n)=>n/t),s),e("par2",s["y^x"]=((t,n)=>n**t),s),e("par2",s.pyth=((t,n)=>Math.sqrt(t*t+n*n)),s),e("par2",s.s=((t,n)=>n+t),s),e("par2",s.p=((t,n)=>t*n/(t+n)),s);const u=t=>{t in c?c[t]():t in p?r.push(p[t](r.pop())):t in s?r.push(s[t](r.pop(),r.pop())):isNaN(parseFloat(t))||r.push(parseFloat(t))};function i(t){0!=o.length&&(-1==t?o.push(o.shift()):o.unshift(o.pop()),e("commands",a=o[0]))}return{stack:r,commands:a,par0:c,par1:p,par2:s,onkeyup:function(t){"Escape"==t.key?e("commands",a=""):"ArrowUp"==t.key?i(-1):"ArrowDown"==t.key?i(1):"Enter"==t.key&&(a.split(" ").map(t=>{u(t)}),o.includes(a)||o.push(a),e("commands",a=""),e("stack",r))},document:document,input_input_handler:function(){a=this.value,e("commands",a)}}}return new class extends q{constructor(t){super(),A(this,t,S,L,a,[])}}({target:document.body,props:{}})}();
//# sourceMappingURL=bundle.js.map
