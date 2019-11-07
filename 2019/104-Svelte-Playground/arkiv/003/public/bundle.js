var app=function(){"use strict";function t(){}function n(t){return t()}function e(){return Object.create(null)}function r(t){t.forEach(n)}function o(t){return"function"==typeof t}function l(t,n){return t!=t?n==n:t!==n||t&&"object"==typeof t||"function"==typeof t}function a(t,n){t.appendChild(n)}function c(t,n,e){t.insertBefore(n,e||null)}function i(t){t.parentNode.removeChild(t)}function u(t){return document.createElement(t)}function s(t){return document.createTextNode(t)}function p(){return s(" ")}function f(t,n,e,r){return t.addEventListener(n,e,r),()=>t.removeEventListener(n,e,r)}function d(t,n,e){null==e?t.removeAttribute(n):t.setAttribute(n,e)}function m(t){return""===t?void 0:+t}function h(t,n){n=""+n,t.data!==n&&(t.data=n)}function y(t,n){(null!=n||t.value)&&(t.value=n)}let $;function g(t){$=t}function _(){const t=$;return(n,e)=>{const r=t.$$.callbacks[n];if(r){const o=function(t,n){const e=document.createEvent("CustomEvent");return e.initCustomEvent(t,!1,!1,n),e}(n,e);r.slice().forEach(n=>{n.call(t,o)})}}}const b=[],v=[],x=[],k=[],w=Promise.resolve();let C=!1;function P(t){x.push(t)}function E(){const t=new Set;do{for(;b.length;){const t=b.shift();g(t),N(t.$$)}for(;v.length;)v.pop()();for(let n=0;n<x.length;n+=1){const e=x[n];t.has(e)||(e(),t.add(e))}x.length=0}while(b.length);for(;k.length;)k.pop()();C=!1}function N(t){t.fragment&&(t.update(t.dirty),r(t.before_update),t.fragment.p(t.dirty,t.ctx),t.dirty=null,t.after_update.forEach(P))}const S=new Set;let A;function j(t,n){t&&t.i&&(S.delete(t),t.i(n))}function L(t,n,e,r){if(t&&t.o){if(S.has(t))return;S.add(t),A.c.push(()=>{S.delete(t),r&&(e&&t.d(1),r())}),t.o(n)}}function O(t,e,l){const{fragment:a,on_mount:c,on_destroy:i,after_update:u}=t.$$;a.m(e,l),P(()=>{const e=c.map(n).filter(o);i?i.push(...e):r(e),t.$$.on_mount=[]}),u.forEach(P)}function B(t,n){t.$$.fragment&&(r(t.$$.on_destroy),t.$$.fragment.d(n),t.$$.on_destroy=t.$$.fragment=null,t.$$.ctx={})}function M(t,n){t.$$.dirty||(b.push(t),C||(C=!0,w.then(E)),t.$$.dirty=e()),t.$$.dirty[n]=!0}function T(n,o,l,a,c,i){const u=$;g(n);const s=o.props||{},p=n.$$={fragment:null,ctx:null,props:i,update:t,not_equal:c,bound:e(),on_mount:[],on_destroy:[],before_update:[],after_update:[],context:new Map(u?u.$$.context:[]),callbacks:e(),dirty:null};let f=!1;var d;p.ctx=l?l(n,s,(t,e,r=e)=>(p.ctx&&c(p.ctx[t],p.ctx[t]=r)&&(p.bound[t]&&p.bound[t](r),f&&M(n,t)),e)):s,p.update(),f=!0,r(p.before_update),p.fragment=a(p.ctx),o.target&&(o.hydrate?p.fragment.l((d=o.target,Array.from(d.childNodes))):p.fragment.c(),o.intro&&j(n.$$.fragment),O(n,o.target,o.anchor),E()),g(u)}class q{$destroy(){B(this,1),this.$destroy=t}$on(t,n){const e=this.$$.callbacks[t]||(this.$$.callbacks[t]=[]);return e.push(n),()=>{const t=e.indexOf(n);-1!==t&&e.splice(t,1)}}$set(){}}function D(n){var e;return{c(){(e=u("div")).innerHTML="<h1>Player Scoreboard</h1>",d(e,"class","navbar bg-primary")},m(t,n){c(t,e,n)},p:t,i:t,o:t,d(t){t&&i(e)}}}class H extends q{constructor(t){super(),T(this,t,null,D,l,[])}}function z(t){var n;return{c(){n=s("+")},m(t,e){c(t,n,e)},d(t){t&&i(n)}}}function F(t){var n;return{c(){n=s("-")},m(t,e){c(t,n,e)},d(t){t&&i(n)}}}function G(t){var n,e,o,l,a,s,m=!1;function h(){m=!0,t.input_input_handler.call(a)}return{c(){(n=u("button")).textContent="+1",e=p(),(o=u("button")).textContent="-1",l=p(),a=u("input"),d(n,"class","btn"),d(o,"class","btn"),d(a,"type","number"),s=[f(n,"click",t.click_handler_1),f(o,"click",t.click_handler_2),f(a,"input",h)]},m(r,i){c(r,n,i),c(r,e,i),c(r,o,i),c(r,l,i),c(r,a,i),y(a,t.points)},p(t,n){!m&&t.points&&y(a,n.points),m=!1},d(t){t&&(i(n),i(e),i(o),i(l),i(a)),r(s)}}}function I(n){var e,o,l,m,y,$,g,_,b,v,x,k,w;function C(t,n){return n.showControls?F:z}var P=C(0,n),E=P(n),N=n.showControls&&G(n);return{c(){e=u("div"),o=u("h1"),l=s(n.name),m=p(),y=u("button"),E.c(),$=p(),(g=u("button")).textContent="x",_=p(),b=u("h3"),v=s("Points: "),x=s(n.points),k=p(),N&&N.c(),d(y,"class","btn btn-sm"),d(o,"class","svelte-19m7yfr"),d(e,"class","card"),w=[f(y,"click",n.click_handler),f(g,"click",n.deletePlayer)]},m(t,n){c(t,e,n),a(e,o),a(o,l),a(o,m),a(o,y),E.m(y,null),a(o,$),a(o,g),a(e,_),a(e,b),a(b,v),a(b,x),a(e,k),N&&N.m(e,null)},p(t,n){t.name&&h(l,n.name),P!==(P=C(0,n))&&(E.d(1),(E=P(n))&&(E.c(),E.m(y,null))),t.points&&h(x,n.points),n.showControls?N?N.p(t,n):((N=G(n)).c(),N.m(e,null)):N&&(N.d(1),N=null)},i:t,o:t,d(t){t&&i(e),E.d(),N&&N.d(),r(w)}}}function J(t,n,e){const r=_();let{name:o,points:l}=n,a=!1;return t.$set=(t=>{"name"in t&&e("name",o=t.name),"points"in t&&e("points",l=t.points)}),{name:o,points:l,showControls:a,deletePlayer:()=>r("deleteplayer",o),click_handler:()=>e("showControls",a=!a),click_handler_1:()=>e("points",l+=1),click_handler_2:()=>e("points",l-=1),input_input_handler:function(){l=m(this.value),e("points",l)}}}class K extends q{constructor(t){super(),T(this,t,J,I,l,["name","points"])}}function Q(n){var e,o,l,s,m,h,$,g=!1;function _(){g=!0,n.input1_input_handler.call(s)}return{c(){e=u("form"),o=u("input"),l=p(),s=u("input"),m=p(),h=u("input"),d(o,"type","text"),d(o,"placeholder","Player Name"),d(s,"type","number"),d(s,"placeholder","Player Points"),d(h,"type","submit"),d(h,"class","btn btn-primary"),h.value="Add Player",d(e,"class","grid-3"),$=[f(o,"input",n.input0_input_handler),f(s,"input",_),f(e,"submit",n.onSubmit)]},m(t,r){c(t,e,r),a(e,o),y(o,n.player.name),a(e,l),a(e,s),y(s,n.player.points),a(e,m),a(e,h)},p(t,n){t.player&&o.value!==n.player.name&&y(o,n.player.name),!g&&t.player&&y(s,n.player.points),g=!1},i:t,o:t,d(t){t&&i(e),r($)}}}function R(t,n,e){const r=_();let o={name:"",points:0};return{player:o,onSubmit:t=>{t.preventDefault(),r("addplayer",o),e("player",o={name:"",points:0})},input0_input_handler:function(){o.name=this.value,e("player",o)},input1_input_handler:function(){o.points=m(this.value),e("player",o)}}}class U extends q{constructor(t){super(),T(this,t,R,Q,l,[])}}function V(t,n,e){const r=Object.create(t);return r.player=n[e],r}function W(t){var n,e=new K({props:{name:t.player.name,points:t.player.points}});return e.$on("deleteplayer",t.deletePlayer),{c(){e.$$.fragment.c()},m(t,r){O(e,t,r),n=!0},p(t,n){var r={};t.players&&(r.name=n.player.name),t.players&&(r.points=n.player.points),e.$set(r)},i(t){n||(j(e.$$.fragment,t),n=!0)},o(t){L(e.$$.fragment,t),n=!1},d(t){B(e,t)}}}function X(t){var n,e,o,l,s=new H({}),f=new U({});f.$on("addplayer",t.addplayer_handler);let m=t.players,h=[];for(let n=0;n<m.length;n+=1)h[n]=W(V(t,m,n));const y=t=>L(h[t],1,1,()=>{h[t]=null});return{c(){s.$$.fragment.c(),n=p(),e=u("div"),f.$$.fragment.c(),o=p();for(let t=0;t<h.length;t+=1)h[t].c();d(e,"class","container")},m(t,r){O(s,t,r),c(t,n,r),c(t,e,r),O(f,e,null),a(e,o);for(let t=0;t<h.length;t+=1)h[t].m(e,null);l=!0},p(t,n){if(t.players){let o;for(m=n.players,o=0;o<m.length;o+=1){const r=V(n,m,o);h[o]?(h[o].p(t,r),j(h[o],1)):(h[o]=W(r),h[o].c(),j(h[o],1),h[o].m(e,null))}for(A={r:0,c:[],p:A},o=m.length;o<h.length;o+=1)y(o);A.r||r(A.c),A=A.p}},i(t){if(!l){j(s.$$.fragment,t),j(f.$$.fragment,t);for(let t=0;t<m.length;t+=1)j(h[t]);l=!0}},o(t){L(s.$$.fragment,t),L(f.$$.fragment,t),h=h.filter(Boolean);for(let t=0;t<h.length;t+=1)L(h[t]);l=!1},d(t){B(s,t),t&&(i(n),i(e)),B(f),function(t,n){for(let e=0;e<t.length;e+=1)t[e]&&t[e].d(n)}(h,t)}}}function Y(t,n,e){let r=[{name:"Christer",points:100},{name:"Numa",points:200}];return{players:r,deletePlayer:t=>{e("players",r=r.filter(n=>n.name!=t.detail))},addplayer_handler:t=>e("players",r=[...r,t.detail])}}return new class extends q{constructor(t){super(),T(this,t,Y,X,l,[])}}({target:document.body,props:{}})}();
//# sourceMappingURL=bundle.js.map